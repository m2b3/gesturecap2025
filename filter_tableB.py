#!/usr/bin/env python3
"""
dedupe_tableB.py

Keep only the first row in each time-window of N milliseconds.
By default the script treats `record_time_perf` as seconds (as in your sample)
and removes rows that occur within 100 ms of the previously-kept row.

Usage:
    python dedupe_tableB.py tableB.csv
    python dedupe_tableB.py tableB.csv --out tableB_dedup.csv --threshold-ms 100
"""

import argparse
import pandas as pd

def dedupe_by_time(df, time_col='record_time_perf', threshold_ms=100):
    # ensure sorted by time
    df_sorted = df.sort_values(time_col).reset_index(drop=True)
    keep_idx = []
    last_kept_time = -1e18
    threshold_s = threshold_ms / 1000.0

    for idx, row in df_sorted.iterrows():
        t = float(row[time_col])
        if (t - last_kept_time) > threshold_s:
            keep_idx.append(idx)
            last_kept_time = t
        # else: drop row (within threshold of last kept)

    return df_sorted.loc[keep_idx].reset_index(drop=True)

def main():
    p = argparse.ArgumentParser(description="Remove rows within a short time window (keep first).")
    p.add_argument("infile", help="Input CSV (e.g. tableB.csv)")
    p.add_argument("--out", "-o", default=None, help="Output CSV (default: <infile>_dedup.csv)")
    p.add_argument("--threshold-ms", "-t", default=100, type=float,
                   help="Time window in milliseconds (default 100 ms)")
    p.add_argument("--time-col", default="record_time_perf",
                   help="Name of the time column (default 'record_time_perf')")
    args = p.parse_args()

    df = pd.read_csv(args.infile)
    out_name = args.out or (args.infile.rsplit('.',1)[0] + '_dedup.csv')

    df_clean = dedupe_by_time(df, time_col=args.time_col, threshold_ms=args.threshold_ms)
    df_clean.to_csv(out_name, index=False)
    print(f"Input rows: {len(df):,} | Kept rows: {len(df_clean):,} -> wrote {out_name}")

if __name__ == "__main__":
    main()
