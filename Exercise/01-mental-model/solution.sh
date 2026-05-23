#!/usr/bin/env bash
# Solution for Exercise 01 — Detached HEAD Recovery
# Run after setup.sh from inside /tmp/git-ex-mental-model
set -e
cd /tmp/git-ex-mental-model

echo "==> Step 1: confirm we are in detached HEAD"
git status | head -1   # expect: HEAD detached at <hash>

echo "==> Step 2: make a commit in detached HEAD"
echo "line 2.5" >> story.txt
git add story.txt
git commit -m "experiment: try a 2.5 line"

echo "==> Step 3: name the commit by creating a branch HERE"
git switch -c experiment

echo "==> Step 4: switch back to main and verify experiment still has the commit"
git switch main
git log experiment --oneline

echo "==> Done. Branches:"
git branch
