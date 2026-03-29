import numpy as np
from unittest.mock import MagicMock
from gestures.tap_mapper import TapMapper

"""
Proves that TapMapper produces identical results to the hardcoded
tap detection in latency_mp.py consumer (lines 155-171).

Replays a sequence of hand positions through both implementations
and asserts they trigger on the exact same frames.
"""

FRAME_SHAPE = (540, 720, 3)


def make_hand(label, y_values):
    lms = []
    for i in range(21):
        lm = MagicMock()
        if 17 <= i <= 20:
            lm.x = 0.5
            lm.y = y_values[i - 17]
            lm.z = 0.0
        else:
            lm.x = 0.5
            lm.y = 0.5
            lm.z = 0.0
        lms.append(lm)
    wrapper = MagicMock()
    wrapper.landmark = lms
    return {'label': label, 'landmarks': wrapper}


def original_consumer_logic(hands, frame_shape, y_line, threshold, state):
    """Exact copy of latency_mp.py lines 155-171"""
    triggered = False
    for hand in hands:
        if hand.get('label', '').lower() == 'right':
            continue
        ys = [hand['landmarks'].landmark[i].y * frame_shape[0] for i in range(17, 21)]
        avg_y = np.mean(ys)
        dist = abs(avg_y - y_line)

        if dist >= threshold and state[0] == 1:
            state[0] = 0
        elif dist < threshold and state[0] == 0:
            state[0] = 1
            triggered = True
    return triggered


class TestTapEquivalence:
    """Run identical hand sequences through both implementations."""

    def test_random_sequence(self):
        y_line = 270
        stdev = 10.0
        mean = 20.0
        threshold = mean + 3 * stdev
        calib = {'y_line': y_line, 'std_offset': stdev, 'mean_offset': mean}

        mapper = TapMapper()
        mapper.configure(calib)

        # generate a sequence: far, close, close, far, far, close, far, close
        # normalized y values for landmarks 17-20
        far_y = 0.1  # far from y_line (y_line/540 = 0.5)
        close_y = y_line / FRAME_SHAPE[0]  # right on the line

        sequence = [
            ('Left', [far_y]*4),
            ('Left', [close_y]*4),    # should trigger
            ('Left', [close_y]*4),    # no double trigger
            ('Left', [far_y]*4),      # release
            ('Left', [far_y]*4),
            ('Left', [close_y]*4),    # should trigger again
            ('Left', [far_y]*4),
            ('Left', [close_y]*4),    # should trigger
        ]

        original_state = [0]
        original_triggers = []
        mapper_triggers = []

        for i, (label, ys) in enumerate(sequence):
            hands = [make_hand(label, ys)]

            # original
            orig = original_consumer_logic(hands, FRAME_SHAPE, y_line, threshold, original_state)
            original_triggers.append(orig)

            # mapper
            msgs = mapper.process(hands, FRAME_SHAPE)
            mapper_triggered = any(addr == '/trigger' for addr, val in msgs)
            mapper_triggers.append(mapper_triggered)

        assert original_triggers == mapper_triggers, \
            f"Mismatch:\n  original: {original_triggers}\n  mapper:   {mapper_triggers}"

    def test_right_hand_both_ignore(self):
        calib = {'y_line': 270, 'std_offset': 10.0, 'mean_offset': 20.0}
        threshold = calib['mean_offset'] + 3 * calib['std_offset']

        mapper = TapMapper()
        mapper.configure(calib)

        close_y = 270 / FRAME_SHAPE[0]
        hands = [make_hand('Right', [close_y]*4)]

        original_state = [0]
        orig = original_consumer_logic(hands, FRAME_SHAPE, 270, threshold, original_state)
        msgs = mapper.process(hands, FRAME_SHAPE)

        assert orig is False
        assert msgs == []

    def test_empty_hands(self):
        calib = {'y_line': 270, 'std_offset': 10.0, 'mean_offset': 20.0}
        threshold = calib['mean_offset'] + 3 * calib['std_offset']

        mapper = TapMapper()
        mapper.configure(calib)

        original_state = [0]
        orig = original_consumer_logic([], FRAME_SHAPE, 270, threshold, original_state)
        msgs = mapper.process([], FRAME_SHAPE)

        assert orig is False
        assert msgs == []
