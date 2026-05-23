#!/usr/bin/env bash
# Exercise 03 — Rebase a feature branch onto an updated main with a conflict
set -e
DIR="/tmp/git-ex-rebase"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

cat > config.txt <<EOF
host = localhost
port = 8080
EOF
git add . && git commit -q -m "init: base config"

# Create feature branch from this commit
git checkout -q -b feature
sed -i.bak 's/port = 8080/port = 9090/' config.txt && rm config.txt.bak
git commit -q -am "feat: switch port to 9090"

# Main moves on with a conflicting change
git checkout -q main
sed -i.bak 's/port = 8080/port = 7000/' config.txt && rm config.txt.bak
git commit -q -am "fix: switch port to 7000"

git checkout -q feature

echo "Repo ready at: $DIR"
echo "Branches: main (port=7000), feature (port=9090). Conflict guaranteed on rebase."
echo "Run 'cat README.md' for the task."
