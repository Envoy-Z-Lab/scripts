#!/bin/sh

OLD_NAME="vhmit"
OLD_EMAIL="viktor.9630@protonmail.com"
NEW_NAME="vhmit"
NEW_EMAIL="viktor.9630@protonmail.com"

git filter-repo --force --commit-callback '
import re

old_email = b"'"$OLD_EMAIL"'"
new_email = b"'"$NEW_EMAIL"'"
old_name = b"'"$OLD_NAME"'"
new_name = b"'"$NEW_NAME"'"

if commit.author_email == old_email:
    commit.author_name = new_name
    commit.author_email = new_email

if commit.committer_email == old_email:
    commit.committer_name = new_name
    commit.committer_email = new_email

# Update co-author entries in commit message
co_author_pattern = re.compile(rb"^Co-authored-by: .* <" + old_email + rb">", re.MULTILINE)
commit.message = co_author_pattern.sub(b"Co-authored-by: " + new_name + b" <" + new_email + b">", commit.message)
' --refs HEAD~135..HEAD
