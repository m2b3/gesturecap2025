import serial
from datetime import datetime
import time
import os
import json
import csv

# Paths
default_config_path = 'config.json'
output_dir = 'latency_logs'

# Default configuration keys
default_keys = [
    ('device', 'Enter the device on which the experiment is conducted on'),
    ('baud_rate', 'Enter baud rate (e.g. 9600 or 115200)'),
    ('method', 'Enter method description'),
    ('frequency', 'Enter frequency (Hz)'),
    ('threshold', 'Enter threshold value'),
    ('pd_delay', 'Enter pd_delay (ms)'),
    ('output_method', "Enter output method ('aux_speaker', 'aux_direct', or 'focusrite')")
]

# Load existing config or create new one
config = {}
if os.path.exists(default_config_path):
    with open(default_config_path, 'r') as cfg_file:
        config = json.load(cfg_file)
    use_cfg = input(f"Load existing config from {default_config_path}? [Y/n]: ").strip().lower() or 'y'
    if use_cfg == 'y':
        modify = input("Modify this config? [y/N]: ").strip().lower() or 'n'
        if modify == 'y':
            for key, prompt in default_keys:
                current = config.get(key, '')
                new_val = input(f"{prompt} [{current}]: ").strip()
                if new_val:
                    if isinstance(current, int):
                        new_val = int(new_val)
                    config[key] = new_val
            with open(default_config_path, 'w') as cfg_file:
                json.dump(config, cfg_file, indent=4)
    else:
        for key, prompt in default_keys:
            val = input(f"{prompt}: ").strip()
            if key in ('baud_rate',):
                val = int(val)
            config[key] = val
        with open(default_config_path, 'w') as cfg_file:
            json.dump(config, cfg_file, indent=4)
else:
    print(f"No config file found. Creating new one at {default_config_path}.")
    for key, prompt in default_keys:
        val = input(f"{prompt}: ").strip()
        if key == 'baud_rate':
            val = int(val)
        config[key] = val
    with open(default_config_path, 'w') as cfg_file:
        json.dump(config, cfg_file, indent=4)

# Unpack config values
device = config['device']
baud_rate = int(config['baud_rate'])
method = config['method']
frequency = config['frequency']
threshold = config['threshold']
pd_delay = config['pd_delay']
output_method = config['output_method']

# Setup output files
basename = f"delay_{method.replace(' ', '_')}_freq{frequency}_th{threshold}_{output_method}.txt"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

output_file_txt = os.path.join(output_dir, basename)
output_file_csv = os.path.join(output_dir, "tableA.csv")

# Initialize serial connection
port = "/dev/ttyACM0"
ser = serial.Serial(port, baud_rate)

with open(output_file_txt, "w+") as f_txt, open(output_file_csv, "w", newline="") as f_csv:
    # CSV writer
    csv_writer = csv.writer(f_csv)
    csv_writer.writerow(["timestamp_perf_counter", "latency_ms"])  # CSV headers

    # Write header metadata to txt
    f_txt.write(f"# Logging started at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    for key in config:
        f_txt.write(f"# {key.replace('_', ' ').title()}: {config[key]}\n")
    f_txt.write("\n")
    f_txt.flush()

    print(f"Logging started with device={device}, method={method}, frequency={frequency}, threshold={threshold}, pd_delay={pd_delay}, output_method={output_method}.")
    print(f"Saving TXT to {output_file_txt}")
    print(f"Saving CSV to {output_file_csv}")

    while True:
        try:
            line = ser.readline().decode().strip()
            if not line:
                continue

            if line.isdigit():
                timestamp = time.perf_counter()
                latency_ms = int(line)
                entry_txt = f"{timestamp}, {latency_ms} ms"

                # Write to TXT
                print(entry_txt)
                f_txt.write(entry_txt + "\n")
                f_txt.flush()

                # Write to CSV
                csv_writer.writerow([timestamp, latency_ms])
                f_csv.flush()

        except KeyboardInterrupt:
            print("\nLogging stopped by user.")
            break
        except Exception as e:
            print("Error:", e)
            continue
