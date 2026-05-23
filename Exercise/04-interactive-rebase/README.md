# Exercise 04 — Clean a Messy Branch with Interactive Rebase

**Section:** Section4 Interactive Rebase

**Time:** ~15 min

## Setup

```bash
bash setup.sh
cd /tmp/git-ex-irebase
git log --oneline
```

You will see something like:

```
df1a2b3 ugh typo
c4d5e6f stuff
g7h8i9j WIP
k1l2m3n Add featurex
o4p5q6r init
```

## Tasks

1. Use **interactive rebase** (`git rebase -i HEAD~4`) to:
   - `reword` the bad commit messages.
   - `fixup` the typo commit into the previous feature commit.
   - `drop` the noisy `stuff` commit (it shouldn't have been there).
2. After the rebase, run `git log --oneline` again. You should end up with a small, *meaningful* history.

## Success Criteria

A clean history that looks roughly like:

```
xxxxxxx feat: add feature X
yyyyyyy init
```

The `debug.log` and `.gitignore` changes from the dropped commit should be **gone** — verify with `git status` and `ls`.

---

## Solution

Run `git rebase -i HEAD~4`. In the editor that opens, change the todo list from:

```text
pick k1l2m3n Add featurex
pick g7h8i9j WIP
pick c4d5e6f stuff
pick df1a2b3 ugh typo
```

to:

```text
reword k1l2m3n Add featurex
fixup  g7h8i9j WIP
drop   c4d5e6f stuff
fixup  df1a2b3 ugh typo
```

Save & quit. Git will pause at the `reword` step — change the message to `feat: add feature X`. Save & quit again. Done.

> If you accidentally trash your branch, `git reflog` + `git reset --hard HEAD@{N}` will rescue you.
