# Exercise 06 — Reflog Rescue

**Section:** Section6 Reflog

**Time:** ~10 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-reflog
```

Three valuable commits have been wiped by `git reset --hard HEAD~3`. They are unreachable from `git log` — but they live in the **reflog**.

## Tasks

1. Confirm the damage: `git log --oneline` shows only `init`.
2. Run `git reflog`. Find the entry just **before** the destructive reset.
3. **Safety first** — create a rescue branch pointing at that entry:
   ```bash
   git switch -c rescue HEAD@{N}
   ```
   (Replace `N` with the right reflog number.)
4. Verify `rescue` now contains all 4 commits: `git log rescue --oneline`.
5. Move `main` to match `rescue`:
   ```bash
   git switch main
   git reset --hard rescue
   ```

## Success Criteria

```bash
$ git log --oneline
xxxxxxx feat: CRITICAL feature
xxxxxxx feat: more important business logic
xxxxxxx feat: important business logic
xxxxxxx init
```

---

## Solution

```bash
git reflog
# look for: "xxxxxxx HEAD@{1}: commit: feat: CRITICAL feature"

git switch -c rescue HEAD@{1}      # snapshot the lost state to a branch
git switch main
git reset --hard rescue
git log --oneline                  # all four commits back
```

**Why this matters:** the moment you suspect data loss, **make a branch first**, then experiment. Branches are cheap. Lost commits past their reflog expiry are gone forever.
