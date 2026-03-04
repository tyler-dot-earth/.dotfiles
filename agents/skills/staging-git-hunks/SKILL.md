---
name: staging-git-hunks
description: >
  Non-interactive selective hunk staging for git. Lists and stages individual
  diff hunks by ID. Use when an LLM or script needs to programmatically stage
  specific code changes without interactive input. Requires the git-hunks
  command to be installed and available on PATH.
compatibility: Requires git and a POSIX shell (sh) with awk. The git-hunks command must be installed.
allowed-tools:
  - Bash(git hunks:*)
  - Bash(git diff:*)
---

# git-hunks skill

Non-interactive git hunk staging CLI. Designed for LLMs to list unstaged hunks and stage them selectively by ID.

## Core commands

### List unstaged hunks

```bash
git hunks list
```

Lists all unstaged hunks with unique IDs. Each hunk shows:

- ID: `file:@-old,len+new,len` (derived from diff `@@` header)
- Diff preview of the hunk

Example output:

```
src/main.c:@-10,6+10,7
@@ -10,6 +10,7 @@
 #include <stdio.h>
+#include <stdlib.h>
---
src/main.c:@-45,3+46,5
@@ -45,3 +46,5 @@
 return 0;
+return 1;
---
```

**Options:**

- `--staged` - List staged hunks instead of unstaged

### Stage specific hunks

```bash
git hunks add 'src/main.c:@-10,6+10,7'
Staged: src/main.c:@-10,6+10,7
```

Stages a specific hunk by ID.

**Multiple hunks:**

```bash
git hunks add 'src/main.c:@-10,6+10,7' 'src/main.c:@-45,3+46,5'
Staged: src/main.c:@-10,6+10,7
Staged: src/main.c:@-45,3+46,5
```

## ⚠️ Critical: hunk ID volatility

**Hunk IDs are ephemeral.** They are valid only for the exact index/working-tree state at the time `git hunks list` was run. IDs change after:

- Any file edit in the working tree
- Staging any hunk (including via `git add`, `git hunks add`, or any other method)
- Any operation that modifies the index

**Even within a single `git hunks add` call with multiple IDs**, hunks are applied sequentially. After the first hunk is staged, the index changes and subsequent IDs from the **same file** may no longer match. IDs for hunks in **different files** are unaffected.

**Rules:**

1. **Never cache or reuse IDs** across any operation that modifies the index or working tree.
2. **Hunks from different files** can safely be staged together in one `git hunks add` call.
3. **Multiple hunks from the same file**: stage them one at a time, re-running `git hunks list` between each to get fresh IDs. Alternatively, stage them in reverse line-number order (highest offset first) — this minimizes line shifts, but is not guaranteed safe for all cases.
4. If `git hunks add` fails with `"Hunk not found"`, the ID has shifted. Re-run `git hunks list` and retry with the updated ID.

## Recommended operation

### Staging hunks from different files (safe to batch)

```
1. git hunks list                          # get all IDs
2. git hunks add 'fileA:@...' 'fileB:@...' # stage one hunk per file — safe
3. git hunks list --staged                 # verify
```

### Staging multiple hunks from the same file (must be sequential)

```
1. git hunks list                     # get IDs
2. git hunks add 'file:@...'          # stage ONE hunk
3. git hunks list                     # re-list — IDs may have shifted
4. git hunks add 'file:@...'          # stage next hunk using fresh ID
5. Repeat 3–4 until done
6. git hunks list --staged            # verify
```

### Error recovery

If `git hunks add` prints `"Hunk not found"` to stderr and exits non-zero:

1. Run `git hunks list` to get current IDs
2. Match the desired hunk by file path and diff content
3. Retry `git hunks add` with the updated ID

## Hunk ID format

Format: `file:@-old_line,old_len+new_line,new_len`

Example: `src/main.c:@-10,6+10,7`

- `src/main.c` — File path
- `@-10,6` — Starts at line 10 in the original, spans 6 lines
- `+10,7` — Starts at line 10 in the modified version, spans 7 lines

## Parsing IDs

Extract hunk IDs only (ignores diff preview lines):

```bash
git hunks list | awk '/:@-[0-9]+,[0-9]+\+[0-9]+,[0-9]+$/ {print}'
```

Output:

```
src/main.c:@-10,6+10,7
src/main.c:@-45,3+46,5
```

ID lines match the pattern `path:@-N,L+N,L` and are followed by a `@@ ... @@` line. The regex anchors to end-of-line to exclude any diff content that might contain similar patterns.
