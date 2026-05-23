# Capstone — Clean Up a Messy Team Repository

**Section:** Section 12 Capstone

**Time:** ~30–45 min

## Scenario

Your team is preparing a release. The repo has accumulated mess:

* `main` had a release-notes commit, but someone ran `git reset --hard HEAD~1` and lost it.
* `feature/auth` has 4 noisy commits that need to become 1–2 clean ones.
* An abandoned branch `abandoned-stuff` has one **valuable** commit (config port from env) hidden between two broken commits.

Your mission: deliver a clean `main` containing the release notes, the cleaned feature, and the salvaged fix.

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-capstone
git log --graph --oneline --all
```

The setup script saves two hashes to `/tmp/` for reference (peek only if needed):

* `/tmp/capstone-release-hash` — the lost release-notes commit
* `/tmp/capstone-security-hash` — the valuable commit on `abandoned-stuff`

## Tasks (in any order)

1. **Recover the lost release commit on `main`** using `git reflog` (Section 6).
2. **Clean `feature/auth`**: use `git rebase -i HEAD~4` to fixup typos and reword "WIP" into a real message (Section 4).
3. **Salvage the env-port fix** from `abandoned-stuff` onto `feature/auth` with `git cherry-pick` (Section 5).
4. **Rebase `feature/auth` onto the updated `main`** (Section 3). Resolve any conflict.
5. **Merge `feature/auth` into `main`** using the strategy your team would choose (Section 2). Justify the choice.
6. **Inspect the final graph** with `git log --graph --oneline --all` and confirm:
   - `main` includes the release notes commit.
   - `main` includes the env-port fix.
   - `main` includes the cleaned feature.
   - No `WIP`, `ugh typo fix`, or `experiment: broken` commits remain on `main`.

## Deliverables

* A copy of the final `git log --graph --oneline --all` output.
* A 1-paragraph note explaining your merge-strategy choice in step 5.

## Hints

If stuck:

```bash
cat /tmp/capstone-release-hash    # for step 1, find this hash in reflog
cat /tmp/capstone-security-hash   # for step 3
```

Always create a rescue branch *before* anything risky:

```bash
git switch -c rescue/before-cleanup
```

---

## Sample Solution Outline

```bash
# Step 1: recover release notes
git reflog                                       # find the lost commit
git cherry-pick <release-hash>                   # or git reset --hard <hash>

# Step 2: clean feature/auth
git switch feature/auth
git rebase -i HEAD~4
#   reword "Add login"     -> "feat: add login"
#   fixup  "WIP"
#   reword "logout"        -> "feat: add logout"
#   fixup  "ugh typo fix"

# Step 3: salvage env-port fix
git cherry-pick $(cat /tmp/capstone-security-hash)

# Step 4: rebase onto updated main
git rebase main                                  # resolve any conflict, continue

# Step 5: merge into main
git switch main
git merge --no-ff feature/auth -m "Merge feature/auth"   # team's choice

# Step 6: inspect
git log --graph --oneline --all
```
