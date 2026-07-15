import cv2
import argparse
import json
from utils.hand_pose_detector import HandPoseDetector
from gestures.tap_mapper import TapMapper
from gestures.pinch_mapper import PinchMapper
from gestures.velocity_mapper import VelocityMapper

"""
Preview script for testing gesture mappers with a webcam.
Runs detection in a single process with visual feedback.
No FLIR hardware or multiprocessing pipeline required.

Usage:
    python preview_gestures.py --gesture tap --camera 0
    python preview_gestures.py --gesture pinch
    python preview_gestures.py --gesture velocity
"""

GESTURE_CLASSES = {
    'tap': TapMapper,
    'pinch': PinchMapper,
    'velocity': VelocityMapper,
}

# fallback calibration values if config/calibration.json doesn't exist
DEFAULT_CALIBRATION = {
    'y_line': 270,
    'std_offset': 15.0,
    'mean_offset': 20.0,
    'pinch_max_dist': 200.0,
    'pinch_threshold': 40.0,
    'velocity_max': 2000.0,
    'swipe_threshold': 800.0,
}


def load_calibration(calib_file):
    try:
        with open(calib_file, 'r') as fp:
            return json.load(fp)
    except FileNotFoundError:
        print(f"No calibration file at {calib_file}, using defaults")
        return DEFAULT_CALIBRATION


def draw_status(frame, messages, gesture_name):
    y = 30
    cv2.putText(frame, f'Gesture: {gesture_name}', (10, y),
                cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 0), 2)
    for addr, val in messages:
        y += 30
        cv2.putText(frame, f'{addr}: {val}', (10, y),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 200, 255), 2)


def main():
    parser = argparse.ArgumentParser(description='Preview gesture detection with webcam')
    parser.add_argument('--gesture', choices=list(GESTURE_CLASSES.keys()),
                        default='tap', help='Gesture mapper to use')
    parser.add_argument('--camera', type=int, default=0, help='Camera index')
    parser.add_argument('--calibration', default='config/calibration.json',
                        help='Path to calibration file')
    args = parser.parse_args()

    calib = load_calibration(args.calibration)

    mapper = GESTURE_CLASSES[args.gesture]()
    mapper.configure(calib)

    detector = HandPoseDetector(device='cpu')
    cap = cv2.VideoCapture(args.camera)

    if not cap.isOpened():
        print(f"Failed to open camera {args.camera}")
        return

    print(f"Running {args.gesture} gesture detection. Press 'q' to quit.")

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        hands = detector.detect_hand_pose(frame)
        messages = mapper.process(hands, frame.shape)
        draw_status(frame, messages, args.gesture)

        cv2.imshow('Gesture Preview', frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
