import argparse
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Plot bar plot of latency data from a CSV log file.")
parser.add_argument("log_file", type=str, help="Path to the CSV log file containing latency data.")
args = parser.parse_args()

log_file = args.log_file

# Read and extract latency values
try:
    data = pd.read_csv(log_file)
    if 'latency_ms' not in data.columns:
        print("The CSV file does not contain a 'latency_ms' column.")
        exit()
    latencies = data['latency_ms'].dropna().astype(int).values
except Exception as e:
    print(f"Error reading the CSV file: {e}")
    exit()

if len(latencies) == 0:
    print("No latency data found.")
    exit()

# Compute mean and std of full data
mean_all = np.mean(latencies)
std_all = np.std(latencies)

# Filter out outliers beyond 3 standard deviations
z_scores = (latencies - mean_all) / std_all
filtered_latencies = latencies[np.abs(z_scores) < 3]

# Compute statistics after filtering
mean_filtered = np.mean(filtered_latencies)
std_filtered = np.std(filtered_latencies)
min_val = np.min(filtered_latencies)
max_val = np.max(filtered_latencies)
median_val = np.median(filtered_latencies)

# Print stats
print(f"Original samples: {len(latencies)}")
print(f"Filtered samples: {len(filtered_latencies)}")
print(f"Min latency (filtered): {min_val} ms")
print(f"Max latency (filtered): {max_val} ms")
print(f"Median latency (filtered): {median_val} ms")
print(f"Mean latency (filtered): {mean_filtered:.2f} ms")
print(f"Standard deviation (filtered): {std_filtered:.2f} ms")

# Count frequency of each latency value
unique_latencies, counts = np.unique(filtered_latencies, return_counts=True)

# Plot bar plot
plt.figure(figsize=(10, 6))
plt.bar(unique_latencies, counts, color='skyblue', edgecolor='black', alpha=0.7)

# Add vertical lines for stats
plt.axvline(mean_filtered, color='green', linestyle='--', label=f'Mean = {mean_filtered:.2f} ms')
plt.axvline(median_val, color='purple', linestyle=':', label=f'Median = {median_val:.2f} ms')
plt.axvline(min_val, color='gray', linestyle='--', label=f'Min = {min_val} ms')
plt.axvline(max_val, color='gray', linestyle='--', label=f'Max = {max_val} ms')

# Formatting
plt.title("Bar Plot of Button to Audio Latency (Outliers Removed)")
plt.xlabel("Latency (ms)")
plt.ylabel("Frequency")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()

# Save the plot with the same name as the log file with a suffix
# save it in a directory called figures
import matplotlib.pyplot as plt
import numpy as np
import os


# Ensure the 'figures' directory exists
os.makedirs("figures", exist_ok=True)


base_name = os.path.basename(log_file)
name, ext = os.path.splitext(base_name)
output_file = f"figures/{name}_histogram.svg"

plt.savefig(output_file)
print(f"Histogram saved as {output_file}")
plt.close()
