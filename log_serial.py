import serial
from datetime import datetime
import time
import os
import json

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
            # Prompt for each key, showing the current value
            for key, prompt in default_keys:
                current = config.get(key, '')
                new_val = input(f"{prompt} [{current}]: ").strip()
                if new_val:
                    # Cast to int if original was numeric
                    if isinstance(current, int):
                        new_val = int(new_val)
                    config[key] = new_val
            # Save back
            with open(default_config_path, 'w') as cfg_file:
                json.dump(config, cfg_file, indent=4)
        # else: keep loaded config
    else:
        # Ignore existing config: prompt fresh and overwrite
        for key, prompt in default_keys:
            val = input(f"{prompt}: ").strip()
            # Cast numbers
            if key in ('baud_rate',):
                val = int(val)
            config[key] = val
        with open(default_config_path, 'w') as cfg_file:
            json.dump(config, cfg_file, indent=4)
else:
    # No config exists: prompt user and save
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

# Setup output file
basename = f"delay_{method.replace(' ', '_')}_freq{frequency}_th{threshold}_{output_method}.txt"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)
output_file = os.path.join(output_dir, basename)

# Initialize serial connection
port = "/dev/ttyACM0"
ser = serial.Serial(port, baud_rate)

with open(output_file, "w+") as f:
    # Write header metadata
    f.write(f"# Logging started at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    for key in config:
        f.write(f"# {key.replace('_', ' ').title()}: {config[key]}\n")
    f.write("\n")
    f.flush()

    print(f"Logging started with device={device}, method={method}, frequency={frequency}, threshold={threshold}, pd_delay={pd_delay}, output_method={output_method}.")
    print(f"Saving to {output_file}")

    while True:
        try:
            line = ser.readline().decode().strip()
            if not line:
                continue

            if line.isdigit():
                timestamp = time.time()
                entry = f"{timestamp}, {line} ms"
                print(entry)
                f.write(entry + "\n")
                f.flush()

        except KeyboardInterrupt:
            print("\nLogging stopped by user.")
            break
        except Exception as e:
            print("Error:", e)
            continue
