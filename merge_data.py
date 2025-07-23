import pandas as pd
import matplotlib.pyplot as plt

# 1. Load your CSVs
dfA = pd.read_csv('fileA.csv')    # columns: timestampA, latencyA
dfB = pd.read_csv('fileB.csv')    # columns: timestampB, latencyB

# 2. Sort by timestamps (required for merge_asof)
dfA = dfA.sort_values('timestampA')
dfB = dfB.sort_values('timestampB')

# 3. Fuzzy-merge A→B within ±0.8 s
merged = pd.merge_asof(
    dfA,
    dfB,
    left_on='timestampA',
    right_on='timestampB',
    tolerance=0.8,
    direction='nearest'
)

# 4. “Accepted” samples = those where we actually found a B match
accepted = merged.dropna(subset=['timestampB']).reset_index(drop=True)

# 5. (Optional) If you want to inspect how many were dropped:
num_total = len(merged)
num_accepted = len(accepted)
num_false_pos = num_total - num_accepted
print(f"Total A rows: {num_total}")
print(f"Matched (accepted): {num_accepted}")
print(f"Unmatched (false positives in A): {num_false_pos}")

# 6. Plot only the accepted pairs
plt.figure(figsize=(6,6))
plt.scatter(accepted['latencyA'], accepted['latencyB'], s=5)
plt.xlabel('latencyA')
plt.ylabel('latencyB')
plt.title('latencyA vs. latencyB (only accepted pairs)')
plt.grid(True)
plt.show()
