import numpy as np
import logging
from gestures.gesture_mapper import GestureMapper

logger = logging.getLogger(__name__)

THUMB_TIP = 4
INDEX_TIP = 8


class PinchMapper(GestureMapper):
    """
    Maps thumb-to-index-finger pinch distance to a continuous OSC parameter.
    Normalized distance (0.0 = fully pinched, 1.0 = fully open) sent every frame.
    Also sends binary /pinch/trigger and /pinch/release on threshold crossing.
    """
    def __init__(self):
        self.max_dist = 200.0  # px, expected max thumb-index distance
        self.pinch_threshold = 40.0
        self.pinched = False


    def configure(self, calibration_data: dict) -> None:
        """Abstract method implementation"""
        self.max_dist = calibration_data.get('pinch_max_dist', 200.0)
        self.pinch_threshold = calibration_data.get('pinch_threshold', 40.0)
        logger.info(f'PinchMapper configured: max_dist={self.max_dist}, threshold={self.pinch_threshold}')


    def process(self, hands: list, frame_shape: tuple) -> list:
        messages = []
        h, w = frame_shape[0], frame_shape[1]

        for hand in hands:
            lms = hand['landmarks'].landmark
            thumb = lms[THUMB_TIP]
            idx = lms[INDEX_TIP]

            dx = (thumb.x - idx.x) * w
            dy = (thumb.y - idx.y) * h
            dist = np.sqrt(dx * dx + dy * dy)

            normalized = min(dist / self.max_dist, 1.0)
            messages.append(('/pinch/distance', round(float(normalized), 4)))

            if dist < self.pinch_threshold and not self.pinched:
                self.pinched = True
                messages.append(('/pinch/trigger', 1))
                logger.debug(f'Pinch triggered at dist={dist:.1f}px')
            elif dist >= self.pinch_threshold and self.pinched:
                self.pinched = False
                messages.append(('/pinch/release', 0))

        return messages


    def reset(self) -> None:
        self.pinched = False
