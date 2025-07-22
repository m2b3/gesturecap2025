import serial
from datetime import datetime
import os

port = "/dev/ttyACM0"

# Prompt user for configuration
device = input("Enter the device on which the experiment is conducted on: ")
baud_rate = int(input("Enter baud rate (e.g. 9600 or 115200): "))
method = input("Enter method description: ")
frequency = input("Enter frequency (Hz): ")
threshold = input("Enter threshold value: ")
pd_delay = input("Enter pd_delay (ms): ")
output_method = input("Enter output method ('aux', 'behringer', or 'focusrite'): ")

# Construct dynamic filename based on metadata
# timestamp_str = datetime.now().strftime('%Y%m%d_%H%M%S')
basename = f"delay_{method.replace(' ', '_')}_freq{frequency}_th{threshold}_{output_method}.txt"
output_dir = "latency_logs"
if not os.path.exists(output_dir):
    os.makedirs(output_dir)
output_file = os.path.join(output_dir, basename)

# Initialize serial connection
ser = serial.Serial(port, baud_rate)

with open(output_file, "w+") as f:
    # Write header metadata
    f.write(f"# Logging started at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    f.write(f"# Device: {device}\n")
    f.write(f"# Baud Rate: {baud_rate}\n")
    f.write(f"# Method: {method}\n")
    f.write(f"# Frequency: {frequency}\n")
    f.write(f"# Threshold: {threshold}\n")
    f.write(f"# PD Delay: {pd_delay}\n")
    f.write(f"# Output Method: {output_method}\n\n")
    f.flush()

    print(f"Logging started with device={device}, method={method}, frequency={frequency}, threshold={threshold}, pd_delay={pd_delay}, output_method={output_method}.")
    print(f"Saving to {output_file}")

    while True:
        try:
            line = ser.readline().decode().strip()
            if not line:
                continue

            # Only process numeric readings
            if line.isdigit():
                timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
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
