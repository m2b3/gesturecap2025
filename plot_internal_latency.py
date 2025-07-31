import pandas as pd
import matplotlib.pyplot as plt

# Load CSV
df = pd.read_csv("tableB.csv")

# Convert latency columns to milliseconds
df['internal_latency_ms'] = df['internal_latency_total'] * 1000
df['processing_latency_ms'] = df['latency_processing'] * 1000

# Remove outliers using IQR
def remove_outliers(series):
    q1 = series.quantile(0.25)
    q3 = series.quantile(0.75)
    iqr = q3 - q1
    lower = q1 - 1.5 * iqr
    upper = q3 + 1.5 * iqr
    return series[(series >= lower) & (series <= upper)]

# Apply outlier filtering
valid_internal = remove_outliers(df['internal_latency_ms'])
valid_processing = remove_outliers(df['processing_latency_ms'])

# Keep only indices where both are valid
valid_indices = valid_internal.index.intersection(valid_processing.index)
df_clean = df.loc[valid_indices]

# Compute stats
def stats_text(series):
    return f"(mean={series.mean():.2f}ms, min={series.min():.2f}ms, max={series.max():.2f}ms, std={series.std():.2f}ms)"

label_internal = f"Total Internal Latency {stats_text(df_clean['internal_latency_ms'])}"
label_processing = f"MP Processing Latency {stats_text(df_clean['processing_latency_ms'])}"

# Plot
plt.plot(df_clean.index, df_clean['internal_latency_ms'], label=label_internal)
plt.plot(df_clean.index, df_clean['processing_latency_ms'], label=label_processing)
plt.xlabel('Sample #')
plt.ylabel('Latency (ms)')
plt.title('Latency per Sample (Outliers Removed)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
