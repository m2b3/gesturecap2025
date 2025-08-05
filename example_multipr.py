from multiprocessing import Lock, shared_memory, Event, Process, Value, Manager
import time
import numpy as np
import matplotlib.pyplot as plt

FRAME_SHAPE = (480, 640, 3)
FRAME_DTYPE = np.uint8
TEST_IMG = np.zeros(FRAME_SHAPE, dtype=FRAME_DTYPE)

def producer(shm_name, lock, stop_event, ts):
    shm = shared_memory.SharedMemory(name=shm_name)
    frame_buffer = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm.buf)
    
    while not stop_event.is_set():
        with lock:
            np.copyto(frame_buffer, TEST_IMG)
            ts.value = time.time()
        time.sleep(0.003)

    shm.close()

def consumer(shm_name, lock, stop_event, ts, frame_ages):
    time.sleep(0.5)  # let producer start first
    shm = shared_memory.SharedMemory(name=shm_name)
    frame_buffer = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm.buf)

    while not stop_event.is_set():
        with lock:
            _ = frame_buffer.copy()
            age_ms = (time.time() - ts.value) * 1000
            frame_ages.append(age_ms)
        time.sleep(0.004)

    shm.close()

if __name__ == "__main__":
    size = np.prod(FRAME_SHAPE) * np.dtype(FRAME_DTYPE).itemsize
    shm = shared_memory.SharedMemory(create=True, size=size)
    
    frame_buffer = np.ndarray(FRAME_SHAPE, dtype=FRAME_DTYPE, buffer=shm.buf)
    np.copyto(frame_buffer, TEST_IMG)

    ts = Value('d', 0.0)
    lock = Lock()
    stop_event = Event()

    manager = Manager()
    frame_ages = manager.list()

    p_producer = Process(target=producer, args=(shm.name, lock, stop_event, ts))
    p_consumer = Process(target=consumer, args=(shm.name, lock, stop_event, ts, frame_ages))

    p_producer.start()
    p_consumer.start()

    time.sleep(5)
    stop_event.set()

    p_producer.join()
    p_consumer.join()

    shm.close()
    shm.unlink()

    # Convert to numpy array for stats
    ages = np.array(frame_ages)

    mean_age = np.mean(ages)
    median_age = np.median(ages)
    min_age = np.min(ages)
    max_age = np.max(ages)

    # Plot frame age with legend
    plt.plot(ages, label="Frame Age (ms)")
    plt.xlabel("Frame read count")
    plt.ylabel("Frame Age (ms)")
    plt.title("Frame Age over Time")

    legend_text = (
        f"Mean: {mean_age:.2f} ms\n"
        f"Median: {median_age:.2f} ms\n"
        f"Min: {min_age:.2f} ms\n"
        f"Max: {max_age:.2f} ms"
    )
    plt.legend([legend_text])
    plt.show()
