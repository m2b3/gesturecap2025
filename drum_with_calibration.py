import cv2
import time
import json
import numpy as np
from pythonosc import udp_client
from flircam import Flircam
from hand_pose_detector import HandPoseDetector

"""
Main tap-detection script with frame-buffering:
- Loads calibration results (y_line, std_offset, mean_offset)
- Detects hand taps and sends OSC on tap
- Buffers frames at tap moments with their frame numbers
- After exit, dumps buffered frames (with overlaid frame numbers) to a video file
- Prints total elapsed recording time
"""

def load_calibration(calib_file='calibration.json'):
    with open(calib_file, 'r') as fp:
        data = json.load(fp)
    return data['y_line'], data['std_offset'], data['mean_offset']


def main_loop(output_video='taps_output.avi', buffer_size=None):
    # Load calibration
    y_line, stdev, mean = load_calibration()
    threshold = mean + 3 * stdev
    print(f"Using y_line={y_line}, threshold={threshold:.2f}px")

    # Setup camera, OSC, detector
    cam = Flircam(); cam.start()
    osc_ip, osc_port = '127.0.0.1', 11111
    client = udp_client.SimpleUDPClient(osc_ip, osc_port)
    detector = HandPoseDetector()

    # Frame and state variables
    frame_idx = 0
    state = 0
    tap_counter = 0
    taps_buffer = []  # list of (frame, frame_idx)

    # Start timing
    start_time = time.time()
    print("Starting hand-tap detection. Press 'q' to exit.")

    while True:
        frame, ts = cam.read_frame()
        if not frame.any():
            # no more frames
            break
        frame_idx += 1
        hands = detector.detect_hand_pose(frame)
        tapped = False
        buf_frame = frame.copy()

        if hands:
            for hand in hands:
                if hand.get('label', '').lower() == 'right':
                    continue
                # Get y-coords for tip landmarks 17-20
                ys = [hand['landmarks'].landmark[i].y * frame.shape[0] for i in range(17, 21)]
                avg_y = np.mean(ys)
                dist = abs(avg_y - y_line)

                # State machine: detect crossing below threshold
                if dist >= threshold and state == 1:
                    state = 0
                elif dist < threshold and state == 0:
                    state = 1
                    tapped = True
                    tap_counter += 1
                    print(f"Tap #{tap_counter} at frame {frame_idx}")
                    client.send_message('/trigger', 1)
                    # Buffer this frame with overlay
                    cv2.putText(buf_frame, f"Trigger Frame: {frame_idx}", (10,30),
                                cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
        cv2.putText(buf_frame, f"Timestamp(s): {ts}", (10,60),
                    cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
        taps_buffer.append((buf_frame, frame_idx))

        # Draw calibration line
        cv2.line(frame, (0, y_line), (frame.shape[1], y_line), (255, 0, 0), 2)
        cv2.imshow('Hand Tap', frame)

        # Exit on 'q'
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # Cleanup camera and UI
    cam.cleanup()
    cv2.destroyAllWindows()

    # Dump buffered tap frames to video
    if taps_buffer:
        # Determine video writer settings
        h, w = taps_buffer[0][0].shape[:2]
        fourcc = cv2.VideoWriter_fourcc(*'XVID')  # or 'MJPG', 'MP4V'
        fps = 30  # adjust as needed
        out = cv2.VideoWriter(output_video, fourcc, fps, (w, h))
        for buf_frame, idx in taps_buffer:
            out.write(buf_frame)
        out.release()
        print(f"Buffered {len(taps_buffer)} tap frames written to {output_video}")
    else:
        print("No taps detected; no video written.")

    # Compute and print elapsed time
    elapsed = time.time() - start_time
    print(f"Total recording elapsed time: {elapsed:.2f} seconds")


if __name__ == '__main__':
    main_loop()
