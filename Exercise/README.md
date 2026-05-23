# Git Workshop Part 2 -- Exercises

Hands-on drills that pair with `part2.md`. Each subfolder is **self-contained**: a `setup.sh` builds a tiny demo repository, a `README.md` describes the task and expected outcome, and a `solution.sh` reproduces the canonical answer. Try the exercise on your own first, then read `solution.sh`.

## Folder Map

| Folder | Topic | Workshop Section |
| --- | --- | --- |
| `01-mental-model/` | Detached HEAD recovery | Section 1 |
| `02-merge-strategies/` | ff / no-ff / squash side-by-side | Section 2 |
| `03-rebase-workflows/` | Rebase + conflict resolution | Section 3 |
| `04-interactive-rebase/` | Squash, reword, split, reorder | Section 4 |
| `05-cherry-pick/` | Backport a single commit | Section 5 |
| `06-reflog-recovery/` | Undo `reset --hard` | Section 6 |
| `07-stash-worktrees/` | Stash + worktree drill | Section 7 |
| `08-lazygit-practice/` | Re-run Sections 3 and 4 in lazygit | Section 8 |
| `capstone/` | Full messy-repo cleanup | Section 12 |

## How to Run an Exercise

```bash
cd Exercise/03-rebase-workflows
bash setup.sh                 # builds /tmp/git-ex-rebase
cd /tmp/git-ex-rebase
cat README.md                 # the task
# ... do the exercise ...
```

Every `setup.sh` is idempotent (it removes the temp dir if it already exists) so you can re-run as many times as you like.

## Checking Your Answer

Each exercise ships with a runnable `solution.sh`:

```bash
# Reset to a clean problem state, then run the canonical solution.
bash Exercise/03-rebase-workflows/setup.sh
bash Exercise/03-rebase-workflows/solution.sh
```

The solution script reproduces the end state you should reach. Read it *after* attempting the exercise.

## Conventions

* All demo repos are created under `/tmp/` so they never collide with your real work.
* `git config user.email "ex@example.com"`, `user.name "Workshop"`, and `commit.gpgsign false` are set locally inside each demo so commits always succeed regardless of your global git config.
