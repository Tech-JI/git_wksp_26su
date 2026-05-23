# Exercise 02 — Merge Strategies Side-by-Side

**Section:** Section2 Merge Strategies

**Time:** ~15 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-merge
```

You now have `main` and `feature` (3 commits ahead of `main`, no divergence).

## Tasks

Merge `feature` into `main` three different ways. Reset between each to compare graphs.

### Round 1: Fast-Forward (default)

```bash
git merge feature
git log --graph --oneline --all
# Observe: single straight line, no merge commit
```

### Round 2: No-Fast-Forward

Reset `main` back, then redo with `--no-ff`.

```bash
git reset --hard main@{1}        # undo merge using reflog
git merge --no-ff feature -m "Merge feature"
git log --graph --oneline --all
# Observe: merge commit appears; feature branch is a visible "bubble"
```

### Round 3: Squash

```bash
git reset --hard main@{2}        # back to the start again
git merge --squash feature
git commit -m "feat: complete feature (squashed)"
git log --graph --oneline --all
# Observe: single new commit on main; feature history is invisible from main
```

## Reflect

* Which strategy makes `git log main` *most informative* about how the feature evolved?
* Which strategy makes `git log main` *easiest to read* for a new contributor?
* If `feature` had a bad commit you'd want to revert later, which strategy makes that easiest?

---

## Solution

The commands above *are* the solution — the point is to **inspect** the resulting graph in each round.

Expected shapes:

```text
Fast-Forward:    o---o---o---o---o   (one line)

No-FF:           o---o-------------M (main)
                      \           /
                       o---o---o    (feature)

Squash:          o---o---G           (one commit G containing all changes)
                      \              (feature still has its own history off to the side)
                       o---o---o
```
