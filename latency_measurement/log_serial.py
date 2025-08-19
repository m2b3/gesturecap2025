import serial
from datetime import datetime
import time
import os
import json
import csv

"""
This script logs latency measurements from a serial device.
It uses a config.json file for experiment parameters,
creates a clean folder per experiment, and stores:
- log.txt : experiment metadata + text log
- tableA.csv : structured latency data
"""

# ---------------------- Paths and defaults ----------------------
default_config_path = "config/log_config.json"
base_output_dir = "latency_logs"

default_keys = [
    ("device", "Enter the device on which the experiment is conducted"),
    ("baud_rate", "Enter baud rate (e.g. 9600 or 115200)"),
    ("method", "Enter method description"),
    ("frequency", "Enter frequency (Hz)"),
    ("threshold", "Enter threshold value"),
    ("pd_delay", "Enter pd_delay (ms)"),
    ("output_method", "Enter output method ('aux_speaker', 'aux_direct', 'focusrite')")
]

# ---------------------- Load config ----------------------
config = {}
if os.path.exists(default_config_path):
    with open(default_config_path, "r") as cfg_file:
        config = json.load(cfg_file)

    use_cfg = input(f"Load existing config from {default_config_path}? [Y/n]: ").strip().lower() or "y"
    if use_cfg == "y":
        modify = input("Modify this config? [y/N]: ").strip().lower() or "n"
        if modify == "y":
            for key, prompt in default_keys:
                current = config.get(key, "")
                new_val = input(f"{prompt} [{current}]: ").strip()
                if new_val:
                    if key == "baud_rate":
                        new_val = int(new_val)
                    config[key] = new_val
            with open(default_config_path, "w") as cfg_file:
                json.dump(config, cfg_file, indent=4)
    else:
        # Create fresh config
        for key, prompt in default_keys:
            val = input(f"{prompt}: ").strip()
            if key == "baud_rate":
                val = int(val)
            config[key] = val
        with open(default_config_path, "w") as cfg_file:
            json.dump(config, cfg_file, indent=4)
else:
    print(f"No config file found. Creating new one at {default_config_path}.")
    for key, prompt in default_keys:
        val = input(f"{prompt}: ").strip()
        if key == "baud_rate":
            val = int(val)
        config[key] = val
    with open(default_config_path, "w") as cfg_file:
        json.dump(config, cfg_file, indent=4)

# ---------------------- Extract config ----------------------
device = config["device"]
baud_rate = int(config["baud_rate"])
method = config["method"]
frequency = config["frequency"]
threshold = config["threshold"]
pd_delay = config["pd_delay"]
output_method = config["output_method"]

# ---------------------- Make output directory ----------------------
# Format: latency_logs/device_method_freqXXHz_thYY_outMethod
dir_name = f"{device}_{method}_freq{frequency}Hz_th{threshold}_out{output_method}"
dir_name = dir_name.replace(" ", "_")  # sanitize spaces
output_dir = os.path.join(base_output_dir, dir_name)

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

log_file = os.path.join(output_dir, "log.txt")
csv_file = os.path.join(output_dir, "tableA.csv")

# ---------------------- Serial setup ----------------------
port = "/dev/ttyACM0"
ser = serial.Serial(port, baud_rate)

# ---------------------- Logging ----------------------
with open(log_file, "w+") as f_txt, open(csv_file, "w", newline="") as f_csv:
    csv_writer = csv.writer(f_csv)
    csv_writer.writerow(["timestamp_perf_counter", "latency_ms"])  # headers

    # Write metadata
    f_txt.write(f"# Logging started at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    for key in config:
        f_txt.write(f"# {key.replace('_', ' ').title()}: {config[key]}\n")
    f_txt.write("\n")
    f_txt.flush()

    print(f"\nLogging started.")
    print(f"Experiment folder: {output_dir}")
    print(f"TXT log: {log_file}")
    print(f"CSV table: {csv_file}\n")

    while True:
        try:
            line = ser.readline().decode().strip()
            if not line:
                continue

            if line.isdigit():
                timestamp = time.perf_counter()
                latency_ms = int(line)
                entry_txt = f"{timestamp}, {latency_ms} ms"

                print(entry_txt)
                f_txt.write(entry_txt + "\n")
                f_txt.flush()

                csv_writer.writerow([timestamp, latency_ms])
                f_csv.flush()

        except KeyboardInterrupt:
            print("\nLogging stopped by user.")
            break
        except Exception as e:
            print("Error:", e)
            continue
