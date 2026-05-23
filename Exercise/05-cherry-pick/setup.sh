#!/usr/bin/env bash
# Exercise 05 — Cherry-pick a single fix from an abandoned branch
set -e
DIR="/tmp/git-ex-cherry"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

cat > app.txt <<EOF
version=1
api_url=http://localhost
debug=false
EOF
git add . && git commit -q -m "init"

git checkout -q -b abandoned-experiment
# Bad change 1
echo "feature_x_attempt=true" >> app.txt
git commit -q -am "experiment: try feature X"

# THE good fix we want to keep
sed -i.bak 's|api_url=http://localhost|api_url=https://localhost|' app.txt && rm app.txt.bak
git commit -q -am "fix: use https for api_url"

# Bad change 2
echo "broken_stuff=yes" >> app.txt
git commit -q -am "experiment: more broken stuff"

GOOD_FIX=$(git rev-parse HEAD~1)
echo "$GOOD_FIX" > /tmp/ex-cherry-good-hash

git checkout -q main

echo "Repo ready at: $DIR"
echo "The 'good fix' commit on abandoned-experiment is: $GOOD_FIX"
echo "Run 'cat README.md' for the task."
