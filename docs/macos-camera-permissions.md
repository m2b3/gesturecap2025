# macOS Camera Permissions

This document describes a macOS camera permission workflow for standalone applications embedding a MediaPipe/OpenCV tracker.

A common deployment architecture is:

```text
YourApp.app
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

---

# Problem

The tracker may work correctly when launched directly from Terminal but fail when launched from a standalone application:

```text
OpenCV: not authorized to capture video
Could not open webcam at index 0
```

In many cases, the application already contains:

```text
NSCameraUsageDescription
```

but the application bundle has not been signed with the appropriate camera entitlement.

---

# Camera Entitlement

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

Validate the file:

```bash
plutil -lint entitlements.plist
```

Expected output:

```text
entitlements.plist: OK
```

---

# Apply the Entitlement

After building the standalone application and copying the tracker into the application bundle, re-sign the application locally:

```bash
codesign --force --deep \
  --entitlements entitlements.plist \
  --sign - \
  /Applications/YourApp.app
```

`--sign -` creates an ad-hoc signature suitable for local development and testing.

---

# Verify the Entitlement

Display the active entitlements:

```bash
codesign -d --entitlements :- /Applications/YourApp.app
```

The output should contain:

```xml
<key>com.apple.security.device.camera</key>
<true/>
```

---

# Reset Camera Permissions During Development

Retrieve the application's bundle identifier:

```bash
defaults read /Applications/YourApp.app/Contents/Info CFBundleIdentifier
```

Example:

```text
com.company.yourapp
```

Reset the camera permission:

```bash
tccutil reset Camera com.company.yourapp
```

Then:

1. Quit the application.
2. Launch the application again.
3. Allow camera access when macOS requests permission.

---

# Standalone Deployment Workflow

```text
Build YourApp.app
        ↓
Copy PyInstaller tracker into
Contents/Resources/tracker/
        ↓
Verify NSCameraUsageDescription
        ↓
Apply com.apple.security.device.camera
        ↓
Re-sign YourApp.app
        ↓
Launch YourApp
        ↓
macOS requests camera permission
        ↓
Node launches doublehand_mp
        ↓
OpenCV / MediaPipe accesses the camera
```

---

# Tracker Deployment

The complete PyInstaller build should be copied into:

```text
YourApp.app
└── Contents
    └── Resources
        └── tracker
            └── doublehand_mp
```

Including:

```text
doublehand_mp
_internal/
```

Do not copy only the executable.

The full PyInstaller directory structure is required.

---

# Automated Helper Script

The entire process can be automated with a deployment script such as:

```text
prepare_tracker.command
```

Typical tasks include:

- Copying the PyInstaller tracker into the application bundle
- Checking `NSCameraUsageDescription`
- Validating `entitlements.plist`
- Applying the camera entitlement
- Re-signing the application bundle
- Verifying the resulting signature

---

# Notes

This workflow is intended for local development and testing.

Ad-hoc signing:

```bash
--sign -
```

does not replace:

- Developer ID signing
- Notarization
- App Store distribution requirements

For public distribution, standard Apple code-signing and notarization workflows should be used.

---

# Known Symptom

A common sign of a camera permission or signing issue is:

```text
OpenCV: not authorized to capture video
```

followed by:

```text
Could not open webcam at index 0
```

even though the same tracker executable works correctly when launched directly from Terminal.

When this occurs, verify:

- `NSCameraUsageDescription`
- Bundle identifier
- Camera entitlement
- Application signature
- TCC camera permissions