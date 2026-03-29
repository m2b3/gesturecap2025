import logging
from gestures.gesture_mapper import GestureMapper

logger = logging.getLogger(__name__)


class CompositeMapper(GestureMapper):
    """
    Runs multiple gesture mappers on the same hand data and merges their OSC output.
    This is the main reason the GestureMapper abstraction exists — you can't do
    tap + pinch + velocity simultaneously with the hardcoded approach in latency_mp.py.
    """
    def __init__(self, mappers: list):
        self.mappers = mappers


    def configure(self, calibration_data: dict) -> None:
        """Abstract method implementation"""
        for m in self.mappers:
            m.configure(calibration_data)
        names = [m.__class__.__name__ for m in self.mappers]
        logger.info(f'CompositeMapper configured with: {names}')


    def process(self, hands: list, frame_shape: tuple) -> list:
        messages = []
        for m in self.mappers:
            messages.extend(m.process(hands, frame_shape))
        return messages


    def reset(self) -> None:
        for m in self.mappers:
            m.reset()
