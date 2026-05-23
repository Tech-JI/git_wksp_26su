#!/usr/bin/env bash
# Exercise 02 — Merge Strategies: ff / no-ff / squash side-by-side
set -e
DIR="/tmp/git-ex-merge"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

echo "v1" > app.txt
git add . && git commit -q -m "init"

git checkout -q -b feature
echo "step 1" >> app.txt && git commit -q -am "feat: step 1"
echo "step 2" >> app.txt && git commit -q -am "feat: step 2"
echo "step 3" >> app.txt && git commit -q -am "feat: step 3"

git checkout -q main

echo "Repo ready at: $DIR"
echo "Branches: main, feature (3 commits ahead of main)"
echo "Run 'cat README.md' for the task."
