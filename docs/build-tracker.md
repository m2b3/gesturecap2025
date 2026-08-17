# Build Tracker on macOS

This document describes the process used to build the GestureCap OSC tracker from source on macOS.

The procedure is identical for:

- Apple Silicon (arm64)
- Intel Macs (x86_64)

The generated executable will automatically match the architecture of the Python environment used during the build.

---

# Requirements

## Software

Install:

- Python 3.11 (recommended)
- Git
- uv
- PyInstaller

## Verify Python

```bash
python3 --version
```

Example:

```text
Python 3.11.x
```

---

# Clone the Repository

```bash
git clone https://github.com/mikaelmolliex/gesturecap-osc.git
cd gesturecap-osc
```

---

# Create a Virtual Environment

Using uv:

```bash
uv venv
source .venv/bin/activate
```

Verify the environment:

```bash
which python
```

Expected output:

```text
.../gesturecap-osc/.venv/bin/python
```

---

# Install Dependencies

Install the project requirements:

```bash
uv pip install -r requirements.txt
```

If PyInstaller is not included in the requirements:

```bash
uv pip install pyinstaller
```

---

# Test the Tracker

Before creating an executable, verify that the tracker works directly in Python.

Run:

```bash
python doublehand_mp.py
```

Expected behavior:

- Webcam opens
- MediaPipe initializes
- Hand landmarks are detected
- OSC messages are transmitted
- Preview window appears

If the tracker does not work here, do not continue with PyInstaller until the issue is resolved.

---

# Build the Tracker

Activate the virtual environment:

```bash
source .venv/bin/activate
```

Build using the existing specification file:

```bash
pyinstaller doublehand_mp.spec
```

After a successful build:

```text
dist/
└── doublehand_mp/
    ├── doublehand_mp
    └── _internal/
```

---

# Test the Built Executable

Run the packaged tracker:

```bash
./dist/doublehand_mp/doublehand