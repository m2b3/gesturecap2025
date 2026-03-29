import time
import numpy as np
import logging
from gestures.gesture_mapper import GestureMapper

logger = logging.getLogger(__name__)

WRIST = 0
MIDDLE_MCP = 9


class VelocityMapper(GestureMapper):
    """
    Tracks hand movement speed and maps it to a continuous OSC parameter.
    Uses midpoint of wrist (0) and middle finger MCP (9) as hand center.
    Velocity = pixel displacement / dt between consecutive frames.
    Sends /velocity/swipe when speed exceeds threshold (with hysteresis at 50%).
    """
    def __init__(self):
        self.max_velocity = 2000.0  # px/s
        self.swipe_threshold = 800.0
        self.prev_center = None
        self.prev_time = None
        self.swiping = False


    def configure(self, calibration_data: dict) -> None:
        """Abstract method implementation"""
        self.max_velocity = calibration_data.get('velocity_max', 2000.0)
        self.swipe_threshold = calibration_data.get('swipe_threshold', 800.0)
        logger.info(f'VelocityMapper configured: max_vel={self.max_velocity}, swipe_th={self.swipe_threshold}')


    def process(self, hands: list, frame_shape: tuple) -> list:
        messages = []
        h, w = frame_shape[0], frame_shape[1]

        # only track left hand (same as tap detection in latency_mp.py)
        hand = None
        for h_ in hands:
            if h_.get('label', '').lower() == 'left':
                hand = h_
                break

        if hand is None:
            self.prev_center = None
            self.prev_time = None
            return messages

        lms = hand['landmarks'].landmark
        wrist = lms[WRIST]
        mcp = lms[MIDDLE_MCP]
        cx = (wrist.x + mcp.x) / 2.0 * w
        cy = (wrist.y + mcp.y) / 2.0 * h

        now = time.perf_counter()

        if self.prev_center is not None and self.prev_time is not None:
            dt = now - self.prev_time
            if dt > 0:
                dx = cx - self.prev_center[0]
                dy = cy - self.prev_center[1]
                vel = np.sqrt(dx * dx + dy * dy) / dt

                normalized = min(vel / self.max_velocity, 1.0)
                messages.append(('/velocity/speed', round(float(normalized), 4)))

                if vel > self.swipe_threshold and not self.swiping:
                    self.swiping = True
                    messages.append(('/velocity/swipe', 1))
                    logger.debug(f'Swipe detected at {vel:.0f}px/s')
                elif vel <= self.swipe_threshold * 0.5 and self.swiping:
                    self.swiping = False

        self.prev_center = (cx, cy)
        self.prev_time = now

        return messages


    def reset(self) -> None:
        self.prev_center = None
        self.prev_time = None
        self.swiping = False
