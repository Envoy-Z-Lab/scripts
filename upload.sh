# Cherry-pick the range of commits
git cherry-pick 09edce5^..7ddde2d

# Loop through the commits and update their dates
for commit in $(git log --pretty=format:"%H" 09edce5^..7ddde2d); do
  ORIGINAL_DATE=$(git show -s --format=%ci $commit)
  GIT_COMMITTER_DATE="$ORIGINAL_DATE" git commit --amend --no-edit --date "$ORIGINAL_DATE"
done
