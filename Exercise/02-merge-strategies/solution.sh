#!/usr/bin/env bash
# Solution for Exercise 02 — Merge Strategies Side-by-Side
# Run after setup.sh from inside /tmp/git-ex-merge
set -e
cd /tmp/git-ex-merge

# Capture the starting commit hash so we can reset between rounds.
START=$(git rev-parse main)

echo "================================================"
echo "Round 1: Fast-Forward merge"
echo "================================================"
git merge feature
echo "--- Graph after fast-forward ---"
git log --graph --oneline --all

echo
echo "================================================"
echo "Round 2: No-Fast-Forward merge"
echo "================================================"
git reset --hard "$START"
git merge --no-ff feature -m "Merge feature (no-ff)"
echo "--- Graph after no-ff ---"
git log --graph --oneline --all

echo
echo "================================================"
echo "Round 3: Squash merge"
echo "================================================"
git reset --hard "$START"
git merge --squash feature
git commit -m "feat: complete feature (squashed)"
echo "--- Graph after squash ---"
git log --graph --oneline --all

echo
echo "==> Inspect: feature branch history is gone from main, but feature still exists separately."
