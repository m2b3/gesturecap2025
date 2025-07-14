import time
import cv2
import numpy as np


def create_fps_counter(display):
    """
    Creates an FPS counter component for the display


    Parameters:
    ---
    display: Display
        The display object to which the FPS counter will be added


    Returns:
    ---
    fps_element: callable
        A function that takes a frame and adds the FPS counter to it
    """
    def fps_element(frame):
        assert frame.ndim == 3
        fps_text = f"FPS: {display.fps:.1f}"
        # fps_text = f"FPS: {display.fps:.1f},mean: {display.mean_fps:.1f}"
        font = cv2.FONT_HERSHEY_SIMPLEX
        font_scale = 1.5
        font_thickness = 2
        text_color = (255, 255, 255)  # White color for text
        background_color = (0, 0, 0)  # Black color for background

        # Get text size
        text_size = cv2.getTextSize(fps_text, font, font_scale, font_thickness)[0]

        # Position for the FPS counter (top-right corner with padding)
        padding = 10
        text_x = frame.shape[1] - text_size[0] - padding
        text_y = text_size[1] + padding

        # Draw background rectangle
        cv2.rectangle(frame,
                      (text_x - padding, text_y - text_size[1] - padding),
                      (text_x + text_size[0] + padding, text_y + padding),
                      background_color, -1)

        # Draw FPS text
        cv2.putText(frame, fps_text,
                    (text_x, text_y),
                    font, font_scale, text_color, font_thickness)

    return fps_element


def draw_point(frame: np.ndarray, coords: tuple, radius: int, color: tuple = (0,0,255)):
    """
    Draws a point on a frame


    Parameters:
    ---
    frame: np.ndarray
        The frame on which to draw the point

    coords: tuple
        The (x, y) coordinates of the point

    radius: int
        The radius of the point

    color: tuple, default = (0, 0, 255)
        The color of the point (B, G, R)
    """
    assert frame.ndim == 3
    cv2.circle(frame, coords, radius, color, thickness=-1)


# NOT WORKING YET
def draw_landmarks(frame: np.ndarray, landmarks, radius: int, color: tuple = (0, 0, 255)):
    """
    Draws landmarks on a frame


    Parameters:
    ---
    frame: np.ndarray
        The frame on which to draw the landmarks

    landmarks: List[landmark_module.NormalizedLandmark]
        The list of landmarks to draw

    radius: int
        The radius of each landmark point

    color: tuple, default = (0, 0, 255)
        The color of the landmark points (B, G, R)
    """
    raise NotImplementedError('Function draw_landmarks not working yet')
    assert frame.ndim == 3
    h, w, _ = frame.shape

    for lms in landmarks:
        draw_point(frame, (int(w * lms.x), int(h * lms.y)), radius, color)
