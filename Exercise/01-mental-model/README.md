# Exercise 01 — Detached HEAD Recovery

**Section:** Section1 Mental Model

**Time:** ~5 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-mental-model
```

`setup.sh` puts you in **detached HEAD** state on the middle commit of a 3-commit history.

## Tasks

1. Run `git status` and `git log --oneline --all --decorate`. Confirm that `HEAD` does **not** point at any branch.
2. Add a new line to `story.txt`, commit it. This commit is now reachable **only from `HEAD`** — if you switch away, it becomes orphaned.
3. Save your work by giving this commit a name: create a branch called `experiment` pointing at where you are.
4. Switch back to `main` and verify your `experiment` branch still has the commit (`git log experiment --oneline`).

## Success Criteria

```bash
$ git branch
* main
  experiment

$ git log experiment --oneline | wc -l
4   # 3 original + your new commit
```

---

## Solution

```bash
echo "line 2.5" >> story.txt
git add story.txt
git commit -m "experiment: try a 2.5 line"

# Step 3: name the current detached commit
git switch -c experiment

# Step 4: switch back to main, verify the branch persists
git switch main
git log experiment --oneline
```

**Why this matters:** committing in detached HEAD is fine *only if you name the state before leaving*. Without a branch, the new commit is reachable only via `git reflog` (Section 6).
