# Exercise 03 — Rebase Feature onto Updated Main

**Section:** Section3 Rebase

**Time:** ~10 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-rebase
```

You are on `feature`. `main` has moved on with a *conflicting* change to `config.txt`.

## Tasks

1. View the graph: `git log --graph --oneline --all` — confirm `feature` and `main` have diverged.
2. Rebase `feature` onto `main`: `git rebase main`. **A conflict will appear.**
3. Open `config.txt`. Resolve the conflict (pick the port number you want — the workshop convention is `9090`).
4. Stage the resolved file and continue: `git add config.txt && git rebase --continue`.
5. Confirm with `git log --graph --oneline --all` that the history is now linear: `init -> port 7000 -> port 9090`.

## Bonus

* Re-run `setup.sh` to reset. Then redo the rebase but `git rebase --abort` mid-conflict. Confirm you are back where you started.

---

## Solution

```bash
git rebase main
# CONFLICT (content): Merge conflict in config.txt

# Edit config.txt — delete conflict markers, keep "port = 9090"
$EDITOR config.txt

git add config.txt
git rebase --continue
git log --graph --oneline --all
```

**Why this matters:** rebase replays your commits *one at a time* on top of a new base. A single rebase can stop multiple times if multiple of your commits touch the same lines as the new base.
