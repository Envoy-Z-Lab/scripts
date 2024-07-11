#!/bin/bash

set -e

DEVICE=lavender
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

# Define the path to the helper script
HELPER="./tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${MY_DIR}"

# Warning headers and guards
write_headers

# Use proprietary-files.txt from sdm660-common
COMMON_DIR="${MY_DIR}/device/xiaomi/sdm660-common"
if [ ! -f "${COMMON_DIR}/proprietary-files.txt" ]; then
    echo "Unable to find proprietary-files.txt at ${COMMON_DIR}/proprietary-files.txt"
    exit 1
fi
write_makefiles "${COMMON_DIR}/proprietary-files.txt" true

# Finish
write_footers
