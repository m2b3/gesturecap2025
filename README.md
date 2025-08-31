
# GestureCap: Google Summer of Code 2025

GestureCap is a real-time system that uses computer vision and sound synthesis to turn hand gestures into sound controls. It lets users create and shape sounds interactively through their hand movements.

## Introduction

This year, our work on GestureCap focused on improving responsiveness and accuracy across the system. A major part of the effort went into precise latency measurement, since in HCI systems latency defines the gap between a user’s intended action and the system’s audio or visual response. To measure this, we built a setup using a Teensy microcontroller that directly monitors the audio signal through analog input. This allows us to capture the delay between a hand gesture making contact with a surface and the resulting sound output. The latency is measured from two timestamps on a shared clock based on electrical signals that are directly/indirectly triggered at the same time as the hand gesture and audio output.

We also reworked the GestureCap pipeline by moving from a multithreaded to a multiprocessing approach, giving more efficient use of system resources and reducing processing delays. 

In addition, we introduced a calibration system for real-time trigger detection, which ensures accurate and consistent measurements across different test runs. With these optimizations, GestureCap now delivers faster and more reliable gesture-to-sound interaction, especially when paired with a high FPS camera.



## Contributions

### Latency Measurement system

This year, we built a new latency measurement setup to get more accurate and reliable results. The Teensy 4.1 directly timestamps both the trigger event (electrical contact) and the audio detection, ensuring that there are no in-between communication delays that could distort the readings.

By monitoring the audio signal either through a direct AUX connection or a microphone input, the system captures the true end-to-end latency from gesture to sound output. This setup removes errors from USB or serial communication timing and gives a clean, consistent measurement.

Combined with the updated multiprocessing pipeline and a calibration system for real-time trigger detection, our latency measurements are now precise and consistent across multiple hardware setups, from high-performance desktops to standard laptops.

### Parallelization

This pipeline sets up a two-process, shared-memory video processing system for low-latency hand-tap detection and OSC triggering. 

The producer process captures frames from a FLIR camera, measures acquisition and conversion times, and writes each frame into one of two pre-allocated shared memory buffers, switching between them to avoid overwriting in-use data. It also updates shared timing values and a timestamp indicating when the frame was captured. 

The consumer process continuously reads the latest available frame from shared memory, runs the hand pose detector, and applies a tap detection algorithm based on pre-loaded calibration parameters. When a valid tap is detected, it sends an OSC trigger message and logs timing metrics (frame age, camera read time breakdown, and detection time) to a CSV file. 

The system uses Python’s multiprocessing shared memory and Value objects for fast, lock-free data transfer, ensuring minimal frame latency between capture and detection. The design allows the camera capture and the pose detection to run in parallel without blocking each other. 

### Calibration System  

We implemented a **real-time calibration system** to make trigger detection both accurate and consistent. The goal is to ensure the system reacts **exactly when the user makes a trigger gesture**, without firing early or with noticeable delay.  

During calibration, the system:  
1. Records the average vertical position (*y*-coordinate) of the hand landmarks when the hand is resting on the surface.  
2. Measures the natural pixel noise from Mediapipe’s tracking.  
3. Sets the detection threshold using the formula: `Threshold = Mean Rest Position + (3 × Standard Deviation)`  

This approach ensures the threshold stays far enough from the resting noise to prevent false positives, while still low enough to trigger instantly when the user’s hand actually makes contact.  

This setup is currently used for **surface trigger detection**, but the same logic can be adapted for other cases, for example, mapping gestures between two points in space for range-based interactions.  

The calibration can be repeated anytime and adapts automatically to changes in camera alignment, lighting, or hand position, keeping detection **accurate and consistent across sessions and hardware setups**.  

## Results

With a high-FPS camera and a good GPU, we are able to achieve a median latency of 13ms.

#### Camera: [Blackfly S BFS-U3-04S2C](https://www.flir.fr/products/blackfly-s-usb3/?vertical=machine+vision&segment=iis)

 - This is a 522 FPS USB-3 based camera
 - As this camera has a bunch of configurable parameters, the corresponding wrapper class uses the ones fitting this model the best. Therefore these parameters should be adapted if another model is used.

#### Laptop : ASUS TUF A15, an RTX-4060 based laptop, with 16GB of RAM and Ryzen 9 CPU.


## Latency Measurement Instructions

### 1. Software Setup (GPU Configuration)

**Boost GPU clocks before starting experiments:**
```bash
sudo nvidia-smi -lgc=3000,3000 && sudo nvidia-smi -lmc 8000,8000
```

**Check GPU clocks:**
```bash
nvidia-smi -q -d CLOCK
```

**Reset GPU clocks after experiment:**
```bash
sudo nvidia-smi --reset-memory-clocks && sudo nvidia-smi --reset-gpu-clocks
```

**Run scripts with GPU:**
Use your system's GPU execution command for all main Python scripts. For NVIDIA Optimus systems:
```bash
prime-run python latency_mp.py
```

**Scripts Involved:**
- `latency_measurement/preview_flircam.py` – camera positioning
- `latency_measurement/calibration.py` – set reference line and calibration distance
- `latency_measurement/latency_mp.py` – latency testing
- `latency_measurement/log_serial.py` – serial logging from Teensy
- `data_cleanup/join_tables.py` – combine latency logs into a CSV

### 2. Audio Setup

- Connect AUX cable from your computer to the speaker
- Place the microphone sensor close to the speaker membrane

### 3. Teensy Setup – Microphone + Speaker Mode

- Connect Teensy pins: GND → Ground, 3V → VCC, A0 → Pin 23 (or whichever analog pin you configure)
- Confirm selected pin matches the Teensy code
- Upload the `raw_data_plot` code to the Teensy to check values in silent conditions
- Set the threshold in `latency.ino` comfortably above the silent baseline level
- Test the setup by tapping the microphone and observing the readings

### 4. Teensy Setup – Raw AUX Analog Mode

- Use an open-ended AUX wire: Ground terminal → GND on Teensy, Positive terminal → Analog pin (currently Pin 23)
- Repeat the steps for Teensy code and `raw_data_plot` upload
- Set threshold in `latency.ino` comfortably above silent readings

### 5. Threshold Configuration

**Setting Limits in latency.ino:**
- Lower limit: theoretical minimum latency minus a few ms for margin
- Upper limit: theoretical maximum latency plus a few ms
- This prevents spurious readings outside expected bounds

**Current Reference Values:**
- Raw analog AUX: threshold = 30
- Microphone + speaker: threshold = 80

*Note: These values were determined by observing silent readings with `raw_data_plot`. Adjust if you notice false positives or missed taps.*

### 6. Physical Setup – Hand Tap Sensor

- Paste aluminum foil at the edge of a flat surface
- Connect any Teensy GND pin to the foil using an alligator clip/wire
- Connect a wire to the buttonPin (currently Pin 2)
- Attach this wire to the side of your left pinky finger, minimizing obstruction of the back of your hand
- Connect the Teensy to your computer via USB

### 7. Camera Setup

- Connect the FLIR camera to your computer
- Run camera positioning script:
```bash
prime-run python preview_flircam.py  # or your GPU command
```
- Adjust camera so foil edge is parallel to the reference line
- Press 'q' to close

### 8. Calibration

```bash
prime-run python calibration.py  # or your GPU command
```

- Click twice along the foil edge with maximum precision
- Keep left hand vertical on surface with pinky resting sideways on foil
- Script measures distance between Avg(y-coord(17 to 20)) and reference line for 1 second
- Ensure right hand is not visible during measurement

### 9. Calibration Verification

```bash
prime-run python latency_mp.py  # or your GPU command
```

**Run these tests:**
- **Hover test:** Taps should only trigger when hand is very close to foil (< few mm)
- **Rapid taps test:** Tap rapidly - false positives should be rare (about 1 in 7 or better)
- **Still hand test:** Rest hand sideways on surface - no taps should register when stationary

*If tests fail, repeat calibration and adjust camera exposure in `flircam.py` or room lighting.*

### 10. Audio Software Setup (PureData)

- Open PureData and load `beep.pd`
- Set frequency to 200 Hz
- Go to Audio Settings: select AUX output device, set delay = 3 ms
- Test by pressing button in PureData to confirm sound plays from speaker

### 11. Data Collection

**Start the measurement:**
```bash
prime-run python latency_mp.py  # or your GPU command
```

**In a separate terminal, start logging:**
```bash
python log_serial.py
```

**Configuration:**
- Script uses `config.json` with these keys:
  - `device`: Experiment device name
  - `baud_rate`: Serial connection rate (9600 or 115200)
  - `method`: Audio detection method description
  - `frequency`: Audio signal frequency (Hz)
  - `threshold`: Detection threshold value
  - `pd_delay`: PureData delay (milliseconds)
  - `output_method`: Output method (AUX + speaker-mic, direct AUX, etc.)

**Data Collection:**
- Re-attach wire to pinky
- Test with a few taps to confirm latencies are logging
- Restart both scripts and begin experiment
- Perform approximately 250 taps to obtain ~200 valid latency samples

### 12. Data Processing

```bash
prime-run python join_tables.py --tablea path/to/TableA.csv \
    --tableb path/to/TableB.csv --out path/to/final.csv --tol_ms 50
```

**Output:**
- Two files saved: `TableA.csv`, `TableB.csv`
- `join_tables.py` handles false positives/negatives automatically
- Final CSV contains total latency and breakdown of internal latencies for each tap

### 13. Optional – Pre-Tap Frame Capture

In the `latency_mp.py` script, set `SAVE_FRAMES = True`


- Saves `LAST_N_FRAMES` before tap detection (default to `7`)
- Wait at least 500ms between taps (saving 7 frames require 500ms)

### 14. Cleanup

- Disconnect the FLIR camera
- Disconnect the Teensy from USB
- Reset GPU clocks to default settings:
```bash
sudo nvidia-smi --reset-memory-clocks && sudo nvidia-smi --reset-gpu-clocks
```

## For Future Contributors:

### Multiprocessing Integration
The multiprocessing implementation from this GSoC project needs to be integrated into the original GestureCap repository: [m2b3/gesturecap](https://github.com/m2b3/gesturecap)

Future contributors should focus on merging this multiprocessing code into the main codebase and ensuring it maintains project integrity while improving performance.

### Optimization: Multiple MediaPipe Workers
Currently, the consumer process handles both MediaPipe frame processing and OSC signal production. This can be further optimized by separating these tasks:

- **MediaPipe Worker Pool:** Create multiple MediaPipe processors that work in parallel to extract landmarks from frames as soon as they become available
- **OSC Signal Process:** A separate process that takes landmarks from the worker pool, maps them to gestures, and sends OSC signals

### Dockerization
The project should be containerized using Docker to resolve dependency issues with the Spinnaker SDK. Consider using UV for faster Python package management.
Key Requirements:

- Proper GPU passthrough configuration to maintain low-latency performance
- Hardware device access for camera and audio interfaces
- USB device passthrough for Teensy/serial connections


## About Me

Deepansh is an undergraduate Computer Science and Engineering Student from India. He has a strong passion for Robotics, Perception and HCI-systems.
Additionally, he holds the position of core member in a Robotics Research and Development Society called A.T.O.M Robotics Lab at his college. 
Deepansh enjoys learning new technologies, building cool things, and automating tasks.



