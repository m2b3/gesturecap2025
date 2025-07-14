import cv2
import numpy as np


# Load video
# video_path = "fixedfps_recording_1.avi"  # Change as needed
video_path = "taps_output.avi"  # Change as needed
cap = cv2.VideoCapture(video_path)
assert cap.isOpened(), f"Failed to open video: {video_path}"

# Get video properties
total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
fps = cap.get(cv2.CAP_PROP_FPS)
# with open(f"metadata_{video_path}.txt", "r") as f:
#     time = float(f.read())
print(f"Video loaded: {video_path}")
print(f"Total frames: {total_frames}, FPS: {fps:.2f}")
# print(f"FPS: {total_frames/time:.2f}")

# Window and trackbar setup
cv2.namedWindow("Frame Player", cv2.WINDOW_NORMAL)

current_frame = 0
playing = False  # For optional playback mode

def on_trackbar(val):
    global current_frame
    current_frame = val
    cap.set(cv2.CAP_PROP_POS_FRAMES, current_frame)
    ret, frame = cap.read()
    if ret:
        cv2.imshow("Frame Player", frame)

# Create trackbar
cv2.createTrackbar("Frame Slider", "Frame Player", 0, total_frames - 1, on_trackbar)

# Initial display
on_trackbar(0)

print("Use the slider or left/right arrow keys to step frames. Press 'q' to quit.")



while True:
    key = cv2.waitKey(0) & 0xFF

    if key == ord('q'):
        break
    elif key == 81 or key == ord('a'):  # Left arrow or 'a'
        current_frame = max(current_frame - 1, 0)
    elif key == 83 or key == ord('d'):  # Right arrow or 'd'
        current_frame = min(current_frame + 1, total_frames - 1)

    # Update frame and trackbar
    cap.set(cv2.CAP_PROP_POS_FRAMES, current_frame)
    ret, frame = cap.read()
    if ret:
              
        cv2.imshow("Frame Player", frame)
        cv2.setTrackbarPos("Frame Slider", "Frame Player", current_frame)

cap.release()
cv2.destroyAllWindows()
