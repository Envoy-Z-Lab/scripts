#!/bin/bash

# Define the commit range
START_COMMIT="09edce5"
END_COMMIT="7ddde2d"

# Cherry-pick the range of commits
git cherry-pick ${START_COMMIT}^..${END_COMMIT}
if [ $? -ne 0 ]; then
  echo "Cherry-pick failed. Resolve conflicts and try again."
  exit 1
fi

# Get the list of cherry-picked commits
COMMITS=$(git log --pretty=format:"%H %cd" ${START_COMMIT}^..${END_COMMIT})

# Loop through each commit to amend its date
while IFS= read -r line; do
  COMMIT_HASH=$(echo $line | awk '{print $1}')
  ORIGINAL_DATE=$(echo $line | cut -d' ' -f2-)

  # Set the committer date and amend the commit
  GIT_COMMITTER_DATE="$ORIGINAL_DATE" git commit --amend --no-edit --date "$ORIGINAL_DATE"
  if [ $? -ne 0 ]; then
    echo "Failed to amend commit $COMMIT_HASH"
    exit 1
  fi
done <<< "$COMMITS"

echo "Cherry-picking and date amendments completed successfully."
