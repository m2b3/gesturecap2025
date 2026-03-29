from abc import ABC, abstractmethod
import logging

logger = logging.getLogger(__name__)


class GestureMapper(ABC):
    """
    Abstract base class for gesture mappers.
    A gesture mapper takes detected hand landmarks and produces OSC messages.
    Each subclass implements a specific gesture detection strategy (tap, pinch, velocity, etc.)

    The consumer process calls `process()` on every frame and sends the returned
    OSC messages to PureData. Each message is a (osc_address, value) tuple.
    """

    @abstractmethod
    def configure(self, calibration_data: dict) -> None:
        """
        Load calibration parameters or configuration for this gesture.
        calibration_data comes from calibration.json (y_line, std_offset, mean_offset, etc.)
        """
        pass


    @abstractmethod
    def process(self, hands: list, frame_shape: tuple) -> list:
        """
        Process detected hands and return a list of (osc_address, value) tuples to send.
        hands is the output from HandPoseDetector.detect_hand_pose()
        frame_shape is (height, width, channels) of the current frame
        """
        pass


    @abstractmethod
    def reset(self) -> None:
        """
        Reset internal state (e.g. between sessions or on recalibration).
        """
        pass
