# Exercise 07 — Stash vs Worktree

**Section:** Section7 Stash, Worktrees, Partial Staging

**Time:** ~10 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-stash
git status     # should show modified app.txt + untracked notes.txt
```

## Tasks (Path A: Stash)

1. Stash both tracked AND untracked changes with a descriptive message:
   ```bash
   git stash push -u -m "WIP: profile redesign"
   ```
2. Confirm working tree is clean: `git status`.
3. Switch to `main`, create `hotfix/bug` from it, make a fix, commit, switch back to `feature/profile`.
4. Restore your WIP: `git stash pop`. Confirm `notes.txt` (untracked!) and the unfinished `app.txt` line are both back.

## Tasks (Path B: Worktree)

Reset with `setup.sh` again, then:

1. Without stashing, create a **second working directory** for the hotfix:
   ```bash
   git worktree add ../git-ex-stash-hotfix main
   ```
2. `cd ../git-ex-stash-hotfix` — you're now on `main` with a *clean* working tree, in a separate folder.
3. Do the hotfix here. Your `feature/profile` work in the original folder is untouched.
4. When done, `cd` back. Remove the worktree:
   ```bash
   git worktree list
   git worktree remove ../git-ex-stash-hotfix
   ```

## Reflect

Which felt faster? Which is friendlier when the hotfix takes hours instead of minutes (e.g., you want your editor's open tabs to stay on the feature work)?

---

## Solution Highlights

* `git stash -u` is **critical** when untracked files matter — plain `git stash` won't save them.
* `git stash list` and `git stash show -p stash@{0}` are your friends to inspect before popping.
* `git worktree list` always tells you which worktrees exist; don't delete folders manually.
