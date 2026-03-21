# OCD Template

Copy this template to `dosi/ocd/TEMPLATE.md` in your project. Use it as the starting point for every new session.

## Template

```markdown
# {PREFIX}-OCD-{N}: {Title}

**Status:** In Progress | Complete
**Branch:** `{branch-name}`

---

## Session Open

| Field | Value |
|-------|-------|
| **Opened by** | {GitHub username or agent identity} |
| **Opened at** | {YYYY-MM-DD HH:MM} |
| **Goal** | {what we set out to accomplish — confirmed with supervisor before starting} |
| **Previous OCD** | {PREFIX}-OCD-{N-1} — {brief description} |

## Session Close

| Field | Value |
|-------|-------|
| **Closed by** | {GitHub username or agent identity} |
| **Closed at** | {YYYY-MM-DD HH:MM} |
| **Outcome** | {one-line result} |

## Context Before Session

- Project phase: {current phase}
- Blockers carried forward: {any from previous session}

## Actions Taken

### Documents Created/Modified
- [ ] File 1
- [ ] File 2

### Code Written
- [ ] Module/feature 1
- [ ] Module/feature 2

### Research & Decisions
- Decision 1: {what was decided and why}

## Outcomes

### Deliverables
- [ ] Deliverable 1
- [ ] Deliverable 2

### Key Artifacts
- `path/to/file` — description

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| {what} | {why} |

## Issues & Blockers

| Issue | Resolution |
|-------|-----------|
| {problem} | {how it was resolved, or OPEN if not} |

## Idea Capture

- (ideas injected during session go here)

## Next Steps

- [ ] Immediate priority 1
- [ ] Immediate priority 2
- Dependencies: {what blocks next session}
- Suggested focus for {PREFIX}-OCD-{N+1}: {recommendation}

## Session Notes

Miscellaneous insights, reminders, observations.

---

*Next: {PREFIX}-OCD-{N+1}*
```

## Usage

1. Copy the template to `dosi/ocd/{PREFIX}-OCD-{N}/{PREFIX}-OCD-{N}.md`
2. Fill in the Session Open section before starting work
3. Update Actions Taken and Decisions Made during the session
4. Fill in Session Close and Next Steps when wrapping up
5. Update `dosi/ocd/INDEX.md` and `dosi/STATE.md`
