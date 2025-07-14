import cv2
import time
import numpy as np
import matplotlib.pyplot as plt
from hand_pose_detector import HandPoseDetector
from flircam import Flircam

# Initialize camera
cam = Flircam()
cam.start()

# Calibration: pick two points to define a horizontal reference line
y_points = []

def on_mouse(event, x, y, flags, param):
    global y_points
    if event == cv2.EVENT_LBUTTONDOWN and len(y_points) < 2:
        y_points.append(y)
        print(f"Point {len(y_points)}: (x={x}, y={y})")

# Grab one frame for calibration
frame, ts = cam.read_frame()
if not frame.any():
    print("Failed to grab frame for calibration")
    cam.cleanup()
    exit(1)

calib_frame = frame.copy()
cv2.namedWindow("Calibration")
cv2.setMouseCallback("Calibration", on_mouse)
print("Click two points to define a horizontal line.")
while len(y_points) < 2:
    disp = calib_frame.copy()
    for py in y_points:
        cv2.line(disp, (0, py), (disp.shape[1], py), (0,255,0), 2)
    cv2.imshow("Calibration", disp)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        print("Calibration aborted")
        cam.cleanup()
        cv2.destroyAllWindows()
        exit(0)

cv2.destroyWindow("Calibration")
y_line = int(sum(y_points) / 2)
print(f"Reference line at y = {y_line}")

# Initialize detector and data storage
detector = HandPoseDetector()
distances = []  # vertical offsets from y_line

print("Starting data collection. Press 'q' to stop.")

# Main loop
delay = 1  # no delay bias
do_capture = True
while do_capture:
    frame, ts = cam.read_frame()
    if not frame.any():
        break
    # Detect hands
    hands = detector.detect_hand_pose(frame)
    if hands:
        for hand in hands:
            # Compute average y of landmarks 5 to 20 only
            ys = [hand['landmarks'].landmark[i].y * frame.shape[0] for i in range(17, 20)]
            avg_y = np.mean(ys)
            # Vertical offset noise
            dist = -(avg_y - y_line)
            distances.append(dist)

    # Draw line and show
    cv2.line(frame, (0, y_line), (frame.shape[1], y_line), (255,0,0), 2)
    cv2.imshow("Hand Noise", frame)
    if cv2.waitKey(delay) & 0xFF == ord('q'):
        do_capture = False

# Cleanup
cam.cleanup()
cv2.destroyAllWindows()

# Convert to numpy array and compute stats
dist_arr = np.array(distances)
mean_offset = np.mean(dist_arr)
std_offset = np.std(dist_arr)
print(f"Mean vertical offset: {mean_offset:.2f} pixels")
print(f"Standard deviation: {std_offset:.2f} pixels")

# Plot noise over time
plt.figure()
plt.plot(dist_arr)
plt.title('Vertical Noise Over Time')
plt.xlabel('Frame Index')
plt.ylabel('Offset (px)')
plt.grid(True)
plt.show()
