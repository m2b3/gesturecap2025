
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
For more details on the latency measurement setup/results, read (link to the other README.md in latency measurement folder, to be made)

## Instructions to setup (brief version of the gesturecap manual)
### Sections like hardware, software
- Inclusion: Can implement another video interface other than flircam

## Future work:
- Codebase: dockerisation
- Codebase: implementing multiprocessing in the main repository
- Optimisation: implementing multiple mediapipe workers


## About me 
(tbf)

