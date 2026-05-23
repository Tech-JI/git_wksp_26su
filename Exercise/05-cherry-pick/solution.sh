#!/usr/bin/env bash
# Solution for Exercise 05 — Cherry-pick a Single Fix
# Run after setup.sh from inside /tmp/git-ex-cherry
set -e
cd /tmp/git-ex-cherry

echo "==> All commits on abandoned-experiment:"
git log abandoned-experiment --oneline

HASH=$(cat /tmp/ex-cherry-good-hash)
echo "==> Cherry-pick only the good fix: $HASH"
git cherry-pick "$HASH"

echo "==> Verify api_url is now https:"
grep api_url app.txt

echo "==> Verify no junk lines:"
cat app.txt
echo "--"

echo "==> main now has exactly 2 commits:"
git log --oneline
