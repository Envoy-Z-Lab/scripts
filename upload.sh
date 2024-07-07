#!/bin/bash

# Variables
start_date="2024-06-14"
increment_days=0
commit_count=0

# Function to increment the date
increment_date() {
  local date="$1"
  local increment="$2"
  echo $(date -I -d "$date + $increment days")
}

# Get the list of commits to cherry-pick
commits=$(git rev-list --reverse 9ce085c^..67220d2)

# Loop through the commits and cherry-pick them
for commit in $commits; do
  # Calculate the current committer date
  current_date=$(increment_date "$start_date" "$increment_days")

  # Cherry-pick the commit with the current committer date
  GIT_COMMITTER_DATE="${current_date}T00:00:00" git cherry-pick "$commit"

  # Increment the commit count
  commit_count=$((commit_count + 1))

  # Check if we need to update the date (every 7 Commits)
  if (( commit_count % 7 == 0 )); then
    increment_days=$((increment_days + 1))
  fi
done
