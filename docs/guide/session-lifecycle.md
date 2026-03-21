# Session Lifecycle

Every DOSI session follows three phases: Boot, Execute, Close.

## Phase 0: Boot

The AI reads everything it needs before touching code.

```
1. Read STATE.md              → Where are we?
2. Read ocd/INDEX.md          → What's the session history?
3. Read DOSI-REF.md           → How do we operate?
4. Check for active plan      → Is there a plan to execute?
5. Query knowledge network    → Surface relevant past decisions
6. Create OCD directory       → ocd/{PREFIX}-OCD-{N}/{PREFIX}-OCD-{N}.md
7. Imprint session open       → Record who, when, goal
8. Present relevant history   → Past decisions that relate to today's goal
9. Confirm goal               → Get go/no-go before execution
```

### Session Open Imprint

Before any work starts, the OCD file records:

| Field | Value |
|-------|-------|
| **Opened by** | GitHub username or agent identity |
| **Opened at** | YYYY-MM-DD HH:MM |
| **Goal** | What the session will accomplish |
| **Previous OCD** | Link to the last session |

This imprint is immutable once written. It's the session's birth certificate.

## Phase 1: Execute

Work happens according to the session's **mode**:

| Mode | When |
|------|------|
| **Plan** | New features, architecture decisions |
| **Build** | Executing approved plans |
| **Fix** | Bugfix, stabilization |
| **Meta** | Improving the dev system itself |
| **Explore** | Research, spike, prototype |

During execution:

- **OCD is updated continuously** — every action, every decision, every blocker
- **STATE.md stays current** — always reflects reality
- **Idea Capture is open** — supervisor drops ideas, AI logs them without stopping
- **Agents dispatch in parallel** — independent tasks run concurrently

## Phase 2: Close

```
1. Imprint close       → Record who, when, one-line outcome
2. Documentation       → Finalize OCD, update INDEX.md, STATE.md
3. Agent Reviews       → Each perspective writes their review
4. Git                 → Commit all changes, ask before push
5. Embed session       → Chunk OCD, embed into knowledge network
6. Report              → Summary, next session recommendations
7. Snapshot            → Record the development state
```

### Session Close Imprint

| Field | Value |
|-------|-------|
| **Closed by** | Who closed it |
| **Closed at** | YYYY-MM-DD HH:MM |
| **Outcome** | One-line summary |

### Snapshot

A snapshot is the combination of:
1. The OCD file at close
2. STATE.md at close
3. The git commit hash
4. The knowledge vectors embedded from this session

This gives you a complete development state at any point in time.

## Session Modes in Practice

Modes can combine. The primary mode goes first:

- **"Build"** — pure execution, plan already exists
- **"Plan + Build"** — design something, then build it
- **"Meta + Fix"** — improve tooling AND fix bugs
- **"Explore"** — research with no commitment to implement

The mode sets expectations for what the session produces.
