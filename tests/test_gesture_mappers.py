import pytest
import numpy as np
from unittest.mock import MagicMock
from gestures.tap_mapper import TapMapper
from gestures.pinch_mapper import PinchMapper
from gestures.velocity_mapper import VelocityMapper


FRAME_SHAPE = (540, 720, 3)

CALIBRATION = {
    'y_line': 270,
    'std_offset': 10.0,
    'mean_offset': 20.0,
    'pinch_max_dist': 200.0,
    'pinch_threshold': 40.0,
    'velocity_max': 2000.0,
    'swipe_threshold': 800.0,
}


def make_hand(label, landmarks_dict):
    # builds a hand dict matching HandPoseDetector.detect_hand_pose() output
    lms = []
    for i in range(21):
        lm = MagicMock()
        if i in landmarks_dict:
            lm.x = landmarks_dict[i][0]
            lm.y = landmarks_dict[i][1]
            lm.z = 0.0
        else:
            lm.x = 0.5
            lm.y = 0.5
            lm.z = 0.0
        lms.append(lm)
    wrapper = MagicMock()
    wrapper.landmark = lms
    return {'label': label, 'landmarks': wrapper}


# TapMapper

class TestTapMapper:
    def test_configure_sets_threshold(self):
        mapper = TapMapper()
        mapper.configure(CALIBRATION)
        expected = CALIBRATION['mean_offset'] + 3 * CALIBRATION['std_offset']
        assert mapper.threshold == expected

    def test_no_tap_when_far(self):
        mapper = TapMapper()
        mapper.configure(CALIBRATION)
        hand = make_hand('Left', {i: (0.5, 0.1) for i in range(17, 21)})
        assert mapper.process([hand], FRAME_SHAPE) == []

    def test_tap_on_downward_transition(self):
        mapper = TapMapper()
        mapper.configure(CALIBRATION)
        y_norm = CALIBRATION['y_line'] / FRAME_SHAPE[0]
        hand = make_hand('Left', {i: (0.5, y_norm) for i in range(17, 21)})
        messages = mapper.process([hand], FRAME_SHAPE)
        assert len(messages) == 1
        assert messages[0] == ('/trigger', 1)

    def test_no_double_tap(self):
        mapper = TapMapper()
        mapper.configure(CALIBRATION)
        y_norm = CALIBRATION['y_line'] / FRAME_SHAPE[0]
        hand = make_hand('Left', {i: (0.5, y_norm) for i in range(17, 21)})
        mapper.process([hand], FRAME_SHAPE)
        # second call without release should not trigger
        assert mapper.process([hand], FRAME_SHAPE) == []

    def test_right_hand_ignored(self):
        mapper = TapMapper()
        mapper.configure(CALIBRATION)
        y_norm = CALIBRATION['y_line'] / FRAME_SHAPE[0]
        hand = make_hand('Right', {i: (0.5, y_norm) for i in range(17, 21)})
        assert mapper.process([hand], FRAME_SHAPE) == []

    def test_reset(self):
        mapper = TapMapper()
        mapper.configure(CALIBRATION)
        y_norm = CALIBRATION['y_line'] / FRAME_SHAPE[0]
        hand = make_hand('Left', {i: (0.5, y_norm) for i in range(17, 21)})
        mapper.process([hand], FRAME_SHAPE)
        assert mapper.counter == 1
        mapper.reset()
        assert mapper.state == 0
        assert mapper.counter == 0


# PinchMapper

class TestPinchMapper:
    def test_open_hand(self):
        mapper = PinchMapper()
        mapper.configure(CALIBRATION)
        hand = make_hand('Left', {4: (0.1, 0.5), 8: (0.9, 0.5)})
        messages = mapper.process([hand], FRAME_SHAPE)
        dists = [v for a, v in messages if a == '/pinch/distance']
        assert len(dists) == 1
        assert dists[0] > 0.5

    def test_pinch_trigger(self):
        mapper = PinchMapper()
        mapper.configure(CALIBRATION)
        # thumb and index almost touching
        hand = make_hand('Left', {4: (0.5, 0.5), 8: (0.505, 0.5)})
        messages = mapper.process([hand], FRAME_SHAPE)
        triggers = [v for a, v in messages if a == '/pinch/trigger']
        assert len(triggers) == 1

    def test_pinch_release(self):
        mapper = PinchMapper()
        mapper.configure(CALIBRATION)
        close = make_hand('Left', {4: (0.5, 0.5), 8: (0.505, 0.5)})
        mapper.process([close], FRAME_SHAPE)
        far = make_hand('Left', {4: (0.1, 0.5), 8: (0.9, 0.5)})
        messages = mapper.process([far], FRAME_SHAPE)
        releases = [v for a, v in messages if a == '/pinch/release']
        assert len(releases) == 1

    def test_reset(self):
        mapper = PinchMapper()
        mapper.configure(CALIBRATION)
        mapper.pinched = True
        mapper.reset()
        assert not mapper.pinched


# VelocityMapper

class TestVelocityMapper:
    def test_first_frame_no_output(self):
        mapper = VelocityMapper()
        mapper.configure(CALIBRATION)
        hand = make_hand('Left', {0: (0.5, 0.5), 9: (0.5, 0.4)})
        assert mapper.process([hand], FRAME_SHAPE) == []

    def test_velocity_second_frame(self):
        mapper = VelocityMapper()
        mapper.configure(CALIBRATION)
        h1 = make_hand('Left', {0: (0.3, 0.5), 9: (0.3, 0.4)})
        mapper.process([h1], FRAME_SHAPE)
        h2 = make_hand('Left', {0: (0.7, 0.5), 9: (0.7, 0.4)})
        messages = mapper.process([h2], FRAME_SHAPE)
        speeds = [v for a, v in messages if a == '/velocity/speed']
        assert len(speeds) == 1
        assert speeds[0] > 0

    def test_no_hand_resets(self):
        mapper = VelocityMapper()
        mapper.configure(CALIBRATION)
        hand = make_hand('Left', {0: (0.5, 0.5), 9: (0.5, 0.4)})
        mapper.process([hand], FRAME_SHAPE)
        assert mapper.process([], FRAME_SHAPE) == []
        assert mapper.prev_center is None

    def test_reset(self):
        mapper = VelocityMapper()
        mapper.configure(CALIBRATION)
        mapper.prev_center = (100, 200)
        mapper.prev_time = 1.0
        mapper.swiping = True
        mapper.reset()
        assert mapper.prev_center is None
        assert mapper.prev_time is None
        assert not mapper.swiping
