#!/usr/bin/env bash
# Exercise 08 — Re-do earlier exercises inside lazygit
set -e
DIR="/tmp/git-ex-lazygit"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

echo "v1" > app.txt && git add . && git commit -q -m "init"

# Build a messy branch (same as exercise 04)
git checkout -q -b feature
echo "core" >> app.txt && git commit -q -am "Add core"
echo "more" >> app.txt && git commit -q -am "WIP"
echo "fix"  >> app.txt && git commit -q -am "ugh typo"

git checkout -q main

echo "Repo ready at: $DIR"
echo "Open lazygit here: 'cd $DIR && lazygit'"
echo "Run 'cat README.md' for the task."
