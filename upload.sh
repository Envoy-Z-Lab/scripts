#!/bin/bash

# Define the file paths
HEADER_FILE="lavdt/camera/QCamera2/HAL/QCamera2HWI.h"
CPP_FILE="lavdt/camera/QCamera2/HAL/QCamera2HWI.cpp"

# Fix in the header file
sed -i 's/CAMERA_META_DATA_ASD/QCAMERA_METADATA_ASD/g' "$HEADER_FILE"
sed -i 's/CAMERA_META_DATA_FD/QCAMERA_METADATA_FD/g' "$HEADER_FILE"

# Fix in the cpp file
sed -i 's/CAMERA_MSG_META_DATA/QCAMERA_MSG_META_DATA/g' "$CPP_FILE"
sed -i 's/CAMERA_CMD_LONGSHOT_OFF/QCAMERA_CMD_LONGSHOT_OFF/g' "$CPP_FILE"
sed -i 's/CAMERA_CMD_HISTOGRAM_OFF/QCAMERA_CMD_HISTOGRAM_OFF/g' "$CPP_FILE"
sed -i 's/CAMERA_META_DATA_FD/QCAMERA_METADATA_FD/g' "$CPP_FILE"

echo "Fixes applied successfully."
