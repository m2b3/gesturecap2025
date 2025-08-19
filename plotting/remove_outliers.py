"""
Simple outlier removal script for CSV performance data.
Removes outliers from latency_ms using IQR method and saves as merged_filtered.csv
"""

import pandas as pd
import numpy as np
from pathlib import Path

def remove_outliers_iqr(df, column):
    """Remove outliers using Interquartile Range (IQR) method."""
    Q1 = df[column].quantile(0.25)
    Q3 = df[column].quantile(0.75)
    IQR = Q3 - Q1
    
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    
    return df[(df[column] >= lower_bound) & (df[column] <= upper_bound)]

def process_csv_file(csv_path):
    """Process a single CSV file and remove outliers."""
    try:
        # Read the CSV file
        df = pd.read_csv(csv_path)
        
        if 'latency_ms' not in df.columns:
            print(f"Error: 'latency_ms' column not found in {csv_path}")
            return False
        
        original_count = len(df)
        
        # Remove outliers
        df_filtered = remove_outliers_iqr(df, 'latency_ms')
        filtered_count = len(df_filtered)
        removed_count = original_count - filtered_count
        
        # Save filtered data
        output_path = csv_path.parent / 'merged_filtered.csv'
        df_filtered.to_csv(output_path, index=False)
        
        print(f"Processed {csv_path}")
        print(f"  Original: {original_count} rows")
        print(f"  Filtered: {filtered_count} rows")
        print(f"  Removed: {removed_count} outliers ({removed_count/original_count*100:.1f}%)")
        print(f"  Saved to: {output_path}")
        
        return True
        
    except Exception as e:
        print(f"Error processing {csv_path}: {str(e)}")
        return False

def main(root_directory="freezed_logs"):
    """Main function to process all merged.csv files."""
    
    root_path = Path(root_directory)
    
    if not root_path.exists():
        print(f"Error: Root directory '{root_directory}' does not exist!")
        return
    
    # Find all merged.csv files
    csv_files = list(root_path.glob("*/merged.csv"))
    
    if not csv_files:
        print(f"No merged.csv files found in {root_directory}")
        return
    
    print(f"Found {len(csv_files)} CSV files to filter...")
    print("=" * 50)
    
    processed = 0
    for csv_file in csv_files:
        if process_csv_file(csv_file):
            processed += 1
        print("-" * 30)
    
    print(f"Successfully processed {processed}/{len(csv_files)} files")

if __name__ == "__main__":
    main(root_directory="latency_measurement/freezed_logs")