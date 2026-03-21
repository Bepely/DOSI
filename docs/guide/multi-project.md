# Multi-Project Setup

How DOSI scales across multiple repositories in an organization.

## The Structure

Each project has its own `dosi/` with its own OCD sessions. An HQ coordinates across all of them.

```
~/workspace/
├── HQ/                         ← orchestrator (branch of Bepely/dosi)
│   ├── STATE.md                ← org state, project registry
│   ├── ocd/HQ-OCD-001/         ← org-level sessions
│   └── CLAUDE.md               ← orchestrator instructions
├── engine/
│   ├── dosi/
│   │   ├── STATE.md            ← engine state
│   │   └── ocd/NE-OCD-001/     ← engine sessions
│   └── CLAUDE.md               ← engine CTO
├── frontend/
│   ├── dosi/
│   │   ├── STATE.md            ← frontend state
│   │   └── ocd/FE-OCD-001/     ← frontend sessions
│   └── CLAUDE.md               ← frontend CTO
└── api/
    ├── dosi/
    │   ├── STATE.md             ← API state
    │   └── ocd/API-OCD-001/     ← API sessions
    └── CLAUDE.md                ← API CTO
```

## OCD Prefix Registry

Each project picks a unique prefix. Register them in HQ's STATE.md:

| Project | Prefix | Repo |
|---------|--------|------|
| HQ | `HQ` | Bepely/dosi (branch) |
| Engine | `NE` | Org/engine |
| Frontend | `FE` | Org/frontend |
| API | `API` | Org/api |

This ensures OCD numbers are globally unique. When someone says "NE-OCD-003", there's no ambiguity.

## Cross-Project References

OCD files can reference sessions in other projects:

```markdown
## Previous OCD
NE-OCD-003 — decided API contract. This session implements the frontend consumer.
```

With vector memory, these references are also searchable. Query "API contract decisions" and get results from both NE-OCD-003 and API-OCD-007.

## Workflow

1. **Planning** happens in HQ — org-level architecture, cross-project coordination
2. **Building** happens in project repos — each with its own CTO agent
3. **Knowledge** flows through the vector network — all projects share one collection
4. **State** is tracked at both levels — HQ for org, `dosi/STATE.md` for project
