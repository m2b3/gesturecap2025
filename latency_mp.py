from multiprocessing import Lock, shared_memory, Event, Process, Value, Manager
import time
import numpy as np
import json
import csv
from pythonosc import udp_client
from flircam import Flircam
from hand_pose_detector import HandPoseDetector
import matplotlib.pyplot as plt


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

    
def producer(shm_name0, shm_name1, cur_idx, stop_event, ts):

    cam = Flircam()
    cam.start()
    # time.sleep(1)
    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    try:
        while not stop_event.is_set():

                frame, _ = cam.read_frame()
                # frame, _ = cam.get_frame()
                # print("frame produced")
                if not frame.any():
                    stop_event.set()
                    break


                # Choose the non-current buffer to write to
                write_idx = 1 - cur_idx.value

                if write_idx == 0:
                    np.copyto(buf0, frame)
                else:
                    np.copyto(buf1, frame)

                ts.value = time.perf_counter()
                cur_idx.value = write_idx  # Automically publish new frame
                # precise_sleep(0.003)  # simulate ~300 FPS
    except KeyboardInterrupt:
        print("P1: KEYB INTTERUPT")
    finally:
    
        cam.cleanup()
        shm0.close()
        shm1.close()
        print("PRODUCER EXITS GRACEFULLY")


def consumer(shm_name0, shm_name1, cur_idx, stop_event, ts, result_name):
    
    y_line, stdev, mean = load_calibration()
    threshold = mean + 3 * stdev
    print(f"Using y_line={y_line}, threshold={threshold:.2f}px")

    osc_ip, osc_port = '127.0.0.1', 11111
    # osc_ip, osc_port = '192.168.2.2', 11111
    client = udp_client.SimpleUDPClient(osc_ip, osc_port)
    
    detector = HandPoseDetector()

    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    latencies = []

    time.sleep(0.5)  # Let producer warm up

    state = 0
    counter = 0
    print("Starting hand-tap detection. Press 'q' to exit.")
    
    while not stop_event.is_set():
        read_idx = cur_idx.value  # Read latest published index

        if read_idx == 0:
            frame = buf0.copy()
        else:
            frame = buf1.copy()

        age_ms = (time.perf_counter() - ts.value) * 1000
        # print(age_ms)

        # detection logic goes here
        # precise_sleep(0.003) # Simulation
        hands = detector.detect_hand_pose(frame)
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
                    tapped = True
                    counter += 1
                    print(f"Tap #{counter}")
                    client.send_message('/trigger', 1)

        
        latencies.append(age_ms)
    # Write result to shared memory buffer
    shm_result = shared_memory.SharedMemory(name=result_name)
    result_buf = np.ndarray((len(latencies),), dtype=np.float64, buffer=shm_result.buf)
    result_buf[:] = latencies[:result_buf.shape[0]]
    # result_buf[:len(latencies)] = latencies

    stop_event.set()
    shm0.close()
    shm1.close()
    shm_result.close()
    print("CONSUMER EXITS GRACEFULLY")

if __name__ == "__main__":
    import multiprocessing as mp
    mp.set_start_method('forkserver', force=True)

    size = int(np.prod(FRAME_SHAPE) * np.dtype(FRAME_DTYPE).itemsize)
    shm0 = shared_memory.SharedMemory(create=True, size=size)
    shm1 = shared_memory.SharedMemory(create=True, size=size)

    # Shared control variables
    cur_idx = Value('i', 0)
    ts = Value('d', 0.0)
    stop_event = Event()

    # Result array for latencies (shared)
    N = 2000
    shm_result = shared_memory.SharedMemory(create=True, size=N * 8)

    # Start processes
    p1 = Process(target=producer, args=(shm0.name, shm1.name, cur_idx, stop_event, ts))
    p2 = Process(target=consumer, args=(shm0.name, shm1.name, cur_idx, stop_event, ts, shm_result.name))

    p1.start()
    p2.start()
    
    try:
        while p1.is_alive():
            continue
    except KeyboardInterrupt:
        stop_event.set()
    finally:
        stop_event.set()
        p1.join()
        p2.join()

        # Read and plot result
        result = np.ndarray((N,), dtype=np.float64, buffer=shm_result.buf)
        # print(result)
        result = result[result > 0]  # Drop unfilled values

        print(f"Mean: {np.mean(result):.6f} ms | Min: {np.min(result):.2f} | Max: {np.max(result):.2f}")
        np.savetxt("frame_ages.txt", result)

        plt.plot(result)
        plt.title("Latency (ms) with Double Buffering")
        plt.xlabel("Frame #")
        plt.ylabel("Latency (ms)")
        plt.grid(True)
        plt.show()

        # Cleanup
        shm0.close(); shm0.unlink()    
        shm1.close(); shm1.unlink()    
        shm_result.close(); 
        shm_result.unlink()