from multiprocessing import Lock, shared_memory, Event, Process, Value
import multiprocessing as mp
import time
import numpy as np
import json
import csv
import os
from datetime import datetime
from collections import deque
from pythonosc import udp_client
from video.flircam import Flircam
from utils.hand_pose_detector import HandPoseDetector
import matplotlib.image as mpimg


def load_calibration(calib_file='config/calibration.json'):
    with open(calib_file, 'r') as fp:
        data = json.load(fp)
    return data['y_line'], data['std_offset'], data['mean_offset']


def precise_sleep(target_duration):
    end_time = time.perf_counter() + target_duration
    while time.perf_counter() < end_time:
        pass


FRAME_SHAPE = (540, 720, 3)
FRAME_DTYPE = np.uint8
LAST_N_FRAMES = 7  # save the last N frames per trial

# ---- New flag ----
SAVE_FRAMES = False  # set to False to disable frame saving


# ---------------------- Config + Output Folder ----------------------
def load_experiment_folder(config_path="config/log_config.json", base_output="latency_logs"):
    with open(config_path, "r") as cfg_file:
        config = json.load(cfg_file)

    device = config["device"]
    method = config["method"]
    frequency = config["frequency"]
    threshold = config["threshold"]
    output_method = config["output_method"]

    dir_name = f"{device}_{method}_freq{frequency}Hz_th{threshold}_out{output_method}"
    dir_name = dir_name.replace(" ", "_")
    output_dir = os.path.join(base_output, dir_name)

    os.makedirs(output_dir, exist_ok=True)
    return output_dir


def producer(shm_name0, shm_name1, cur_idx, stop_event, ts_value,
             t_read_total_v, t_frameacq_v, t_getts_v, t_frameconv_v):

    cam = Flircam()
    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    try:
        while not stop_event.is_set():
            t_start = time.perf_counter()
            frame, cam_ts_inner, (t_frameacq, t_getts, t_frameconv) = cam.read_frame()
            t_end = time.perf_counter()
            t_total = t_end - t_start

            if not frame.any():
                stop_event.set()
                break

            write_idx = 1 - cur_idx.value
            if write_idx == 0:
                np.copyto(buf0, frame)
            else:
                np.copyto(buf1, frame)

            t_read_total_v.value = t_total
            t_frameacq_v.value = t_frameacq
            t_getts_v.value = t_getts
            t_frameconv_v.value = t_frameconv
            ts_value.value = t_end
            cur_idx.value = write_idx

    except KeyboardInterrupt:
        print("PRODUCER: KeyboardInterrupt")
    finally:
        cam.cleanup()
        shm0.close()
        shm1.close()
        print("PRODUCER EXITS GRACEFULLY")


def consumer(shm_name0, shm_name1, cur_idx, stop_event, ts_value,
             t_read_total_v, t_frameacq_v, t_getts_v, t_frameconv_v,
             run_folder: str):
    """
    Consumer: detects taps, logs to CSV, optionally saves frames.
    """

    y_line, stdev, mean = load_calibration()
    threshold = mean + 3 * stdev
    print(f"Using y_line={y_line}, threshold={threshold:.2f}px")

    osc_ip, osc_port = '127.0.0.1', 11111
    client = udp_client.SimpleUDPClient(osc_ip, osc_port)

    detector = HandPoseDetector()

    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    # Prepare CSV files inside experiment folder
    now_str = datetime.now().strftime('%Y%m%d_%H%M%S')
    archive_csv = os.path.join(run_folder, f"tableB_{now_str}.csv")
    fixed_csv = os.path.join(run_folder, 'tableB.csv')

    header = ['record_time_perf', 'tap_number', 'frame_age_ms',
              't_read_total_ms', 't_frameacq_ms', 't_getts_ms', 't_frameconv_ms',
              'detect_time_ms', 'frames_folder']

    with open(archive_csv, 'w', newline='') as af, open(fixed_csv, 'w', newline='') as ff:
        writer_a = csv.writer(af)
        writer_f = csv.writer(ff)
        writer_a.writerow(header)
        writer_f.writerow(header)

    time.sleep(0.5)  # warm up

    frame_buffer = deque(maxlen=LAST_N_FRAMES)

    state = 0
    counter = 0
    print("Starting hand-tap detection.")

    try:
        while not stop_event.is_set():
            read_idx = cur_idx.value
            frame = buf0.copy() if read_idx == 0 else buf1.copy()

            frame_buffer.append(frame.copy())

            frame_age_ms = (time.perf_counter() - ts_value.value) * 1000.0
            t_read_total = t_read_total_v.value
            t_frameacq = t_frameacq_v.value
            t_getts = t_getts_v.value
            t_frameconv = t_frameconv_v.value

            detect_start = time.perf_counter()
            hands = detector.detect_hand_pose(frame)
            detect_end = time.perf_counter()
            detect_time = detect_end - detect_start

            if hands:
                for hand in hands:
                    if hand.get('label', '').lower() == 'right':
                        continue

                    ys = [hand['landmarks'].landmark[i].y * frame.shape[0] for i in range(17, 21)]
                    avg_y = np.mean(ys)
                    dist = abs(avg_y - y_line)

                    if dist >= threshold and state == 1:
                        state = 0
                    elif dist < threshold and state == 0:
                        state = 1
                        counter += 1
                        print(f"Tap #{counter}")

                        client.send_message('/trigger', 1)

                        row = [
                            time.perf_counter(),
                            counter,
                            round(frame_age_ms, 6),
                            round(t_read_total * 1000.0, 6),
                            round(t_frameacq * 1000.0, 6),
                            round(t_getts * 1000.0, 6),
                            round(t_frameconv * 1000.0, 6),
                            round(detect_time * 1000.0, 6),
                            ''
                        ]

                        trial_folder = ''
                        if SAVE_FRAMES:
                            trial_sub = f"frames/trial_{counter:04d}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
                            trial_folder = os.path.join(run_folder, trial_sub)
                            os.makedirs(trial_folder, exist_ok=True)

                            for i, f in enumerate(list(frame_buffer)):
                                fname = os.path.join(trial_folder, f'frame_{i:03d}.png')
                                try:
                                    f_save = f if f.dtype == np.uint8 else np.clip(f, 0, 255).astype(np.uint8)
                                    if f_save.ndim == 3 and f_save.shape[2] == 3:
                                        f_save = f_save[..., ::-1]
                                    mpimg.imsave(fname, f_save)
                                except Exception as e:
                                    print(f"Failed to save frame {i}: {e}")

                            frame_buffer.clear()

                        row[-1] = trial_folder
                        with open(archive_csv, 'a', newline='') as af, open(fixed_csv, 'a', newline='') as ff:
                            writer_a = csv.writer(af)
                            writer_f = csv.writer(ff)
                            writer_a.writerow(row)
                            writer_f.writerow(row)

    except KeyboardInterrupt:
        print("CONSUMER: KeyboardInterrupt")
    finally:
        stop_event.set()
        shm0.close()
        shm1.close()
        print("CONSUMER EXITS GRACEFULLY")


if __name__ == "__main__":
    mp.set_start_method('forkserver', force=True)

    size = int(np.prod(FRAME_SHAPE) * np.dtype(FRAME_DTYPE).itemsize)
    shm0 = shared_memory.SharedMemory(create=True, size=size)
    shm1 = shared_memory.SharedMemory(create=True, size=size)

    cur_idx = Value('i', 0)
    ts = Value('d', 0.0)
    stop_event = Event()

    t_read_total = Value('d', 0.0)
    t_frameacq = Value('d', 0.0)
    t_getts = Value('d', 0.0)
    t_frameconv = Value('d', 0.0)

    # Use the same experiment folder as tableA
    run_folder = load_experiment_folder()

    p1 = Process(target=producer, args=(shm0.name, shm1.name,
                                        cur_idx, stop_event, ts,
                                        t_read_total, t_frameacq, t_getts, t_frameconv))
    p2 = Process(target=consumer, args=(shm0.name, shm1.name,
                                        cur_idx, stop_event, ts,
                                        t_read_total, t_frameacq, t_getts, t_frameconv,
                                        run_folder))

    p1.start()
    p2.start()

    try:
        while p1.is_alive():
            p1.join(timeout=0.5)
    except KeyboardInterrupt:
        stop_event.set()
    finally:
        stop_event.set()
        p1.join(timeout=1.0)
        p2.join(timeout=1.0)

        try:
            shm0.close()
            shm0.unlink()
        except Exception:
            pass
        try:
            shm1.close()
            shm1.unlink()
        except Exception:
            pass

        print("MAIN EXIT")
