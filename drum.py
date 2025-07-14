import cv2
import time
import math
from hand_pose_detector import HandPoseDetector
from pythonosc import udp_client
from flircam import Flircam

# Initialize hand pose detector and video capture
# cap = cv2.VideoCapture(0)  # or replace with your video source
cam = Flircam()
cam.start()
# For file input, after calibration we reset to frame 0

# Initialize OSC client
osc_ip = "127.0.0.1"
osc_port = 11111
client = udp_client.SimpleUDPClient(osc_ip, osc_port)

# Calibration: pick two points to define a horizontal reference line
y_points = []

# Mouse callback to collect clicks
def on_mouse(event, x, y, flags, param):
    global y_points
    if event == cv2.EVENT_LBUTTONDOWN:
        y_points.append(y)
        print(f"Point {len(y_points)}: (x={x}, y={y})")

# Read one frame for calibration
# ret, frame = cap.read()
frame, ts = cam.read_frame()

if not frame.any():
    print("Failed to grab frame for calibration")
    # cap.release()
    cam.cleanup()
    exit(1)

# frame = cv2.flip(frame, 1)
calib_frame = frame.copy()

cv2.namedWindow("Calibration")
cv2.setMouseCallback("Calibration", on_mouse)

print("Click two points to define a horizontal line.")
while True:
    display = calib_frame.copy()
    # Draw clicked points
    for py in y_points:
        cv2.line(display, (0, py), (display.shape[1], py), (0, 255, 0), 2)
    cv2.imshow("Calibration", display)
    if len(y_points) >= 2:
        break
    if cv2.waitKey(1) & 0xFF == ord('q'):
        print("Calibration aborted by user")
        # cap.release()
        cam.cleanup()
        cv2.destroyAllWindows()
        exit(0)

cv2.destroyWindow("Calibration")

# Compute reference line Y coordinate (average of two clicks)
y_line = int(sum(y_points[:2]) / 2)
print(f"Reference horizontal line at y = {y_line}")

# Main loop parameters
fps = 60
delay = int(1000 / fps)
state = 0  # For left hand tap logic
counter = 0

# Latency arrays
total_latency_array = []
frame_latency_array = []
processing_latency_array = []
audio_latency_array = []

# Start processing loop
detector = HandPoseDetector()

# while cap.isOpened():
while True:
    total_start_time = time.time()
    # Frame capture
    frame_start_time = time.time()
    # ret, frame = cap.read()
    # if not ret:
    #     break
    frame, ts = cam.read_frame()
    if not frame.any():
        break
    # frame = cv2.flip(frame, 1)
    frame_end_time = time.time()
    frame_input_latency = (frame_end_time - frame_start_time) * 1000  # ms

    # Hand pose detection
    process_start_time = time.time()
    hands = detector.detect_hand_pose(frame)
    process_end_time = time.time()
    processing_latency = (process_end_time - process_start_time) * 1000  # ms

    left_hand_tapped = False

    if hands:
        for hand in hands:
            landmarks = hand["landmarks"].landmark
            hand_label = hand.get("label", "").lower()
            # if hand_label != "left":
            if hand_label != "right":
                continue

            # Choose landmark index (e.g., index fingertip)
            lm = landmarks[8]
            # Convert normalized y to pixel coordinate
            lm_y_px = int(lm.y * frame.shape[0])
            # Vertical distance to reference line
            vert_dist = abs(lm_y_px - y_line)

            # Debug print
            # print(f"Vertical distance: {vert_dist}px")

            # Threshold for tap detection (e.g., 30 pixels)
            threshold_px = 22.96
            if vert_dist >= threshold_px and state == 1:
                state = 0
            elif vert_dist < threshold_px and state == 0:
                state = 1
                left_hand_tapped = True
                play_start_time = time.time()

                # Your audio trigger or playback logic here
                # ...

                play_end_time = time.time()
                audio_output_latency = (play_end_time - play_start_time) * 1000  # ms

                total_latency = (play_end_time - total_start_time) * 1000  # ms
                total_latency_array.append(total_latency)
                frame_latency_array.append(frame_input_latency)
                processing_latency_array.append(processing_latency)
                audio_latency_array.append(audio_output_latency)
                counter += 1
                print(f"Left hand counter: {counter}")

    # Send OSC trigger if tapped
    if left_hand_tapped:
        client.send_message("/trigger", 1)

    # Draw reference line on frame
    cv2.line(frame, (0, y_line), (frame.shape[1], y_line), (255, 0, 0), 2)
    cv2.imshow("Hand Pose", frame)

    if cv2.waitKey(delay) & 0xFF == ord('q'):
        break

# cap.release()
cam.cleanup()
cv2.destroyAllWindows()
