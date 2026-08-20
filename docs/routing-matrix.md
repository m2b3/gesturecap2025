# Gesture Routing Matrix

The Gesture Routing Matrix is a Max/MSP `jsui` interface for assigning controller axes to 12 destination parameters.

The current implementation is:

```text
gesture_mapper_ui_multimode_extended.js
```

It controls mapping and visualization only. Real-time signal routing remains in the Max patch.

---

## Supported Modes

| Mode | Sources | Axes |
| --- | --- | --- |
| `hands` | 21 landmarks per hand | X, Y, Z |
| `clusters` | 12 sources per side | X, Y, Z |
| `gamepad` | 1 source per side | X, Y, Radius, Rotary |
| `mouse` | 1 source per side | X, Y |
| `wearable` | 1 source per side | X, Y, Z |

Change mode with:

```text
mode hands
mode clusters
mode gamepad
mode mouse
mode wearable
```

Each mode preserves its own selection, active sources, and mappings.

---

## Source States

The interface keeps three states separate:

- **Active** — the source gate is open.
- **Selected** — the source is currently shown in the large matrix.
- **Mapped** — an axis-to-parameter cell is enabled.

Several hand landmarks can remain active simultaneously, while only one source per side is selected for editing.

For each parameter row, only one axis can be mapped at a time. Selecting another axis turns the previous axis off and reports both changes to Max.

---

## Hand Interaction

Clicking a landmark LED toggles its active state and sends a gate message through the second outlet:

```text
ledleft 9 1
ledright 21 0
```

The number identifies the MediaPipe landmark from `1` to `21`. The final value is its active state.

Clicking a small matrix changes the selected source without changing the active state of other landmarks.

---

## Outputs

### First outlet — mapping

```text
source axis parameter state
```

Examples:

```text
left_index_tip 0 3 1
right_wrist 2 8 0
left_cluster_4 1 7 1
gamepad_left 2 0 1
mouse_right 1 3 1
```

Axis and parameter indexes are zero-based. Parameters range from `0` to `11`.

### Second outlet — hand gates

```text
ledleft landmark state
ledright landmark state
```

This outlet is used only in `hands` mode.

---

## Colors

Colors accept normalized RGBA values:

```text
leftborderactive r g b a
rightborderactive r g b a

leftborderinactive r g b a
rightborderinactive r g b a

leftbgactive r g b a
rightbgactive r g b a

leftbginactive r g b a
rightbginactive r g b a
```

Change both inactive borders at once with:

```text
inactivebordercolor 0.329 0.376 0.451 1.
```

The earlier `leftcolor` and `rightcolor` messages remain available as shortcuts for active colors.

---

## Reset Messages

```text
clear
```

Resets LEDs, gates, selection, and mappings for the current mode. Colors are preserved.

```text
clearall
```

Resets states and mappings for all modes. Colors are preserved.

```text
clearmappings
```

Clears mappings for the current mode while preserving active LEDs, gates, and selection.

---

## Preset Storage

The matrix supports Max `pattrstorage` through `getvalueof()`, `setvalueof()`, and `notifyclients()`.

Mode states and mappings are serialized as Max atoms. Color settings are controlled separately through Max messages.
