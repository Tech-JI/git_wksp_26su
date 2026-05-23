#!/usr/bin/env bash
# Solution for Exercise 08 — Lazygit Hands-On
#
# Lazygit is an interactive TUI; there is no clean way to script it
# non-interactively. Instead, this solution reproduces the SAME end state
# using the CLI commands that lazygit would have run under the hood.
# Compare this output to what you see in lazygit's "command log" panel ('@').
set -e
cd /tmp/git-ex-lazygit

echo "==> Checkout feature (lazygit: '3', highlight feature, space)"
git switch feature

echo "==> Equivalent of: highlight 'WIP' -> 'f', 'ugh typo' -> 'f', surviving -> 'r'"
# Build the same automated interactive rebase as Exercise 04.
SEQ_EDITOR=$(mktemp)
cat > "$SEQ_EDITOR" <<'EOF'
#!/usr/bin/env bash
sed -i.bak -E '
  s|^pick ([a-f0-9]+) Add core$|reword \1 Add core|;
  s|^pick ([a-f0-9]+) WIP$|fixup \1 WIP|;
  s|^pick ([a-f0-9]+) ugh typo$|fixup \1 ugh typo|;
' "$1"
rm -f "$1.bak"
EOF
chmod +x "$SEQ_EDITOR"

MSG_EDITOR=$(mktemp)
cat > "$MSG_EDITOR" <<'EOF'
#!/usr/bin/env bash
echo "feat: add core feature" > "$1"
EOF
chmod +x "$MSG_EDITOR"

GIT_SEQUENCE_EDITOR="$SEQ_EDITOR" GIT_EDITOR="$MSG_EDITOR" git rebase -i HEAD~3
rm -f "$SEQ_EDITOR" "$MSG_EDITOR"

echo "==> Final log on feature:"
git log --oneline
