# Idea Capture

The supervisor's brain doesn't stop having ideas just because the AI is mid-task. DOSI handles this.

## The Problem

You're watching the AI refactor a database layer. Suddenly you think: *"We should add rate limiting to the API."* If you interrupt, you derail the current work. If you don't say it, you forget.

## The Solution

Say it. The AI logs it immediately and keeps working.

```
You: "oh also, we should add rate limiting to the API"
AI:  [logs to Idea Capture section]
AI:  [continues refactoring database]
```

No interruption. No context switch. The idea is captured with a timestamp and exact wording.

## Idea Lifecycle

Ideas move through three states:

### [RAW]
Exact words from the supervisor, timestamped:
```markdown
- **[RAW]** "we should add rate limiting to the API" — captured 14:32
```

### [STRUCTURED]
Cleaned up with scope and context (done when there's bandwidth):
```markdown
- **[STRUCTURED]** API Rate Limiting: Add per-IP rate limiting to capture endpoints.
  Scope: internal/api/middleware. Relates to: security, capture system.
```

### [ACTIONED]
Moved to a plan, backlog, or future OCD:
```markdown
- **[ACTIONED]** → NE-OCD-005 backlog item
```

## Why This Matters

Over 59 sessions, the Idea Capture section became one of the most valuable parts of the OCD system. Ideas that seemed random in session 12 became critical features in session 40. Nothing is lost. Everything compounds.
