# GestureCap OSC v0.1.0 — Local Gesture Mapping Pipeline

GestureCap OSC is Part A of a larger expressive instrument pipeline developed for Google Summer of Code 2026.

This release captures MediaPipe hand landmarks locally, sends them to Max/MSP through OSC, routes gesture axes through a multimode JSUI matrix, and shapes 12 destination parameters with custom dials.

```text
Local MediaPipe tracking
→ OSC data routing
→ gesture mapping
→ parameter control
```

## Recommended Downloads

### Complete project — ready to run

```text
gesturecap-osc-v0.1.0-macos-arm64-complete.zip
```

Recommended for Max/MSP users. The complete package includes the project, patch, documentation, and signed/notarized tracker in the correct `dist/doublehand_mp/` location.

Quick start:

1. Download and unzip the complete package.
2. Open `max/GestureCap_Tracker_Test.maxpat`.
3. Enable the camera/video control.

No Python installation or manual tracker placement is required.

### Tracker only

```text
gesturecap-tracker-macos-arm64.zip
```

Use this smaller asset if you only need the MediaPipe/OSC tracker for another Max Project, standalone, or OSC application. Keep the complete extracted `doublehand_mp/` directory, including `_internal/`.

Optional checksum assets may also be provided:

```text
gesturecap-osc-v0.1.0-macos-arm64-complete.zip.sha256
gesturecap-tracker-macos-arm64.zip.sha256
```

## Highlights

- local and private MediaPipe processing with no cloud dependency
- Apple Silicon (`arm64`) tracker signed with Developer ID and notarized by Apple
- direct launch from Max/MSP
- OpenCV preview and embedded Max landmark visualization
- Hands and Clusters modes for MediaPipe control
- Wearable mode for OSC controllers
- Gamepad and Mouse modes for USB/Bluetooth testing and exploration
- routing matrix for 12 destination parameters
- custom calibration, inversion, curve, range, unit, and trigger controls

## Platform

The packaged tracker in this release targets macOS Apple Silicon (`arm64`). Intel macOS and Windows require separate builds.

## GSoC 2026 Context

This repository forms the gesture-capture and mapping component of a broader expressive instrument framework. A separate wavetable reconstruction toolkit forms Part B; together, both projects provide reusable building blocks for gesture-controlled sound synthesis and other audiovisual applications.
