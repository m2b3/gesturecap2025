import serial
from datetime import datetime

ser = serial.Serial('/dev/ttyACM0', 9600)

output_file = "delay_log.txt"

with open(output_file, "w+") as f:
    print(f"Logging started. Saving to {output_file}")
    while True:
        try:
            line = ser.readline().decode().strip()
            print(line)
            if line.isdigit():
                timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                f.write(f"{timestamp}, {line} ms\n")
                f.flush()
                print(f"{timestamp}: {line} ms")
        except KeyboardInterrupt:
            print("\nLogging stopped by user.")
            break
        except Exception as e:
            print("Error:", e)
