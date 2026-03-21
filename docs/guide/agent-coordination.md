# Agent Coordination

DOSI defines how human and AI collaborate — and how the AI dispatches parallel work.

## The Dispatch Model

```
Supervisor (human)
    │
    ├── sets objectives ──────→ confirmed before work starts
    ├── injects ideas  ───────→ captured immediately, triaged later
    ├── approves/steers ──────→ decisions that need human judgment
    └── reads status   ←──────  OCD file is the live report

Orchestrator (AI)
    │
    ├── dispatches parallel agents for independent tasks
    ├── sequences dependent tasks
    ├── captures and logs all decisions
    ├── queries knowledge network for context
    └── updates OCD + STATE continuously
```

The human doesn't micromanage. The AI doesn't go rogue. The OCD file is the shared contract.

## Parallel Work Rules

1. **Independent tasks → parallel.** Two tasks that don't share files or state run concurrently.
2. **Dependent tasks → sequential.** If task B needs task A's output, wait.
3. **Review after major steps.** Pause and check before continuing past a logical boundary.
4. **Never duplicate work.** If an agent is researching X, don't also research X.

## Status Reporting

The OCD file IS the live status report. At any point, the supervisor reads it to see:

- **Actions Taken** — what's done (checked items)
- **In Progress** — what's happening (unchecked items)
- **Issues & Blockers** — what's stuck
- **Idea Capture** — raw ideas logged during the session

No separate status meetings. No "where are we?" questions. The OCD file answers everything.

## Multi-Agent Sessions

For complex sessions, the orchestrator dispatches specialized agents:

```
Orchestrator
    ├── Agent 1 → scaffold product-engine (Go project)
    ├── Agent 2 → repair admin-portal (fix dosi/)
    └── Agent 3 → update HQ state
```

Each agent works in its own directory. No shared state. Results merge at the end.

## Agent Reviews

At session close, different perspectives review the work:

| Perspective | What It Reviews |
|-------------|----------------|
| **Orchestrator** | Session management, git, architecture |
| **Pipeline** | Processing health, model performance |
| **Business** | Strategic alignment, market readiness |
| **Review** | Code quality, conventions, tech debt |

Not every session needs every perspective. Use what's relevant.
