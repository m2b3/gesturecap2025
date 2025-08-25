import cv2
import numpy as np
from utils.hand_pose_detector import HandPoseDetector
from video.flircam import Flircam

"""
Calibration script:
- Grabs a frame from FLIR camera
- Lets user click two points to define horizontal reference line
- Collects noise samples for N frames while hand is steady
- Computes and prints reference line Y, noise standard deviation and mean
- Saves results to calibration.json (or prints to stdout)
"""

def calibrate_and_save(n_noise_frames=100, output_file='config/calibration.json'):
    cam = Flircam()

    # Grab frame for line calibration
    frame, _, _ = cam.read_frame()
    if not frame.any():
        print("Failed to grab calibration frame")
        cam.cleanup()
        return

    # Mouse callback to pick two points
    y_points = []
    def on_mouse(event, x, y, flags, param):
        nonlocal y_points
        if event == cv2.EVENT_LBUTTONDOWN and len(y_points) < 2:
            y_points.append(y)
            print(f"Point {len(y_points)}: (x={x}, y={y})")

    cv2.namedWindow('Calibrate Line')
    cv2.setMouseCallback('Calibrate Line', on_mouse)
    print("Click two points to define the reference horizontal line.")
    while len(y_points) < 2:
        disp = frame.copy()
        for py in y_points:
            cv2.line(disp, (0, py), (disp.shape[1], py), (0,255,0), 2)
        cv2.imshow('Calibrate Line', disp)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            print("Calibration aborted by user.")
            cam.cleanup(); cv2.destroyAllWindows(); return
    cv2.destroyWindow('Calibrate Line')

    y_line = int(sum(y_points)/2)
    print(f"Reference line Y: {y_line}")

    # Noise sampling
    distances = []
    detector = HandPoseDetector()
    print(f"Collecting noise for {n_noise_frames} frames...")
    count = 0
    while count < n_noise_frames:
        f, ts, _= cam.read_frame()
        if not f.any(): break
        hands = detector.detect_hand_pose(f)
        if hands:
            for hand in hands:
                ys = [hand['landmarks'].landmark[i].y * f.shape[0] for i in range(17, 21)]
                avg_y = np.mean(ys)
                distances.append(abs(avg_y - y_line))
        count += 1
        cv2.line(f, (0, y_line), (f.shape[1], y_line), (255,0,0), 2)
        cv2.imshow('Noise Sample', f)
        if cv2.waitKey(1) & 0xFF == ord('q'): break
    cv2.destroyWindow('Noise Sample')

    dist_arr = np.array(distances)
    std_offset = float(np.std(dist_arr))
    mean_offset = np.mean(dist_arr)
    print(f"Noise std deviation: {std_offset:.2f} px")

    # Save to file
    import json
    with open(output_file, 'w+') as fp:
        json.dump({'y_line': y_line, 'std_offset': std_offset, 'mean_offset':mean_offset}, fp)
    print(f"Calibration saved to {output_file}")
    cam.cleanup()

if __name__ == '__main__':
    calibrate_and_save()