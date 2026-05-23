#!/usr/bin/env bash
# Exercise 04 — Interactive Rebase: clean up a messy branch
set -e
DIR="/tmp/git-ex-irebase"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

echo "v1" > app.txt
git add . && git commit -q -m "init"

# Messy commits
echo "feature core" >> app.txt
git commit -q -am "Add featurex"            # bad capitalization, no scope

echo "more" >> app.txt
git commit -q -am "WIP"                      # placeholder message

echo "debug=true" > debug.log
git add debug.log
git commit -q -am "stuff"                    # noise commit (debug file shouldn't be committed)

echo "tyop fix" >> app.txt
git commit -q -am "ugh typo"                 # noise

echo "Repo ready at: $DIR"
echo "Branch has 4 messy commits. Clean them into 1-2 good commits."
echo "Run 'cat README.md' for the task."
