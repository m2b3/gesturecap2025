import cv2
from flircam import * 
from hand_pose_detector import HandPoseDetector
from pythonosc import udp_client
import time
import math

cam = Flircam()
cam.start()

cur_pos = None
cur_time = 0
prev_pos = None
prev_speed = None
prev_time = cv2.getTickCount()
freq = cv2.getTickFrequency()

detector = HandPoseDetector()

# Initialize OSC client
osc_ip = "127.0.0.1"
osc_port = 11111
client = udp_client.SimpleUDPClient(osc_ip, osc_port)

# Cooldown settings
trigger_cooldown = 0.2  # in seconds
last_trigger_time = 0

# Thresholds
speed_threshold = 3       # px/s
downward_y_threshold = 0.01  # minimum y-direction for "downward" movement

while True:
    frame, ts = cam.read_frame()
    frame = cv2.flip(frame, 1)

    if not frame.any():
        break

    hands = detector.detect_hand_pose(frame)
    if hands:
        for hand in hands:
            landmarks = hand["landmarks"].landmark

            if "label" in hand:
                hand_label = hand["label"].lower()
            else:
                continue

            # if hand_label == "left":
            if hand_label in ["left", "right"]:
                left_index_pos = (landmarks[17].x, landmarks[17].y)
                cur_pos = left_index_pos

                cur_time = cv2.getTickCount()
                dt = (cur_time - prev_time) / freq

            if prev_pos is not None:
                dx, dy = cur_pos[0] - prev_pos[0], cur_pos[1] - prev_pos[1]
                dist = math.hypot(dx, dy)
                speed = dist / dt

                direction = (dx, dy)

                now = time.time()
                if speed > speed_threshold and direction[1] > downward_y_threshold and (now - last_trigger_time) >= trigger_cooldown:
                # if speed > speed_threshold and (now - last_trigger_time) >= trigger_cooldown:
                    print(f"Speed: {speed:.2f} px/s, Direction: {direction}")
                    print("Trigger: Downward fast movement detected.")
                    # print(frame.shape)
                    if cur_pos[0]*frame.shape[1] < frame.shape[1]/2: 
                        client.send_message("/drum", 1)
                        last_trigger_time = now
                        print("DRUM")
                    else:
                        client.send_message("/snare", 1)
                        last_trigger_time = now
                        print("SNARE")

                prev_speed = speed

    prev_pos = cur_pos
    prev_time = cur_time

    cv2.imshow("Hand Pose", frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cam.cleanup()
cv2.destroyAllWindows()
