# Max/MSP Integration

The main demonstration patch is:

```text
max/GestureCap_Tracker_Test.maxpat
```

It connects the MediaPipe tracker, OSC reception, hand visualization, gesture routing matrix, and custom parameter dials.

---

## JSUI Components

### Hand Landmark Visualizer

```text
mediapipe_handdraw.js
```

Draws the MediaPipe landmarks received by the Max patch.

### Gesture Routing Matrix

```text
gesture_mapper_ui_multimode_extended.js
```

Selects active sources and maps controller axes to the 12 destination parameters.

### Custom Parameter Dial

```text
custom.dial.v9.js
```

Displays raw input and processes calibration, inversion, exponent, playable range, units, and triggers.

---

## Tracker Launchers

Three launcher scripts cover the different Max deployment contexts:

| Script | Context |
| --- | --- |
| `run_mediapipe_maxmsp.js` | regular Max patch |
| `run_mediapipe_maxmsp_project.js` | Max Project |
| `run_mediapipe_standalone.js` | Max standalone application |

Use the launcher that matches the environment containing the patch. The routing and interface logic remains the same in all three contexts.

The tracker is distributed separately through the [latest GitHub Release](https://github.com/mikaelmolliex/gesturecap-osc/releases/latest). The current macOS Apple Silicon asset is signed with a Developer ID and notarized by Apple. Keep the complete `doublehand_mp/` directory, including `_internal/`.

### Regular Max patch

```text
gesturecap-osc/
├── dist/
│   └── doublehand_mp/
│       ├── doublehand_mp
│       └── _internal/
└── max/
    └── run_mediapipe_maxmsp.js
```

The launcher expects `dist/doublehand_mp/doublehand_mp` relative to the repository root.

### Max Project

`run_mediapipe_maxmsp_project.js` resolves a `tracker/doublehand_mp/` directory relative to the project launcher. Confirm the resolved location after reorganizing a Max Project.

### Max standalone

The expected bundle structure is:

```text
YourApp.app/
└── Contents/
    └── Resources/
        └── tracker/
            └── doublehand_mp/
                ├── doublehand_mp
                └── _internal/
```

The provided `run_mediapipe_standalone.js` currently contains `DriftMap.app` as an example application name. Replace it with the actual standalone name or change `TRACKER_PATH` to match the final bundle.

Embedding the signed tracker is not sufficient for public distribution. The surrounding `.app` must be signed with its required entitlements, and the final ZIP, DMG, or installer must be notarized separately. See [macOS Camera Permissions](macos-camera-permissions.md).

---

## Data Flow

```text
Tracker
  ↓ OSC — 127.0.0.1:11111
GestureCap_Tracker_Test.maxpat
  ├── mediapipe_handdraw.js
  ├── gesture_mapper_ui_multimode_extended.js
  └── custom.dial.v9.js × 12
```

The JSUI components handle visualization, mapping, and parameter control. OSC reception and real-time routing remain in Max/MSP.
