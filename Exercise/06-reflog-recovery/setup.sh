#!/usr/bin/env bash
# Exercise 06 — Recover from accidental hard reset
set -e
DIR="/tmp/git-ex-reflog"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

echo "v1" > app.txt && git add . && git commit -q -m "init"
echo "important" >> app.txt && git commit -q -am "feat: important business logic"
echo "more important" >> app.txt && git commit -q -am "feat: more important business logic"
echo "critical" >> app.txt && git commit -q -am "feat: CRITICAL feature"

# Disaster strikes
git reset --hard HEAD~3

echo "Repo ready at: $DIR"
echo "DISASTER: 'git reset --hard HEAD~3' wiped 3 important commits."
echo "You can no longer see them in 'git log', but they ARE in reflog."
echo "Run 'cat README.md' for the task."
