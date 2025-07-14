import cv2
import time
import json
import numpy as np
from pythonosc import udp_client
from flircam import Flircam
from hand_pose_detector import HandPoseDetector

"""
Main tap-detection script:
- Loads calibration results (y_line, std_offset)
- Detects hand and uses std_offset as threshold
- Sends OSC on tap
"""

def load_calibration(calib_file='calibration.json'):
    with open(calib_file, 'r') as fp:
        data = json.load(fp)
    return data['y_line'], data['std_offset'], data['mean_offset']


def main_loop():
    # Load calibration
    y_line, stdev, mean = load_calibration()
    threshold = mean + 3*stdev

    print(f"Using y_line={y_line}, threshold={threshold:.2f}px")


    # Setup
    cam = Flircam(); cam.start()
    osc_ip, osc_port = '127.0.0.1', 11111
    client = udp_client.SimpleUDPClient(osc_ip, osc_port)
    detector = HandPoseDetector()

    # fps = 60; delay = int(1000/fps)
    state, counter = 0, 0
    print("Starting hand-tap detection. Press 'q' to exit.")

    while True:
        frame, ts = cam.read_frame()
        if not frame.any(): break
        hands = detector.detect_hand_pose(frame)
        tapped = False
        if hands:
            for hand in hands:
                # if hand.get('label','').lower() == 'left': continue
                if hand.get('label','').lower() == 'right': continue
                ys = [hand['landmarks'].landmark[i].y * frame.shape[0] for i in range(17, 21)]
                avg_y = np.mean(ys)
                dist = abs(avg_y - y_line)
                # print(dist)
                if dist >= threshold and state == 1:
                    state = 0
                elif dist < threshold and state == 0:
                    state = 1; tapped = True; counter += 1
                    print(f"Tap #{counter}")
                    client.send_message('/trigger', 1)
        # draw line
        cv2.line(frame, (0,y_line), (frame.shape[1],y_line), (255,0,0), 2)
        cv2.imshow('Hand Tap', frame)
        if cv2.waitKey(1) & 0xFF == ord('q'): break

    cam.cleanup(); cv2.destroyAllWindows()

if __name__ == '__main__':
    main_loop()
