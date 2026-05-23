#!/usr/bin/env bash
# Solution for Exercise 07 — Stash Path
# Runs the "Path A: Stash" version of the exercise.
# Run after setup.sh from inside /tmp/git-ex-stash
set -e
cd /tmp/git-ex-stash

echo "==> Mid-work state:"
git status --short

echo "==> Stash everything including untracked notes.txt:"
git stash push -u -m "WIP: profile redesign"

echo "==> Working tree clean:"
git status

echo "==> Switch to main, create hotfix, commit:"
git switch main
git switch -c hotfix/bug
echo "URGENT FIX" >> app.txt
git commit -am "fix: urgent bug"

echo "==> Back to feature, restore stash:"
git switch feature/profile
git stash pop

echo "==> Restored state (notes.txt + app.txt unfinished line should be back):"
git status --short
ls notes.txt
cat app.txt
