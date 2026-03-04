---
name: stubbing-temporary-comments
description: Plans changes by inserting structured temporary stub comments and then replacing them with real code in a second pass. Use for complex features, multi-file refactors, or when the user asks to plan implementation directly in code before writing full logic.
license: MIT
compatibility: Works best in repositories with git and ripgrep (rg) available for cleanup checks.
---

# Stubbing Temporary Comments

Plans first in code with structured stubs, then implements in a second pass without losing intent.

**Announce at start:** "I'm using the stubbing-temporary-comments skill to do a comment-first implementation pass, then replace stubs with code."

## When To Use

Use this skill when the task benefits from separating design from coding overhead:
- New features that touch multiple files or layers
- Refactors with uncertain implementation details
- Requests like "stub this out first," "plan in-place," or "add TODO scaffolding then implement"
- Situations where rationale should survive into final comments

## Stub Format

Use this exact marker so cleanup is enforceable:

```text
STUB[<id>]: <single-sentence intent>
IN: <inputs/dependencies>
OUT: <output/observable behavior>
EDGE: <edge cases and failure modes>
DONE: <objective acceptance check>
```

Rules:
- Keep each field specific and testable; avoid vague stubs like "handle errors"
- Use IDs that are stable within the change (for example `auth-01`, `cache-02`)
- Keep one logical change per stub
- Use language-appropriate comment syntax (`//`, `#`, `--`, `/* */`)

## Two-Pass Workflow

### 1) Recon Pass
- Read affected files and identify exact insertion points
- Confirm constraints (APIs, data contracts, tests, migrations)
- Create a concise task list before editing

### 2) Stub Pass
- Insert structured `STUB[...]` blocks directly at intended implementation sites
- Keep control flow visible, but do not write full logic yet
- If useful, add minimal type/function signatures so wiring is obvious

### 3) Implementation Pass
- Resolve stubs in ID order
- Replace each stub block with working code
- Preserve rationale as durable comments only when still useful
- Run tests/checks after meaningful groups of replacements

### 4) Cleanup Pass
- Remove unresolved `STUB[...]` markers unless explicitly requested to keep scaffolding
- Run `scripts/check-unresolved-stubs.sh` to verify no markers remain
- If a stub must remain intentionally, convert it to a standard project TODO format

## Quality Bar

Before finishing:
- No unresolved `STUB[...]` markers
- Behavior matches each `DONE:` criterion from the stub pass
- Any retained comments explain why, not what
- Relevant tests updated or added for changed behavior

## Output Template

When reporting results, include:
1. Files stubbed in pass 1
2. Stubs replaced in pass 2
3. Final checks run and outcome
4. Any intentional TODOs left behind

## Examples

TypeScript example:

```ts
// STUB[auth-01]: Validate bearer token and load user session
// IN: Authorization header, user repository
// OUT: AuthenticatedUser or UnauthorizedError
// EDGE: Missing header, malformed token, expired session
// DONE: Protected route returns 401 for invalid token and 200 for valid token
```

Python example:

```python
# STUB[cache-02]: Add read-through cache for expensive report query
# IN: report_id, db client, cache client
# OUT: report payload with stable schema
# EDGE: cache miss, stale entry, db timeout
# DONE: second request avoids db call and returns equivalent payload
```
