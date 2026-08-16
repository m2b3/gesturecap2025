# macOS Camera Permissions

DriftMap embeds a standalone MediaPipe/OpenCV tracker inside the Max/MSP application bundle.

The tracker is launched through Node for Max:

```text
DriftMap.app
    ↓
Node for Max
    ↓
spawn()
    ↓
doublehand_mp
    ↓
OpenCV / MediaPipe
    ↓
Camera
```

## Problem

The tracker worked when launched directly from Terminal, but failed when launched from inside the Max standalone:

```text
OpenCV: not authorized to capture video
Could not open webcam at index 0
```

The issue was not caused by MediaPipe, OpenCV, PyInstaller, or `spawn()` itself.

The Max standalone already contained:

```text
NSCameraUsageDescription
```

but the application did not have the macOS camera entitlement attached to its code signature.

## Camera entitlement

Create an `entitlements.plist` file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">

<plist version="1.0">
<dict>
    <key>com.apple.security.device.camera</key>
    <true/>
</dict>
</plist>
```

Check that the file is valid:

```bash
plutil -lint entitlements.plist
```

## Apply the entitlement

After building DriftMap and adding the tracker to the application bundle, re-sign the application locally:

```bash
codesign --force --deep \
  --entitlements entitlements.plist \
  --sign - \
  /Applications/DriftMap.app
```

`--sign -` creates an ad-hoc signature suitable for local development and testing.

## Verify the entitlement

```bash
codesign -d --entitlements :- /Applications/DriftMap.app
```

The output should contain:

```xml
<key>com.apple.security.device.camera</key>
<true/>
```

## Reset camera permissions during development

DriftMap uses the bundle identifier:

```text
com.mikael.driftmap
```

To force macOS to request camera permission again:

```bash
tccutil reset Camera com.mikael.driftmap
```

Then quit and reopen DriftMap.

macOS should display a camera permission request when the tracker attempts to open the webcam.

## Post-build workflow

```text
Build DriftMap.app in Max
        ↓
Copy the PyInstaller tracker into
Contents/Resources/tracker/
        ↓
Verify NSCameraUsageDescription
        ↓
Apply com.apple.security.device.camera
        ↓
Re-sign DriftMap.app
        ↓
Launch DriftMap
        ↓
macOS requests camera permission
        ↓
Node launches doublehand_mp
        ↓
OpenCV / MediaPipe accesses the camera
```

## Automated helper

The same process can be automated with:

```text
prepare_driftmap.command
```

The helper script:

* copies the complete PyInstaller tracker into the app bundle;
* checks `NSCameraUsageDescription`;
* validates `entitlements.plist`;
* applies the camera entitlement;
* re-signs DriftMap locally;
* verifies the resulting signature.

This local ad-hoc signing step is for development/testing. It is separate from Developer ID signing and notarization used for public macOS distribution.
