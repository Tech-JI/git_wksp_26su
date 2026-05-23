#!/usr/bin/env bash
# Exercise 07 — Stash and Worktree drill
set -e
DIR="/tmp/git-ex-stash"
rm -rf "$DIR" "${DIR}-hotfix"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

echo "v1" > app.txt && git add . && git commit -q -m "init"
git checkout -q -b feature/profile
echo "profile UI v1" >> app.txt && git commit -q -am "feat: start profile"

# Put the student in mid-work (uncommitted changes)
echo "WIP: more profile work" >> app.txt
echo "TODO" > notes.txt

echo "Repo ready at: $DIR"
echo "You are on feature/profile with UNCOMMITTED changes."
echo "Pretend an urgent hotfix request just came in on main."
echo "Run 'cat README.md' for the task."
