#!/usr/bin/env python3
"""
Join tableB.csv and tableA.csv by nearest perf-counter within tolerance (default 50 ms),
but KEEP ONLY rows that have a match in tableA (drop unmatched tableB rows).

Output: tableB_joined_nearest.csv (adds timestamp_perf_counter, latency_ms, match_dt_ms)
"""
import argparse
import os
import sys

try:
    import pandas as pd
except ImportError:
    print("This script requires pandas. Install with: pip install pandas")
    sys.exit(1)


def join_nearest_keep_matched(tableb_path, tablea_path, out_path, tolerance_s=0.05):
    tb = pd.read_csv(tableb_path)
    ta = pd.read_csv(tablea_path)

    # Required columns
    if 'record_time_perf' not in tb.columns:
        raise ValueError("tableB must contain 'record_time_perf' column.")
    if 'timestamp_perf_counter' not in ta.columns:
        raise ValueError("tableA must contain 'timestamp_perf_counter' column.")

    # Ensure floats
    tb['record_time_perf'] = tb['record_time_perf'].astype(float)
    ta['timestamp_perf_counter'] = ta['timestamp_perf_counter'].astype(float)

    # Sort (required by merge_asof)
    tb = tb.sort_values('record_time_perf').reset_index(drop=True)
    ta = ta.sort_values('timestamp_perf_counter').reset_index(drop=True)

    # Perform nearest merge with tolerance
    merged = pd.merge_asof(
        tb,
        ta,
        left_on='record_time_perf',
        right_on='timestamp_perf_counter',
        direction='nearest',
        tolerance=tolerance_s
    )

    # Add match difference in milliseconds
    merged['match_dt_ms'] = (merged['record_time_perf'] - merged['timestamp_perf_counter']).abs() * 1000.0

    # Keep only matched rows (timestamp_perf_counter not null)
    matched = merged.dropna(subset=['timestamp_perf_counter']).reset_index(drop=True)

    # Save matched only
    matched.to_csv(out_path, index=False)
    return merged, matched


def main():
    p = argparse.ArgumentParser(description="Join tableB and tableA by nearest perf-counter and keep only matched rows.")
    p.add_argument('--tableb', default='tableB.csv', help='Path to tableB CSV (default: tableB.csv)')
    p.add_argument('--tablea', default='tableA.csv', help='Path to tableA CSV (default: tableA.csv)')
    p.add_argument('--out', default='tableB_joined_nearest.csv', help='Output CSV path for matched rows')
    p.add_argument('--tol_ms', type=float, default=50.0, help='Tolerance in milliseconds (default: 50)')
    args = p.parse_args()

    tol_s = args.tol_ms / 1000.0

    if not os.path.exists(args.tableb):
        print(f"Error: {args.tableb} not found.")
        sys.exit(2)
    if not os.path.exists(args.tablea):
        print(f"Error: {args.tablea} not found.")
        sys.exit(2)

    merged_all, matched = join_nearest_keep_matched(args.tableb, args.tablea, args.out, tolerance_s=tol_s)

    total_b = len(merged_all)
    matched_n = len(matched)
    unmatched = total_b - matched_n
    mean_dt = matched['match_dt_ms'].mean() if matched_n else float('nan')

    print(f"Saved matched merged table to: {args.out}")
    print(f"Rows in tableB processed: {total_b}")
    print(f"Rows matched within {args.tol_ms} ms: {matched_n}")
    print(f"Rows dropped (no match): {unmatched}")
    if matched_n:
        print(f"Mean match difference (ms): {mean_dt:.3f}")


if __name__ == '__main__':
    main()
