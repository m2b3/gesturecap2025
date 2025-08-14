import argparse
import matplotlib.pyplot as plt
import numpy as np
import csv

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Plot latency data from a CSV log file.")
parser.add_argument("log_file", type=str, help="Path to the CSV log file containing latency data.")
args = parser.parse_args()

log_file = args.log_file

# Read and extract latency values
latencies = []
with open(log_file, 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        try:
            latency = int(row['latency_ms'])
            latencies.append(latency)
        except (KeyError, ValueError):
            continue

if not latencies:
    print("No latency data found.")
    exit()

# Convert to numpy array
latencies = np.array(latencies)

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

# Plot
plt.figure(figsize=(10, 5))
plt.bar(range(len(filtered_latencies)), filtered_latencies, color='blue')
plt.title("Button to Audio Latency (Outliers Removed)")
plt.xlabel("Sample Index")
plt.ylabel("Latency (ms)")
plt.grid(axis='y')

# Stats lines
plt.axhline(mean_filtered, color='green', linestyle='--', label=f'Mean = {mean_filtered:.2f} ms')
plt.axhline(mean_filtered + std_filtered, color='orange', linestyle='--', label=f'+1σ = {mean_filtered + std_filtered:.2f} ms')
plt.axhline(mean_filtered - std_filtered, color='orange', linestyle='--', label=f'-1σ = {mean_filtered - std_filtered:.2f} ms')
plt.axhline(median_val, color='purple', linestyle=':', label=f'Median = {median_val:.2f} ms')
plt.axhline(min_val, color='gray', linestyle='--', label=f'Min = {min_val} ms')
plt.axhline(max_val, color='gray', linestyle='--', label=f'Max = {max_val} ms')

plt.legend()
plt.tight_layout()
plt.show()

# Save the plot with the same name as the log file with a suffix
# save it in a directory called figures
import os

# Ensure the 'figures' directory exists
os.makedirs("figures", exist_ok=True)

log_filename = os.path.basename(log_file)
plot_filename = f"figures/{os.path.splitext(log_filename)[0]}_latency_plot.svg"
plt.savefig(plot_filename)
print(f"Plot saved to {plot_filename}")
plt.close()