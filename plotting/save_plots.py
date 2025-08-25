#!/usr/bin/env python3
"""
CSV Performance Data Plotter

This script processes performance data CSV files and generates three types of plots:
1. Latency vs Timestamp (line plot)
2. Latency distribution (histogram)  
3. Sum of frame_age and t_read_total vs Latency (scatter plot)

Each plot includes statistical annotations (mean, median, min, max, std dev).
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
from pathlib import Path
import seaborn as sns
import argparse

def calculate_stats(data):
    """Calculate statistical measures for the data."""
    return {
        'mean': np.mean(data),
        'median': np.median(data),
        'min': np.min(data),
        'max': np.max(data),
        'std': np.std(data)
    }

def create_stats_legend(stats, label_prefix=""):
    """Create a formatted string for statistical legend."""
    legend_text = []
    if label_prefix:
        legend_text.append(f"{label_prefix}:")
    legend_text.extend([
        f"Mean: {stats['mean']:.2f}",
        f"Median: {stats['median']:.2f}",
        f"Min: {stats['min']:.2f}",
        f"Max: {stats['max']:.2f}",
        f"Std Dev: {stats['std']:.2f}"
    ])
    return "\n".join(legend_text)

def plot_latency_vs_timestamp(df, output_dir, folder_name):
    """Create latency vs timestamp plot."""
    plt.figure(figsize=(12, 8))
    
    # Main plot
    plt.plot(df['timestamp_perf_counter'], df['latency_ms'], 'b-', alpha=0.7, linewidth=1)
    plt.scatter(df['timestamp_perf_counter'], df['latency_ms'], alpha=0.5, s=20)
    
    # Calculate stats
    latency_stats = calculate_stats(df['latency_ms'])
    
    # Add horizontal lines for mean and median
    plt.axhline(y=latency_stats['mean'], color='red', linestyle='--', alpha=0.7, label=f"Mean: {latency_stats['mean']:.2f} ms")
    plt.axhline(y=latency_stats['median'], color='green', linestyle='--', alpha=0.7, label=f"Median: {latency_stats['median']:.2f} ms")
    
    plt.xlabel('Timestamp Performance Counter', fontsize=12)
    plt.ylabel('Latency (ms)', fontsize=12)
    plt.title(f'Latency vs Timestamp - {folder_name}', fontsize=14, fontweight='bold')
    plt.grid(True, alpha=0.3)
    
    # Create stats text box
    stats_text = create_stats_legend(latency_stats, "Latency Stats")
    plt.text(0.02, 0.98, stats_text, transform=plt.gca().transAxes, 
             verticalalignment='top', bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.8),
             fontsize=10, fontfamily='monospace')
    
    plt.legend(loc='upper right')
    plt.tight_layout()
    
    output_path = os.path.join(output_dir, 'latency_vs_timestamp.png')
    plt.savefig(output_path, dpi=300, bbox_inches='tight')
    plt.close()
    
    return output_path

def plot_latency_histogram(df, output_dir, folder_name):
    """Create latency distribution histogram."""
    plt.figure(figsize=(10, 8))
    
    # Create histogram
    n_bins = min(50, len(df) // 2) if len(df) > 10 else 10
    counts, bins, patches = plt.hist(df['latency_ms'], bins=n_bins, alpha=0.7, color='skyblue', edgecolor='black')
    
    # Calculate stats
    latency_stats = calculate_stats(df['latency_ms'])
    
    # Add vertical lines for mean and median
    plt.axvline(x=latency_stats['mean'], color='red', linestyle='--', linewidth=2, label=f"Mean: {latency_stats['mean']:.2f} ms")
    plt.axvline(x=latency_stats['median'], color='green', linestyle='--', linewidth=2, label=f"Median: {latency_stats['median']:.2f} ms")
    
    plt.xlabel('Latency (ms)', fontsize=12)
    plt.ylabel('Frequency', fontsize=12)
    plt.title(f'Latency Distribution - {folder_name}', fontsize=14, fontweight='bold')
    plt.grid(True, alpha=0.3)
    
    # Create stats text box
    stats_text = create_stats_legend(latency_stats, "Distribution Stats")
    plt.text(0.98, 0.98, stats_text, transform=plt.gca().transAxes, 
             verticalalignment='top', horizontalalignment='right',
             bbox=dict(boxstyle='round', facecolor='lightgreen', alpha=0.8),
             fontsize=10, fontfamily='monospace')
    
    plt.legend(loc='upper right')
    plt.tight_layout()
    
    output_path = os.path.join(output_dir, 'latency_histogram.png')
    plt.savefig(output_path, dpi=300, bbox_inches='tight')
    plt.close()
    
    return output_path

def plot_combined_time_vs_latency(df, output_dir, folder_name):
    """Create plot of sum(frame_age + t_read_total) vs latency."""
    plt.figure(figsize=(10, 8))
    
    # Calculate combined time
    combined_time = df['frame_age_ms'] + df['t_read_total_ms']
    
    # Create scatter plot
    plt.scatter(combined_time, df['latency_ms'], alpha=0.6, s=30)
    
    # Add trend line
    z = np.polyfit(combined_time, df['latency_ms'], 1)
    p = np.poly1d(z)
    plt.plot(combined_time, p(combined_time), "r--", alpha=0.8, linewidth=2, label=f'Trend line (slope: {z[0]:.3f})')
    
    # Calculate correlation coefficient
    correlation = np.corrcoef(combined_time, df['latency_ms'])[0, 1]
    
    # Calculate stats for both variables
    combined_stats = calculate_stats(combined_time)
    latency_stats = calculate_stats(df['latency_ms'])
    
    plt.xlabel('Frame Age + Read Total Time (ms)', fontsize=12)
    plt.ylabel('Latency (ms)', fontsize=12)
    plt.title(f'Combined Time vs Latency - {folder_name}', fontsize=14, fontweight='bold')
    plt.grid(True, alpha=0.3)
    
    # Create comprehensive stats text box
    stats_text = (f"Combined Time Stats:\n"
                 f"Mean: {combined_stats['mean']:.2f}\n"
                 f"Median: {combined_stats['median']:.2f}\n"
                 f"Min: {combined_stats['min']:.2f}\n"
                 f"Max: {combined_stats['max']:.2f}\n"
                 f"Std: {combined_stats['std']:.2f}\n\n"
                 f"Latency Stats:\n"
                 f"Mean: {latency_stats['mean']:.2f}\n"
                 f"Median: {latency_stats['median']:.2f}\n"
                 f"Min: {latency_stats['min']:.2f}\n"
                 f"Max: {latency_stats['max']:.2f}\n"
                 f"Std: {latency_stats['std']:.2f}\n\n"
                 f"Correlation: {correlation:.3f}")
    
    plt.text(0.02, 0.98, stats_text, transform=plt.gca().transAxes, 
             verticalalignment='top', bbox=dict(boxstyle='round', facecolor='lightyellow', alpha=0.8),
             fontsize=9, fontfamily='monospace')
    
    plt.legend(loc='lower right')
    plt.tight_layout()
    
    output_path = os.path.join(output_dir, 'combined_time_vs_latency.png')
    plt.savefig(output_path, dpi=300, bbox_inches='tight')
    plt.close()
    
    return output_path

def process_csv_file(csv_path, output_dir):
    """Process a single CSV file and generate all plots."""
    try:
        # Read the CSV file
        df = pd.read_csv(csv_path)
        
        # Validate required columns
        required_columns = ['timestamp_perf_counter', 'latency_ms', 'frame_age_ms', 't_read_total_ms']
        missing_columns = [col for col in required_columns if col not in df.columns]
        
        if missing_columns:
            print(f"Error: Missing columns in {csv_path}: {missing_columns}")
            return False
        
        # Check if we have data
        if len(df) == 0:
            print(f"Warning: No data found in {csv_path}")
            return False
        
        # Get folder name for titles
        folder_name = os.path.basename(os.path.dirname(csv_path))
        
        print(f"Processing {csv_path} with {len(df)} records...")
        
        # Generate all plots
        plot1_path = plot_latency_vs_timestamp(df, output_dir, folder_name)
        plot2_path = plot_latency_histogram(df, output_dir, folder_name)
        plot3_path = plot_combined_time_vs_latency(df, output_dir, folder_name)
        
        print(f"  Generated plots:")
        print(f"    - {plot1_path}")
        print(f"    - {plot2_path}")
        print(f"    - {plot3_path}")
        
        return True
        
    except Exception as e:
        print(f"Error processing {csv_path}: {str(e)}")
        return False

def main(root_directory="freezed_logs"):
    """Main function to iterate through all merged_filtered.csv files and generate plots."""
    
    # Set style for better looking plots
    plt.style.use('default')
    sns.set_palette("husl")
    
    root_path = Path(root_directory)
    
    if not root_path.exists():
        print(f"Error: Root directory '{root_directory}' does not exist!")
        return
    
    processed_count = 0
    error_count = 0
    
    # Find all merged_filtered.csv files
    csv_files = list(root_path.glob("*/merged_filtered.csv"))
    
    if not csv_files:
        print(f"No merged_filtered.csv files found in {root_directory}")
        return
    
    print(f"Found {len(csv_files)} CSV files to process...")
    print("=" * 50)
    
    for csv_file in csv_files:
        folder_dir = csv_file.parent
        
        # Process the CSV and generate plots
        success = process_csv_file(csv_file, folder_dir)
        
        if success:
            processed_count += 1
        else:
            error_count += 1
        
        print("-" * 30)
    
    print("=" * 50)
    print(f"Processing complete!")
    print(f"Successfully processed: {processed_count} files")
    print(f"Errors encountered: {error_count} files")

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="Process CSV files and generate plots.")
    parser.add_argument(
        "--root_dir",
        type=str,
        default="freezed_logs",
        help="Root directory containing the CSV files (default: 'freezed_logs')"
    )
    args = parser.parse_args()

    main(args.root_dir)