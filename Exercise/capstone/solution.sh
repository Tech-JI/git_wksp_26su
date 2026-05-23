#!/usr/bin/env bash
# Solution for Capstone — Clean up a Messy Team Repository
# Run after setup.sh from inside /tmp/git-ex-capstone
set -e
cd /tmp/git-ex-capstone

RELEASE_HASH=$(cat /tmp/capstone-release-hash)
SECURITY_HASH=$(cat /tmp/capstone-security-hash)

echo "================================================"
echo "Step 1: Recover the lost release notes commit on main"
echo "================================================"
git reflog | head -10
git cherry-pick "$RELEASE_HASH"
git log main --oneline

echo
echo "================================================"
echo "Step 2: Clean feature/auth via interactive rebase"
echo "================================================"
git switch feature/auth

SEQ_EDITOR=$(mktemp)
cat > "$SEQ_EDITOR" <<'EOF'
#!/usr/bin/env bash
sed -i.bak -E '
  s|^pick ([a-f0-9]+) Add login$|reword \1 Add login|;
  s|^pick ([a-f0-9]+) WIP$|fixup \1 WIP|;
  s|^pick ([a-f0-9]+) logout$|reword \1 logout|;
  s|^pick ([a-f0-9]+) ugh typo fix$|fixup \1 ugh typo fix|;
' "$1"
rm -f "$1.bak"
EOF
chmod +x "$SEQ_EDITOR"

MSG_EDITOR=$(mktemp)
cat > "$MSG_EDITOR" <<'EOF'
#!/usr/bin/env bash
# Replace either "Add login" or "logout" with proper messages.
case "$(cat "$1")" in
  *login*)  echo "feat: add login"  > "$1" ;;
  *logout*) echo "feat: add logout" > "$1" ;;
esac
EOF
chmod +x "$MSG_EDITOR"

GIT_SEQUENCE_EDITOR="$SEQ_EDITOR" GIT_EDITOR="$MSG_EDITOR" git rebase -i HEAD~4
rm -f "$SEQ_EDITOR" "$MSG_EDITOR"

echo "feature/auth log:"
git log --oneline

echo
echo "================================================"
echo "Step 3: Salvage env-port fix from abandoned-stuff"
echo "================================================"
git cherry-pick "$SECURITY_HASH"
git log --oneline

echo
echo "================================================"
echo "Step 4: Rebase feature/auth onto updated main"
echo "================================================"
set +e
git rebase main
RC=$?
set -e
if [ $RC -ne 0 ]; then
  echo "(no conflict expected here, but if one appears: resolve, git add, git rebase --continue)"
fi
git log --oneline

echo
echo "================================================"
echo "Step 5: Merge feature/auth into main (--no-ff)"
echo "================================================"
git switch main
git merge --no-ff feature/auth -m "Merge feature/auth (auth + env port)"

echo
echo "================================================"
echo "Step 6: Final graph"
echo "================================================"
git log --graph --oneline --all
