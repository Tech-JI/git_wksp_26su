# Exercise 05 — Salvage a Fix from an Abandoned Branch

**Section:** Section5 Cherry-Pick

**Time:** ~10 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-cherry
```

There is a branch `abandoned-experiment` with **3 commits**. The middle one is the *only* one worth keeping (it changes `http` → `https` in `api_url`). The setup script saves the hash to `/tmp/ex-cherry-good-hash`.

## Tasks

1. Run `git log abandoned-experiment --oneline` to view the three commits. Locate the `fix: use https...` commit.
2. While on `main`, **cherry-pick** that one commit only.
3. Verify with `cat app.txt` that `api_url=https://localhost` is present on `main` and the other two experimental lines are absent.
4. Inspect with `git log --oneline` — there should be exactly **two commits** on `main` (`init` + cherry-picked fix).

## Bonus

* Try `git cherry-pick -n <hash>` instead. What's different? (Hint: nothing is committed automatically — useful if you want to edit before committing.)

---

## Solution

```bash
HASH=$(cat /tmp/ex-cherry-good-hash)
git cherry-pick "$HASH"

# Verify
cat app.txt | grep api_url     # api_url=https://localhost
git log --oneline               # 2 commits on main
```

**Why this matters:** cherry-pick gives you surgical control without merging an entire branch with unwanted history.
