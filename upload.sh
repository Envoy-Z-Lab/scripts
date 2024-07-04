#!/usr/bin/env bash
#
# Script to upload files to GitHub
#

# Prompt the user to input the path to the ROM ZIP file
read -p "Please enter the path to the ROM ZIP: " ROM_ZIP_PATH

# Prompt the user to input the release/tag name
read -p "Please enter the release/tag name: " TAG

# Prompt the user to input the device name
read -p "Please enter the device name: " DEVICE

# Define the paths to the files that need to be uploaded
FILES=(
    "out/target/product/$DEVICE/boot.img"
    "out/target/product/$DEVICE/dtbo.img"
    "out/target/product/$DEVICE/super_empty.img"
    "out/target/product/$DEVICE/vbmeta.img"
    "$ROM_ZIP_PATH"
)

# GitHub repository information
GH="https://github.com/Envoy-Z-Lab/Releases"

# Function to upload a file to GitHub
upload_file() {
    local FP=$1
    echo -e "Uploading $FP to GitHub..."
    
    # Check if release exists
    if ! gh release view $TAG --repo $GH > /dev/null 2>&1; then
        gh release create $TAG --generate-notes --repo $GH
    fi
    
    # Upload the file
    gh release upload --clobber $TAG $FP --repo $GH
}

# Iterate over each file in the FILES array and upload it
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        upload_file "$file"
    else
        echo "File $file does not exist, skipping..."
    fi
done
