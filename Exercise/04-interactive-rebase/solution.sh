#!/usr/bin/env bash
# Solution for Exercise 04 — Interactive Rebase Cleanup
# Run after setup.sh from inside /tmp/git-ex-irebase
#
# This uses a non-interactive trick: setting GIT_SEQUENCE_EDITOR overwrites
# the rebase todo list automatically, and GIT_EDITOR handles the reword step.
set -e
cd /tmp/git-ex-irebase

echo "==> Initial messy log:"
git log --oneline

echo "==> Running interactive rebase with scripted choices..."

# Map the 4 commits oldest->newest into the desired actions.
# The original commits in order are: "Add featurex", "WIP", "stuff", "ugh typo"
SEQ_EDITOR=$(mktemp)
cat > "$SEQ_EDITOR" <<'EOF'
#!/usr/bin/env bash
# $1 is the path to the rebase-todo file
sed -i.bak -E '
  s|^pick ([a-f0-9]+) Add featurex$|reword \1 Add featurex|;
  s|^pick ([a-f0-9]+) WIP$|fixup \1 WIP|;
  s|^pick ([a-f0-9]+) stuff$|drop \1 stuff|;
  s|^pick ([a-f0-9]+) ugh typo$|fixup \1 ugh typo|;
' "$1"
rm -f "$1.bak"
EOF
chmod +x "$SEQ_EDITOR"

# When the reword step opens the commit-message editor, replace the message.
MSG_EDITOR=$(mktemp)
cat > "$MSG_EDITOR" <<'EOF'
#!/usr/bin/env bash
echo "feat: add feature X" > "$1"
EOF
chmod +x "$MSG_EDITOR"

GIT_SEQUENCE_EDITOR="$SEQ_EDITOR" GIT_EDITOR="$MSG_EDITOR" git rebase -i HEAD~4

rm -f "$SEQ_EDITOR" "$MSG_EDITOR"

echo "==> Cleaned log:"
git log --oneline

echo "==> Verify the dropped commit's file is gone:"
ls debug.log 2>/dev/null && echo "FAIL: debug.log still present" || echo "OK: debug.log dropped"
