import os
import re
import shutil
from pathlib import Path

def extract_header_info(file_path):
    """
    Extract device, frequency, threshold, and output method from file header
    """
    header_info = {}
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            # Read first several lines to get header info
            lines = f.readlines()[:10]  # Assuming header is in first 10 lines
            
            for line in lines:
                line = line.strip()
                
                # Extract device name
                if line.startswith('# Device:'):
                    header_info['device'] = line.split(':', 1)[1].strip()
                
                # Extract frequency
                elif line.startswith('# Frequency:'):
                    header_info['frequency'] = line.split(':', 1)[1].strip()
                
                # Extract threshold
                elif line.startswith('# Threshold:'):
                    header_info['threshold'] = line.split(':', 1)[1].strip()
                
                # Extract output method
                elif line.startswith('# Output Method:'):
                    header_info['output_method'] = line.split(':', 1)[1].strip()
    
    except Exception as e:
        print(f"Error reading file {file_path}: {e}")
        return None
    
    # Check if we got all required info
    required_fields = ['device', 'frequency', 'threshold', 'output_method']
    if all(field in header_info for field in required_fields):
        return header_info
    else:
        print(f"Missing header information in {file_path}")
        print(f"Found: {list(header_info.keys())}")
        return None

def create_new_filename(header_info, original_extension='.txt'):
    """
    Create new filename based on header information
    Format: Device_frequency_threshold_outputmethod.txt
    """
    device = header_info['device']
    frequency = header_info['frequency']
    threshold = header_info['threshold']
    output_method = header_info['output_method']
    
    # Clean up the values to make them filename-safe
    def clean_filename_part(text):
        # Replace spaces and special characters with underscores
        return re.sub(r'[^\w\-_\.]', '_', str(text))
    
    device_clean = clean_filename_part(device)
    frequency_clean = clean_filename_part(frequency)
    threshold_clean = clean_filename_part(threshold)
    output_method_clean = clean_filename_part(output_method)
    
    new_filename = f"{device_clean}_{frequency_clean}_{threshold_clean}_{output_method_clean}{original_extension}"
    return new_filename

def process_files(input_folder, output_folder):
    """
    Process all text files in input folder and copy them to output folder with new names
    """
    input_path = Path(input_folder)
    output_path = Path(output_folder)
    
    # Create output folder if it doesn't exist
    output_path.mkdir(parents=True, exist_ok=True)
    
    # Find all text files
    text_files = list(input_path.glob('*.txt'))
    
    if not text_files:
        print(f"No .txt files found in {input_folder}")
        return
    
    print(f"Found {len(text_files)} text files to process...")
    
    successful_copies = 0
    failed_copies = 0
    
    for file_path in text_files:
        print(f"\nProcessing: {file_path.name}")
        
        # Extract header information
        header_info = extract_header_info(file_path)
        
        if header_info is None:
            print(f"  ❌ Failed to extract header info from {file_path.name}")
            failed_copies += 1
            continue
        
        # Create new filename
        new_filename = create_new_filename(header_info, file_path.suffix)
        new_file_path = output_path / new_filename
        
        try:
            # Copy file to new location with new name
            shutil.copy2(file_path, new_file_path)
            print(f"  ✅ Copied to: {new_filename}")
            successful_copies += 1
            
        except Exception as e:
            print(f"  ❌ Failed to copy {file_path.name}: {e}")
            failed_copies += 1
    
    print(f"\n📊 Summary:")
    print(f"  Successfully processed: {successful_copies}")
    print(f"  Failed: {failed_copies}")
    print(f"  Total files: {len(text_files)}")

# Example usage
if __name__ == "__main__":
    # Set your input and output folder paths here
    input_folder = "freezed_log_A15"  # Change this to your input folder path
    output_folder = "renamed_files_A15"  # Change this to your output folder path
    
    print("Text File Renamer and Copier")
    print("=" * 40)
    
    # You can also get paths from user input
    # input_folder = input("Enter input folder path: ").strip()
    # output_folder = input("Enter output folder path: ").strip()
    
    if not os.path.exists(input_folder):
        print(f"❌ Input folder '{input_folder}' does not exist!")
        print("Please update the input_folder variable with the correct path.")
    else:
        process_files(input_folder, output_folder)
        print(f"\n✅ Processing complete! Check the '{output_folder}' folder for renamed files.")