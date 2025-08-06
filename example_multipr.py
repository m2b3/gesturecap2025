from multiprocessing import Lock, shared_memory, Event, Process, Value, Manager
import time
import numpy as np
#import matplotlib.pyplot as plt

FRAME_SHAPE = (480, 640, 3)
FRAME_DTYPE = np.uint8
TEST_IMG = np.zeros(FRAME_SHAPE, dtype=FRAME_DTYPE)

def precise_sleep(target_duration):
    end_time = time.perf_counter() + target_duration
    while time.perf_counter() < end_time:
        pass
    
def producer(shm_name0, shm_name1, cur_idx, stop_event, ts):
    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    while not stop_event.is_set():
        # Choose the non-current buffer to write to
        write_idx = 1 - cur_idx.value

        if write_idx == 0:
            np.copyto(buf0, TEST_IMG)
        else:
            np.copyto(buf1, TEST_IMG)

        ts.value = time.perf_counter()
        cur_idx.value = write_idx  # Atomically publish new frame

        precise_sleep(0.003)  # simulate ~300 FPS

    shm0.close()
    shm1.close()

def consumer(shm_name0, shm_name1, cur_idx, stop_event, ts, result_name):
    shm0 = shared_memory.SharedMemory(name=shm_name0)
    shm1 = shared_memory.SharedMemory(name=shm_name1)
    buf0 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm0.buf)
    buf1 = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm1.buf)

    latencies = []

    time.sleep(0.5)  # Let producer warm up

    while not stop_event.is_set():
        read_idx = cur_idx.value  # Read latest published index

        if read_idx == 0:
            _ = buf0.copy()
        else:
            _ = buf1.copy()

        age_ms = (time.perf_counter() - ts.value) * 1000
        latencies.append(age_ms)

        precise_sleep(0.004)

    # Write result to shared memory buffer
    shm_result = shared_memory.SharedMemory(name=result_name)
    result_buf = np.ndarray((len(latencies),), dtype=np.float64, buffer=shm_result.buf)
    result_buf[:] = latencies[:result_buf.shape[0]]
#    result_buf[:len(latencies)] = latencies

    shm0.close()
    shm1.close()
    shm_result.close()

if __name__ == "__main__":
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
    time.sleep(5)
    stop_event.set()
    p1.join()
    p2.join()

    # Read and plot result
    result = np.ndarray((N,), dtype=np.float64, buffer=shm_result.buf)
    result = result[result > 0]  # Drop unfilled values

    print(f"Mean: {np.mean(result):.6f} ms | Min: {np.min(result):.2f} | Max: {np.max(result):.2f}")
    np.savetxt("frame_ages.txt", result)

    # plt.plot(result)
    # plt.title("Latency (ms) with Double Buffering")
    # plt.xlabel("Frame #")
    # plt.ylabel("Latency (ms)")
    # plt.grid(True)
    # plt.show()

    # Cleanup
    shm0.close(); shm0.unlink()
    shm1.close(); shm1.unlink()
    shm_result.close(); 
    shm_result.unlink()