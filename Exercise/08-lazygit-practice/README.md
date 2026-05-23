# Exercise 08 — Lazygit Hands-On

**Section:** Section8 Lazygit

**Time:** ~15 min

**Prerequisite:** `lazygit` installed (`brew install lazygit` on macOS).

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-lazygit
lazygit
```

You will see panels for **Status**, **Files**, **Branches**, **Commits**, and **Stash** on the left, and a **diff/log** viewport on the right.

## Tasks

Re-do Exercise 04 (clean up messy `feature` branch) entirely **inside lazygit** — no CLI for git commands. The relevant key bindings:

| Action | Key |
| --- | --- |
| Cycle panels | `Tab` or `H`/`L` |
| Switch to Branches panel | `3` |
| Switch to Commits panel | `4` |
| Checkout branch | `space` on a branch |
| Mark commit for `squash` | `s` |
| Mark commit for `fixup` | `f` |
| Mark commit for `reword` | `r` |
| Mark commit for `drop` | `d` |
| Begin interactive rebase from commit | `e` |
| Toggle command log | `@` |
| Help for current panel | `?` |

## Steps

1. Press `3` and checkout `feature` (`space`).
2. Press `4` to enter Commits.
3. Highlight `WIP`, press `f` to fixup into the previous commit.
4. Highlight `ugh typo`, press `f` to fixup into the previous commit.
5. Highlight the surviving messy commit, press `r` to reword to a proper message like `feat: add core`.
6. Lazygit will run an interactive rebase under the hood. Press `@` to **see the actual `git rebase` commands** that ran.
7. Exit lazygit with `q`, then verify in CLI:
   ```bash
   git log --oneline   # 2 commits: init + feat: add core
   ```

## Reflect

* Which workflow felt clearer — the raw CLI in Exercise 04 or lazygit here?
* Look at the command log (`@`): can you map every lazygit keystroke back to a `git ...` invocation?

---

## Solution

There is no single solution — the goal is to **build mental association** between lazygit keys and Git commands. The command log is the proof your actions did what you intended.
