#!/usr/bin/env bash
# Solution for Exercise 03 — Rebase Feature onto Updated Main
# Run after setup.sh from inside /tmp/git-ex-rebase
set -e
cd /tmp/git-ex-rebase

echo "==> Current graph (diverged):"
git log --graph --oneline --all

echo "==> Start rebase (will conflict on config.txt)"
set +e
git rebase main
set -e

echo "==> Resolve conflict: keep feature's port=9090"
# Remove the conflict markers, keeping the feature change
cat > config.txt <<EOF
host = localhost
port = 9090
EOF

git add config.txt
git rebase --continue

echo "==> Final linear graph:"
git log --graph --oneline --all
