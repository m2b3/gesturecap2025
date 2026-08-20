# GestureCap OSC

Hand tracking and gesture-control pipeline for Max/MSP.

GestureCap OSC combines MediaPipe hand tracking, OSC communication, a multimode gesture routing matrix, and custom JSUI parameter dials for creative coding, interactive installations, and digital musical instruments.

---

## Pipeline

```text
MediaPipe Tracker
        ↓ OSC — 127.0.0.1:11111
Max/MSP Input
        ↓
Gesture Routing Matrix
        ↓
Custom Parameter Dials
        ↓
Audio or Visual Processing
```

The Python tracker sends controller data to Max. Routing, destination selection, and final signal processing remain inside the Max patch.

---

## Components

### MediaPipe Tracker

The Python tracker supports:

- Up to two hands simultaneously
- 21 MediaPipe landmarks per hand
- Real-time X, Y, and Z landmark data
- Local OSC streaming
- PyInstaller standalone packaging

OSC destination:

```text
127.0.0.1:11111
```

Hand addresses:

```text
/hand/left
/hand/right
```

See [Build Tracker on macOS](build-tracker.md) for the development and PyInstaller workflow.

### Gesture Routing Matrix

The Max `jsui` routing interface maps controller axes to 12 destination parameters.

Supported modes:

- Hands
- Clusters
- Gamepad
- Mouse
- Wearable controllers

Each mode preserves its own mappings and selections. In hand mode, landmark LEDs also control the corresponding Max gates.

See [Gesture Routing Matrix](routing-matrix.md) for messages, outputs, colors, and state behavior.

### Custom Parameter Dials

The custom JSUI dials visualize and process continuous normalized input through:

```text
Near / Far
→ Invert
→ Exponent
→ Playable Range
→ Unit Display
→ Triggers
```

See [Custom JSUI Dials](custom-dials.md) for controls, messages, outlets, and current state behavior.

### Max/MSP Patch

The main demonstration patch is:

```text
max/GestureCap_Tracker_Test.maxpat
```

It uses `mediapipe_handdraw.js` for landmark visualization and provides three tracker launchers for a regular Max patch, a Max Project, and a standalone application.

See [Max/MSP Integration](max-integration.md) for the component and launcher roles.

---

## Quick Start

1. Install the Python dependencies and test the tracker.
2. Start the tracker and allow camera access.
3. Receive OSC data in Max on port `11111`.
4. Route the desired source through the gesture matrix.
5. Send the mapped normalized value to one of the 12 custom dials.

The tracker may take approximately 20–30 seconds to initialize on its first launch while Python, MediaPipe, OpenCV, and supporting resources load.

---

## Main Files

```text
max/GestureCap_Tracker_Test.maxpat
mediapipe_handdraw.js
gesture_mapper_ui_multimode_extended.js
custom.dial.v9.js
run_mediapipe_maxmsp.js
run_mediapipe_maxmsp_project.js
run_mediapipe_standalone.js
build-tracker.md
macos-camera-permissions.md
routing-matrix.md
custom-dials.md
max-integration.md
```

Earlier JS files are development versions and are retained for reference.

---

## macOS Standalone Deployment

The tracker can be packaged with PyInstaller and launched from a Max standalone application.

The complete PyInstaller directory must be included in the application bundle:

```text
YourApp.app
└── Contents
    └── Resources
        └── tracker
            └── doublehand_mp/
                ├── doublehand_mp
                └── _internal/
```

Camera access may require an application usage description, entitlement, signing, and a TCC permission reset during development.

See [macOS Camera Permissions](macos-camera-permissions.md) for the complete workflow.

---

## Project Origin

GestureCap OSC is based on the original GestureCap project developed during Google Summer of Code 2025 under the INCF organization.

This fork supports gesture-to-sound research and development explored during Google Summer of Code 2026. It extends the original hand-tracking pipeline with OSC communication, Max/MSP integration, standalone packaging, gesture routing, and custom parameter interfaces.

---

## Current Development Areas

- Faster tracker startup
- Improved standalone deployment
- Automated macOS signing and entitlements
- Windows packaging
- Additional gesture recognition modules
- Extended controller and routing support

---

## Visual Assets

Interface icons are sourced from [Iconoir](https://iconoir.com/).

---

## License

See the project license for details.
