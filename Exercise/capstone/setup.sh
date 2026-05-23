#!/usr/bin/env bash
# Capstone — Clean up a Messy Team Repository
set -e
DIR="/tmp/git-ex-capstone"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"

git init -q -b main
git config user.email "ex@example.com"
git config user.name "Workshop"
git config commit.gpgsign false

# Initial release on main
cat > server.py <<EOF
def start():
    port = 8080
    return port
EOF
git add . && git commit -q -m "init: server skeleton"

# Add main commit
echo "# Server" > README.md
git add README.md && git commit -q -m "docs: add README"

# Feature branch with messy work
git checkout -q -b feature/auth
echo "def login(): pass" >> server.py && git commit -q -am "Add login"
echo "# more" >> server.py && git commit -q -am "WIP"
echo "def logout(): pass" >> server.py && git commit -q -am "logout"
echo "# tidy" >> server.py && git commit -q -am "ugh typo fix"

# A "abandoned" branch with one valuable commit (security fix)
git checkout -q main
git checkout -q -b abandoned-stuff
echo "BROKEN" > broken.txt && git add . && git commit -q -m "experiment: broken thing"
sed -i.bak 's/port = 8080/port = int(os.getenv("PORT", "8080"))/' server.py && rm server.py.bak
git commit -q -am "fix: configurable port from env"
SECURITY_FIX=$(git rev-parse HEAD)
echo "MORE BROKEN" > more.txt && git add . && git commit -q -m "experiment: more broken"

# A user disaster: bad rebase / hard reset on main
git checkout -q main
echo "release v1.0" >> README.md && git commit -q -am "docs: prep v1.0 release notes"
RELEASE_HASH=$(git rev-parse HEAD)
git reset --hard HEAD~1   # OOPS, we just deleted the release notes commit

echo "$SECURITY_FIX" > /tmp/capstone-security-hash
echo "$RELEASE_HASH" > /tmp/capstone-release-hash

git checkout -q main

echo "============================================="
echo "Capstone repo ready at: $DIR"
echo "Branches:"
echo "  main              -- recovered from disaster: 'docs: prep v1.0' is LOST"
echo "  feature/auth      -- 4 messy commits to clean up"
echo "  abandoned-stuff   -- contains 1 valuable fix + junk"
echo "Lost release hash : $RELEASE_HASH  (saved to /tmp/capstone-release-hash)"
echo "Security fix hash : $SECURITY_FIX  (saved to /tmp/capstone-security-hash)"
echo "============================================="
echo "Run 'cat README.md' for the task."
