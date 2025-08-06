import os
import glob
import numpy as np
import matplotlib.pyplot as plt

# Script to process all latency log files in a folder,
# compute statistics, and save time series and histogram plots.

def process_log_file(log_path, output_dir):
    latencies = []
    with open(log_path, 'r') as f:
        for line in f:
            parts = line.strip().split(',')
            if len(parts) != 2:
                continue
            try:
                latency_str = parts[1].strip().split()[0]
                latencies.append(int(latency_str))
            except ValueError:
                continue

    if not latencies:
        print(f"No data in {log_path}")
        return

    arr = np.array(latencies)
    mean_all = arr.mean()
    std_all = arr.std()
    # remove outliers beyond 3 standard deviations
    z = (arr - mean_all) / std_all
    filtered = arr[np.abs(z) < 3]

    # compute stats
    stats = {
        'original_count': len(arr),
        'filtered_count': len(filtered),
        'min': filtered.min(),
        'max': filtered.max(),
        'median': np.median(filtered),
        'mean': filtered.mean(),
        'std': filtered.std()
    }
    print(f"Processed {os.path.basename(log_path)}: {stats}")

    base = os.path.splitext(os.path.basename(log_path))[0]

    # ensure output directories
    ts_dir = os.path.join(output_dir, 'time_series')
    hist_dir = os.path.join(output_dir, 'histograms')
    os.makedirs(ts_dir, exist_ok=True)
    os.makedirs(hist_dir, exist_ok=True)

    # time series plot
    plt.figure(figsize=(10, 5))
    plt.plot(filtered, marker='o', linestyle='-')
    plt.title(f"Latency over samples: {base}")
    plt.xlabel("Index")
    plt.ylabel("Latency (ms)")
    plt.axhline(stats['min'], color='gray', linestyle='--', label=f"Min = {stats['min']} ms")
    plt.axhline(stats['max'], color='black', linestyle='--', label=f"Max = {stats['max']} ms")
    plt.axhline(stats['median'], color='purple', linestyle=':', label=f"Median = {stats['median']:.2f} ms")
    plt.axhline(stats['mean'], color='green', linestyle='--', label=f"Mean = {stats['mean']:.2f} ms")
    plt.axhline(stats['mean'] + stats['std'], color='orange', linestyle='--', label=f"Mean + 1σ = {stats['mean']+stats['std']:.2f} ms")
    plt.axhline(stats['mean'] - stats['std'], color='orange', linestyle='--', label=f"Mean - 1σ = {stats['mean']-stats['std']:.2f} ms")
    plt.legend()
    plt.grid(True)
    ts_path = os.path.join(ts_dir, f"{base}_latency_plot.png")
    plt.savefig(ts_path)
    plt.close()

    # histogram plot
    plt.figure(figsize=(10, 6))
    plt.hist(filtered, bins=30, edgecolor='black', alpha=0.7)
    plt.title(f"Latency histogram: {base}")
    plt.xlabel("Latency (ms)")
    plt.ylabel("Count")
    plt.axvline(stats['min'], color='gray', linestyle='--', label=f"Min = {stats['min']} ms")
    plt.axvline(stats['max'], color='black', linestyle='--', label=f"Max = {stats['max']} ms")
    plt.axvline(stats['median'], color='purple', linestyle=':', label=f"Median = {stats['median']:.2f} ms")
    plt.axvline(stats['mean'], color='green', linestyle='--', label=f"Mean = {stats['mean']:.2f} ms")
    plt.axvline(stats['mean'] + stats['std'], color='orange', linestyle='--', label=f"Std = {stats['std']:.2f} ms")
    plt.legend()
    plt.grid(True)
    hist_path = os.path.join(hist_dir, f"{base}_histogram.png")
    plt.savefig(hist_path)
    plt.close()


def batch_process(folder, output_dir='figures_png'):
    # find all txt files in folder
    files = glob.glob(os.path.join(folder, '*.txt'))
    if not files:
        print(f"No .txt files found in {folder}")
        return
    for f in files:
        process_log_file(f, output_dir)


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(
        description='Batch process latency logs and save plots')
    parser.add_argument('folder', help='Folder with log text files')
    parser.add_argument('--out', default='figures_png', help='Output directory')
    args = parser.parse_args()

    batch_process(args.folder, args.out)
