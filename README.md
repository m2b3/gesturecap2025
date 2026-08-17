# GestureCap OSC

MediaPipe hand-tracking for Max/MSP using OSC.

GestureCap OSC extends the original GestureCap pipeline with OSC communication, Max/MSP integration, PyInstaller packaging, and macOS standalone deployment workflows.

GestureCap OSC is a Python-based hand tracking toolkit designed to stream MediaPipe hand landmarks over OSC for creative coding, interactive installations, and Max/MSP workflows.

The project includes:

- Real-time MediaPipe hand tracking
- OSC streaming
- Max/MSP integration
- PyInstaller standalone packaging
- macOS standalone deployment workflow
- Development and standalone launcher scripts

---

## Project Origin

GestureCap OSC is based on the original GestureCap project developed during Google Summer of Code 2025 under the INCF organization.

This repository is a fork created to support the development of gesture-to-sound workflows explored during Google Summer of Code 2026.

The purpose of this fork is to extend the original MediaPipe hand-tracking pipeline with:

- OSC communication
- Max/MSP integration
- PyInstaller packaging
- macOS standalone deployment workflows

These modifications allow GestureCap to be integrated more easily into interactive music, digital instrument, and creative coding environments.

The work presented in this repository represents a technical branch of a larger gesture-to-sound research and development pipeline.

# Features

## Hand Tracking

- MediaPipe Hands
- Up to 2 hands simultaneously
- 21 landmarks per hand
- Real-time landmark streaming

## OSC Output

Each detected hand transmits:

```text
/hand/left
/hand/right
```

with:

```text
x
y
z
```

values for all MediaPipe landmarks.

---

## Max/MSP Integration

GestureCap OSC includes:

```text
max/
├── GestureCap_Tracker_Test.maxpat
├── mediapipe_handdraw.js
├── run_mediapipe_maxmsp.js
└── run_mediapipe_standalone.js
```

The test patch demonstrates:

- Tracker launch
- Tracker shutdown
- OSC reception
- Live hand visualization
- Standalone deployment workflow

---

# Project Structure

```text
gesturecap-osc
│
├── max/
├── video/
├── utils/
├── models/
│
├── doublehand_mp.py
├── requirements.txt
└── README.md
```

---

# Development Workflow

Launch the tracker directly from the repository:

```text
Max/MSP
↓
run_mediapipe_maxmsp.js
↓
doublehand_mp
↓
MediaPipe
↓
OSC
```

Ideal for:

- Development
- Debugging
- Testing

---

# Standalone Workflow

Build a Max Collective or Application.

Copy the complete PyInstaller tracker folder into:

```text
YourApp.app
└── Contents
    └── Resources
        └── tracker
            └── doublehand_mp
```

The standalone launcher uses:

```text
run_mediapipe_standalone.js
```

to launch the PyInstaller-packaged tracker.

---

# macOS Notes

The tracker has been validated on macOS and can be launched from:

```text
Terminal
```

or

```text
Max/MSP Standalone Applications
```

The standalone workflow requires camera permissions and application signing considerations.

See:

```text
docs/macos-camera-permissions.md
```

for deployment notes and troubleshooting information.

---

# Documentation

Additional documentation is available in the `docs/` directory:

- `docs/build-tracker-macos.md`
  Complete tracker build workflow for macOS (Apple Silicon and Intel).

- `docs/macos-camera-permissions.md`
  Camera permissions, application signing, entitlements, and standalone deployment notes for macOS.

---


# Known Issues

## Startup Time

The tracker may take approximately:

```text
20–30 seconds
```

to initialize on first launch.

This delay is caused by:

- Python runtime initialization
- MediaPipe loading
- TensorFlow Lite initialization
- OpenCV startup
- Matplotlib font cache generation

Please be patient. The Live Hand Visualizer window will open automatically once initialization is complete.

---

## Camera Permissions on macOS

In some standalone configurations, the tracker may fail with:

```text
OpenCV: not authorized to capture video
```

or:

```text
Could not open webcam at index 0
```

while the same executable works correctly when launched directly from Terminal.

This behavior appears to be related to macOS camera permissions (TCC), code signing, and application entitlements when launching the tracker as a child process from a Max/MSP standalone application.

A documented workaround and deployment pipeline are included in the repository.

---

# Additions in this Fork

- OSC workflow integration
- Max/MSP integration
- Development and standalone launcher workflows
- PyInstaller packaging
- macOS standalone deployment testing
- Camera permission investigation and documentation


---

# Future Improvements

- Faster startup times
- Improved standalone deployment workflow
- Automated macOS entitlement handling
- Windows packaging workflow
- Additional gesture recognition modules
- Extended OSC mappings
- Cross-platform build automation

---

# License

See the project license for details.