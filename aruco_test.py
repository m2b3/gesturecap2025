import cv2
import cv2.aruco as aruco
from flircam import Flircam

# Start camera
cam = Flircam()
cam.start()

# ArUco setup
aruco_dict = aruco.getPredefinedDictionary(aruco.DICT_4X4_100)
parameters = aruco.DetectorParameters()

# Smoothing params
alpha = 0.3              # smoothing factor (0 < α ≤ 1); smaller = smoother
smooth_lines = {}        # map marker_id → (pt1, pt2)

while True:
    frame, ts = cam.read_frame()
    if not frame.any():
        break

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    corners, ids, _ = aruco.detectMarkers(gray, aruco_dict, parameters=parameters)

    if ids is not None:
        aruco.drawDetectedMarkers(frame, corners, ids)
        h, w = frame.shape[:2]

        for i, marker_corners in enumerate(corners):
            marker_id = int(ids[i][0])
            pts = marker_corners.reshape((4, 2))
            tl, tr, br, bl = pts

            # compute the two midpoints of the horizontal marker axis
            left_mid  = ((tl + bl) / 2).astype(int)
            right_mid = ((tr + br) / 2).astype(int)
            x1, y1 = left_mid
            x2, y2 = right_mid

            # if almost vertical, draw vertical line; else compute slope/intercept
            if abs(x2 - x1) < 1:
                x_line = int(round((x1 + x2) / 2))
                curr_pt1 = (x_line, 0)
                curr_pt2 = (x_line, h - 1)
            else:
                m = (y2 - y1) / (x2 - x1)
                b = y1 - m * x1
                curr_pt1 = (0,   int(round(b)))
                curr_pt2 = (w-1, int(round(m*(w-1) + b)))

            # smooth against the last value for this marker
            if marker_id in smooth_lines:
                prev_pt1, prev_pt2 = smooth_lines[marker_id]
                sm_pt1 = (
                    int(alpha*curr_pt1[0] + (1-alpha)*prev_pt1[0]),
                    int(alpha*curr_pt1[1] + (1-alpha)*prev_pt1[1])
                )
                sm_pt2 = (
                    int(alpha*curr_pt2[0] + (1-alpha)*prev_pt2[0]),
                    int(alpha*curr_pt2[1] + (1-alpha)*prev_pt2[1])
                )
            else:
                # first time seeing this marker → no smoothing
                sm_pt1, sm_pt2 = curr_pt1, curr_pt2

            # save for next frame
            smooth_lines[marker_id] = (sm_pt1, sm_pt2)

            # draw the filtered, extended axis
            cv2.line(frame, sm_pt1, sm_pt2, (0, 0, 255), 5)

    cv2.imshow('ArUco Marker Detection', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cam.cleanup()
cv2.destroyAllWindows()
