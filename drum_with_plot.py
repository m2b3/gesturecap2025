import cv2
import time
import json
import numpy as np
import matplotlib.pyplot as plt
from pythonosc import udp_client
from flircam import Flircam
from hand_pose_detector import HandPoseDetector

"""
Main tap-detection script with timing plot in milliseconds:
- Loads calibration results (y_line, std_offset, mean_offset)
- Detects hand and uses std_offset as threshold
- Sends OSC on tap
- Records mid-loop and end-loop timings per frame (ms)
- Plots both timing series after exit, with statistics
"""

def load_calibration(calib_file='calibration.json'):
    with open(calib_file, 'r') as fp:
        data = json.load(fp)
    return data['y_line'], data['std_offset'], data['mean_offset']


def main_loop():
    # Load calibration
    y_line, stdev, mean = load_calibration()
    threshold = mean + 3 * stdev
    print(f"Using y_line={y_line}, threshold={threshold:.2f}px")

    # Setup
    cam = Flircam(); cam.start()
    osc_ip, osc_port = '127.0.0.1', 11111
    client = udp_client.SimpleUDPClient(osc_ip, osc_port)
    detector = HandPoseDetector()

    # Timing containers (milliseconds)
    mid_times = []  # ms to midpoint
    end_times = []  # ms for full loop

    print("Starting hand-tap detection. Press 'q' to exit.")

    while True:
        t0 = time.time()
        frame, ts = cam.read_frame()
        if not frame.any():
            break

        # Hand detection and tap logic
        hands = detector.detect_hand_pose(frame)
        state = getattr(main_loop, 'state', 0)
        for hand in hands or []:
            if hand.get('label', '').lower() == 'right':
                continue
            ys = [hand['landmarks'].landmark[i].y * frame.shape[0] for i in range(17, 21)]
            avg_y = np.mean(ys)
            dist = abs(avg_y - y_line)
            if not hasattr(main_loop, 'counter'):
                main_loop.counter = 0
            if dist >= threshold and state == 1:
                state = 0
            elif dist < threshold and state == 0:
                state = 1
                main_loop.counter += 1
                print(f"Tap #{main_loop.counter}")
                client.send_message('/trigger', 1)
        main_loop.state = state

        # Record midpoint timing in ms
        t_mid = (time.time() - t0) * 1000
        mid_times.append(t_mid)

        # Display frame
        cv2.line(frame, (0, y_line), (frame.shape[1], y_line), (255, 0, 0), 2)
        cv2.imshow('Hand Tap', frame)

        # Exit on 'q', record final end timing
        if cv2.waitKey(1) & 0xFF == ord('q'):
            tend = (time.time() - t0) * 1000
            end_times.append(tend)
            break

        # Record end timing in ms
        tend = (time.time() - t0) * 1000
        end_times.append(tend)

    # Cleanup
    cam.cleanup()
    cv2.destroyAllWindows()

    # Align list lengths
    n = min(len(mid_times), len(end_times))
    mid = np.array(mid_times[:n])
    end = np.array(end_times[:n])
    frames = np.arange(n)

    # Compute statistics (ms)
    mid_mean = mid.mean()
    mid_std = mid.std()
    mid_min = mid.min()
    print(mid_min)
    end_mean = end.mean()
    end_std = end.std()
    diff_mean = end_mean - mid_mean

    # Plot in ms with stats
    plt.figure(figsize=(10, 5))
    plt.plot(frames, mid, label=f"Mid-loop (μ={mid_mean:.1f}ms, σ={mid_std:.1f}ms)")
    plt.plot(frames, end, label=f"End-loop (μ={end_mean:.1f}ms, σ={end_std:.1f}ms, Δμ={diff_mean:.1f}ms)")
    plt.xlabel('Frame Index')
    plt.ylabel('Duration (ms)')
    plt.title('Per-frame Processing Times (ms)')
    plt.legend()
    plt.grid(True)
    plt.show()

if __name__ == '__main__':
    main_loop()
