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
from flircam import Flircam
from hand_pose_detector import HandPoseDetector
import matplotlib.image as mpimg


def load_calibration(calib_file='calibration.json'):
    with open(calib_file, 'r') as fp:
        data = json.load(fp)
    return data['y_line'], data['std_offset'], data['mean_offset']


def precise_sleep(target_duration):
    end_time = time.perf_counter() + target_duration
    while time.perf_counter() < end_time:
        pass


FRAME_SHAPE = (540, 720, 3)
FRAME_DTYPE = np.uint8
TEST_IMG = np.zeros(FRAME_SHAPE, dtype=FRAME_DTYPE)

# Configuration
LAST_N_FRAMES = 7  # save the last N frames per trial
RUN_FOLDER_PREFIX = 'run_tableB_'  # run folder prefix


def producer(shm_name0, shm_name1, cur_idx, stop_event, ts_value,
             t_read_total_v, t_frameacq_v, t_getts_v, t_frameconv_v):

    cam = Flircam()
    # cam.start()
    # time.sleep(1)
    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    try:
        while not stop_event.is_set():
            # Time the total read_frame call
            t_start = time.perf_counter()
            # Expectation: cam.read_frame() returns (frame, cam_ts, (t_frameacq, t_getts, t_frameconv))
            frame, cam_ts_inner, (t_frameacq, t_getts, t_frameconv) = cam.read_frame()
            t_end = time.perf_counter()
            t_total = t_end - t_start  # seconds

            if not frame.any():
                stop_event.set()
                break

            # Choose the non-current buffer to write to
            write_idx = 1 - cur_idx.value

            if write_idx == 0:
                np.copyto(buf0, frame)
            else:
                np.copyto(buf1, frame)

            # Publish timing values (store in shared Values for consumer to read)
            t_read_total_v.value = t_total
            t_frameacq_v.value = t_frameacq
            t_getts_v.value = t_getts
            t_frameconv_v.value = t_frameconv

            # Publish timestamp of when frame became available (use perf_counter for accuracy)
            ts_value.value = t_end

            # Publish index last written
            cur_idx.value = write_idx

            # small sleep if desired
            # precise_sleep(0.003)
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
    Consumer: reads latest frame, measures detect_hand_pose() time, and on each OSC trigger
    saves LAST_N_FRAMES frames to a trial folder and appends a CSV row with a pointer to that folder.
    The CSVs are created once per run inside run_folder.
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

    # Prepare CSV filenames: archival + fixed name inside run folder
    now_str = datetime.now().strftime('%Y%m%d_%H%M%S')
    archive_csv = os.path.join(run_folder, f"tableB_{now_str}.csv")
    fixed_csv = os.path.join(run_folder, 'tableB.csv')

    header = ['record_time_perf', 'tap_number', 'frame_age_ms',
              't_read_total_ms', 't_frameacq_ms', 't_getts_ms', 't_frameconv_ms',
              'detect_time_ms', 'frames_folder']

    # Create archival file and write header
    with open(archive_csv, 'w', newline='') as af:
        writer = csv.writer(af)
        writer.writerow(header)

    # Create/overwrite fixed file with header (so tableB.csv is fresh each run)
    with open(fixed_csv, 'w', newline='') as ff:
        writer = csv.writer(ff)
        writer.writerow(header)

    time.sleep(0.5)  # Let producer warm up

    # ring buffer for frames between trials (only last N)
    frame_buffer = deque(maxlen=LAST_N_FRAMES)

    state = 0
    counter = 0
    print("Starting hand-tap detection. Press 'q' to exit (if you implement a UI).")

    try:
        while not stop_event.is_set():
            read_idx = cur_idx.value  # Read latest published index

            if read_idx == 0:
                frame = buf0.copy()
            else:
                frame = buf1.copy()

            # Append to buffer (store a copy to avoid referencing shared memory)
            frame_buffer.append(frame.copy())

            # Frame age in milliseconds
            frame_age_ms = (time.perf_counter() - ts_value.value) * 1000.0

            # Read the timing breakdowns published by producer (in seconds)
            t_read_total = t_read_total_v.value
            t_frameacq = t_frameacq_v.value
            t_getts = t_getts_v.value
            t_frameconv = t_frameconv_v.value

            # Measure detect_hand_pose duration
            detect_start = time.perf_counter()
            hands = detector.detect_hand_pose(frame)
            detect_end = time.perf_counter()
            detect_time = detect_end - detect_start  # seconds

            if hands:
                for hand in hands:
                    # Skip right hand (use left)
                    if hand.get('label', '').lower() == 'right':
                        continue

                    # Compute average y of fingertips
                    ys = [hand['landmarks'].landmark[i].y * frame.shape[0] for i in range(17, 21)]
                    avg_y = np.mean(ys)
                    dist = abs(avg_y - y_line)

                    # Tap state machine
                    if dist >= threshold and state == 1:
                        state = 0
                    elif dist < threshold and state == 0:
                        state = 1
                        counter += 1
                        print(f"Tap #{counter}")

                        # send OSC trigger
                        client.send_message('/trigger', 1)

                        writer_time0 = time.perf_counter()

                        # Prepare CSV row (convert seconds -> milliseconds)
                        row = [
                            time.perf_counter(),                 # record time (perf counter)
                            counter,                             # tap number
                            round(frame_age_ms, 6),              # frame age ms
                            round(t_read_total * 1000.0, 6),     # total read_frame ms
                            round(t_frameacq * 1000.0, 6),       # frame acquisition ms
                            round(t_getts * 1000.0, 6),          # get timestamps ms
                            round(t_frameconv * 1000.0, 6),      # frame conversion ms
                            round(detect_time * 1000.0, 6),      # detect_hand_pose ms
                            ''                                    # placeholder for frames_folder (filled below)
                        ]

                        # Create trial folder and save last N frames synchronously
                        trial_sub = f"trial_{counter:04d}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
                        trial_folder = os.path.join(run_folder, trial_sub)
                        os.makedirs(trial_folder, exist_ok=True)

                        # Save frames (oldest->newest) as PNGs
                        for i, f in enumerate(list(frame_buffer)):
                            fname = os.path.join(trial_folder, f'frame_{i:03d}.png')
                            # Ensure we save as uint8 RGB (matplotlib expects RGB). Many cameras return BGR.
                            try:
                                f_save = f
                                # clip and cast if not uint8
                                if f_save.dtype != np.uint8:
                                    f_save = np.clip(f_save, 0, 255).astype(np.uint8)
                                else:
                                    f_save = f_save.copy()

                                # If image is BGR, convert to RGB by reversing channels
                                if f_save.ndim == 3 and f_save.shape[2] == 3:
                                    f_save = f_save[..., ::-1]

                                mpimg.imsave(fname, f_save)
                            except Exception:
                                try:
                                    f2 = np.clip(f, 0, 255).astype(np.uint8)
                                    if f2.ndim == 3 and f2.shape[2] == 3:
                                        f2 = f2[..., ::-1]
                                    mpimg.imsave(fname, f2)
                                except Exception as e:
                                    print(f"Failed to save frame {i} for trial {trial_sub}: {e}")

                        # Fill frames_folder column and append to CSVs
                        row[-1] = trial_folder
                        with open(archive_csv, 'a', newline='') as af, open(fixed_csv, 'a', newline='') as ff:
                            writer_a = csv.writer(af)
                            writer_f = csv.writer(ff)
                            writer_a.writerow(row)
                            writer_f.writerow(row)

                        # Clear buffer after saving frames so next trial gets fresh frames
                        frame_buffer.clear()

                        print("TIME: ", time.perf_counter()-writer_time0)



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

    # Shared control variables
    cur_idx = Value('i', 0)
    ts = Value('d', 0.0)
    stop_event = Event()

    # Shared timing values (seconds)
    t_read_total = Value('d', 0.0)
    t_frameacq = Value('d', 0.0)
    t_getts = Value('d', 0.0)
    t_frameconv = Value('d', 0.0)

    # Prepare run folder for this execution
    run_folder = RUN_FOLDER_PREFIX + datetime.now().strftime('%Y%m%d_%H%M%S')
    os.makedirs(run_folder, exist_ok=True)

    # Start processes
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

        # cleanup shared memory from main process
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
