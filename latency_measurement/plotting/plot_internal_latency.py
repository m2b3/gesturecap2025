import pandas as pd
import matplotlib.pyplot as plt
import argparse

# Parse command-line arguments
parser = argparse.ArgumentParser(description="Plot frame age and detection time latencies from a CSV file.")
parser.add_argument("file_path", type=str, help="Path to the input CSV file.")
args = parser.parse_args()

# Load CSV
df = pd.read_csv(args.file_path)

# Remove outliers using IQR (optional)
# valid_frame_age = remove_outliers(df['frame_age_ms'])
# valid_detect_time = remove_outliers(df['detect_time_ms'])
valid_frame_age = df['frame_age_ms']
valid_detect_time = df['detect_time_ms']

# Keep only indices where both are valid
valid_indices = valid_frame_age.index.intersection(valid_detect_time.index)
df_clean = df.loc[valid_indices]

# Compute stats
def stats_text(series):
    return (f"(mean={series.mean():.2f}ms, median={series.median():.2f}ms, "
            f"min={series.min():.2f}ms, max={series.max():.2f}ms, std={series.std():.2f}ms)")

label_frame_age = f"Frame Age {stats_text(df_clean['frame_age_ms'])}"
label_detect_time = f"Detection Time {stats_text(df_clean['detect_time_ms'])}"

# Plot
plt.plot(df_clean.index, df_clean['frame_age_ms'], label=label_frame_age)
plt.plot(df_clean.index, df_clean['detect_time_ms'], label=label_detect_time)
plt.xlabel('Sample #')
plt.ylabel('Latency (ms)')
plt.title('Latency per Sample')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
