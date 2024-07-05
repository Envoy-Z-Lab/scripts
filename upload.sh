#!/bin/bash

# Define the new copyright text
NEW_COPYRIGHT="#\n# Copyright (C) 2024 The LineageOS Project\n#\n# SPDX-License-Identifier: Apache-2.0\n#"

# Function to replace the copyright block in a file
replace_copyright_in_file() {
    local file_path="$1"
    
    # Use sed to replace the copyright block
    sed -i '/\/\/ Copyright (C) .* The LineageOS Project/,/limitations under the License\./d' "$file_path"
    sed -i "1i $NEW_COPYRIGHT" "$file_path"
    echo "Updated copyright in: $file_path"
}

# Export the function to use it with find
export -f replace_copyright_in_file
export NEW_COPYRIGHT

# Find all files and apply the replacement function
find . -type f -exec bash -c 'replace_copyright_in_file "$0"' {} \;

echo "Copyright update completed."
