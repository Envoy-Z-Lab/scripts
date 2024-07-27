#!/bin/bash

# Get a list of all staged files with changes
files=$(git diff --cached --name-only)

# Iterate through each file
for file in $files; do
    # Check if there are only whitespace changes
    if git diff --cached "$file" | grep -q '^@@'; then
        # Check if the diff is non-empty after filtering out whitespace changes
        if git diff --cached "$file" | grep -q '[^[:space:]]'; then
            echo "File with content changes detected: $file"
        else
            # Discard changes if only whitespace changes are present
            echo "Discarding changes from: $file"
            git checkout -- "$file"
        fi
    fi
done

# Reset the staging area to reflect these changes
git reset
