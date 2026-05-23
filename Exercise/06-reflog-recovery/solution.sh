#!/usr/bin/env bash
# Solution for Exercise 06 — Reflog Rescue
# Run after setup.sh from inside /tmp/git-ex-reflog
set -e
cd /tmp/git-ex-reflog

echo "==> Damage:"
git log --oneline

echo "==> Reflog:"
git reflog

# Locate the reflog entry right before "reset: moving to HEAD~3".
# It's the most recent commit entry, which is the CRITICAL feature commit.
TARGET=$(git reflog | grep -E "commit:" | head -1 | awk '{print $1}')
echo "==> Rescue target: $TARGET (the CRITICAL feature commit)"

echo "==> Step 1: snapshot to a rescue branch (safety first)"
git switch -c rescue "$TARGET"

echo "==> Step 2: move main to rescue"
git switch main
git reset --hard rescue

echo "==> Recovered log:"
git log --oneline
