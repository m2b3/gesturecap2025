import pandas as pd
import matplotlib.pyplot as plt

# Load CSV
df = pd.read_csv("tableB.csv")

# Convert frame age to milliseconds
df['frame_age_ms'] = df['frame_age'] * 1000

# Remove outliers using IQR
def remove_outliers(series):
    q1 = series.quantile(0.25)
    q3 = series.quantile(0.75)
    iqr = q3 - q1
    lower = q1 - 1.5 * iqr
    upper = q3 + 1.5 * iqr
    return series[(series >= lower) & (series <= upper)]

# Filter valid frame ages
valid_frame_age = remove_outliers(df['frame_age_ms'])
df_clean = df.loc[valid_frame_age.index]

# Compute stats
def stats_text(series):
    return f"(mean={series.mean():.2f}ms, min={series.min():.2f}ms, max={series.max():.2f}ms, std={series.std():.2f}ms)"

label_frame_age = f"Frame Age {stats_text(df_clean['frame_age_ms'])}"

# Plot
plt.plot(df_clean.index, df_clean['frame_age_ms'], label=label_frame_age)
plt.xlabel('Sample #')
plt.ylabel('Frame Age (ms)')
plt.title('Frame Age per Sample (Outliers Removed)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
