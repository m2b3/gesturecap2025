from multiprocessing import shared_memory, Event, Value
import time
import numpy as np
import json
import csv
import os
from pythonosc import udp_client
from utils.hand_pose_detector import HandPoseDetector
from gestures.gesture_mapper import GestureMapper

"""
Drop-in replacement for the consumer in latency_mp.py that accepts
any GestureMapper instead of hardcoding tap detection.

Usage:
    mapper = TapMapper()
    mapper.configure(load_calibration_dict())
    p2 = Process(target=gesture_consumer, args=(..., mapper))
"""


def load_calibration_dict(calib_file='config/calibration.json'):
    with open(calib_file, 'r') as fp:
        return json.load(fp)


def gesture_consumer(shm_name0, shm_name1, cur_idx, stop_event, ts_value,
                     t_read_total_v, t_frameacq_v, t_getts_v, t_frameconv_v,
                     run_folder: str, mapper: GestureMapper,
                     osc_ip='127.0.0.1', osc_port=11111):
    """
    Consumer that uses a GestureMapper for detection instead of hardcoded tap logic.
    mapper must have configure() called before this process is spawned.
    """
    from latency_measurement.latency_mp import FRAME_SHAPE, FRAME_DTYPE

    client = udp_client.SimpleUDPClient(osc_ip, osc_port)
    detector = HandPoseDetector()

    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    fixed_csv = os.path.join(run_folder, 'tableB.csv')
    header = ['record_time_perf', 'event_number', 'osc_address', 'osc_value',
              'frame_age_ms', 't_read_total_ms', 't_frameacq_ms', 't_getts_ms',
              't_frameconv_ms', 'detect_time_ms']

    with open(fixed_csv, 'w', newline='') as ff:
        csv.writer(ff).writerow(header)

    time.sleep(0.5)  # warm up

    counter = 0
    print(f"Starting gesture detection with {mapper.__class__.__name__}.")

    try:
        while not stop_event.is_set():
            read_idx = cur_idx.value
            frame = buf0.copy() if read_idx == 0 else buf1.copy()

            frame_age_ms = (time.perf_counter() - ts_value.value) * 1000.0
            t_read_total = t_read_total_v.value
            t_frameacq = t_frameacq_v.value
            t_getts = t_getts_v.value
            t_frameconv = t_frameconv_v.value

            detect_start = time.perf_counter()
            hands = detector.detect_hand_pose(frame)
            detect_end = time.perf_counter()
            detect_time = detect_end - detect_start

            messages = mapper.process(hands, frame.shape)

            for addr, val in messages:
                client.send_message(addr, val)
                counter += 1

                row = [
                    time.perf_counter(),
                    counter,
                    addr,
                    val,
                    round(frame_age_ms, 6),
                    round(t_read_total * 1000.0, 6),
                    round(t_frameacq * 1000.0, 6),
                    round(t_getts * 1000.0, 6),
                    round(t_frameconv * 1000.0, 6),
                    round(detect_time * 1000.0, 6),
                ]
                with open(fixed_csv, 'a', newline='') as ff:
                    csv.writer(ff).writerow(row)

    except KeyboardInterrupt:
        print("GESTURE CONSUMER: KeyboardInterrupt")
    finally:
        stop_event.set()
        shm0.close()
        shm1.close()
        print("GESTURE CONSUMER EXITS GRACEFULLY")
