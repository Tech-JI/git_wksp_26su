#!/usr/bin/env bash
# Exercise 01 — Mental Model: Detached HEAD recovery
set -e
DIR="/tmp/git-ex-mental-model"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

echo "line 1" > story.txt
git add . && git commit -q -m "init: line 1"

echo "line 2" >> story.txt
git commit -q -am "add: line 2"

echo "line 3" >> story.txt
git commit -q -am "add: line 3"

# Demo: leave the student in detached HEAD on the middle commit
MIDDLE=$(git rev-parse HEAD~1)
git -c advice.detachedHead=false checkout "$MIDDLE" -q

echo "Repo ready at: $DIR"
echo "You are now in DETACHED HEAD state at commit $MIDDLE"
echo "Run 'cat README.md' for the task."
