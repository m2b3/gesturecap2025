import numpy as np
import logging
from gestures.gesture_mapper import GestureMapper

logger = logging.getLogger(__name__)

PINKY_LANDMARKS = range(17, 21)


class TapMapper(GestureMapper):
    """
    Detects vertical tap gestures using the pinky finger.
    Same logic as latency_mp.py consumer — state machine triggers on downward
    transition of pinky landmarks (17-20) past the calibrated threshold.
    """
    def __init__(self):
        self.y_line = 0
        self.threshold = 0.0
        self.state = 0
        self.counter = 0


    def configure(self, calibration_data: dict) -> None:
        """Abstract method implementation"""
        self.y_line = calibration_data['y_line']
        stdev = calibration_data['std_offset']
        mean = calibration_data['mean_offset']
        self.threshold = mean + 3 * stdev
        logger.info(f'TapMapper configured: y_line={self.y_line}, threshold={self.threshold:.2f}px')


    def process(self, hands: list, frame_shape: tuple) -> list:
        messages = []
        for hand in hands:
            if hand.get('label', '').lower() == 'right':
                continue

            ys = [hand['landmarks'].landmark[i].y * frame_shape[0] for i in PINKY_LANDMARKS]
            avg_y = np.mean(ys)
            dist = abs(avg_y - self.y_line)

            if dist >= self.threshold and self.state == 1:
                self.state = 0
            elif dist < self.threshold and self.state == 0:
                self.state = 1
                self.counter += 1
                messages.append(('/trigger', 1))
                logger.debug(f'Tap #{self.counter}')

        return messages


    def reset(self) -> None:
        self.state = 0
        self.counter = 0
