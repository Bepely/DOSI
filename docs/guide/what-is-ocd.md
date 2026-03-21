# What is OCD?

**OCD** (Operational Context Directory) is the atomic unit of knowledge in DOSI. It's a directory — not a single file — that contains everything produced during one development session.

An OCD directory is a **context unit**. The session document, plans, architecture notes, schematics, diagrams, data exports, SQL schemas — all of it lives inside one directory. Any file type is valid. The vector database parses everything it finds inside.

## Why "OCD"?

It's a context unit with obsessive containment. Every decision documented. Every artifact captured. Every schematic preserved. Nothing escapes the directory. The name fits.

## What's in an OCD Directory?

The session document (the `.md` file matching the directory name) is the primary artifact. But everything else in the directory is equally important content:

### Session Imprints
Birth and death certificates for the session:
- **Open:** who started it, when, what the goal was
- **Close:** who closed it, when, one-line outcome

### Actions Taken
Checkboxes for everything done during the session:
- Documents created/modified
- Code written
- Research conducted
- Decisions made

### Decisions Made
A table of every decision with its rationale:

| Decision | Rationale |
|----------|-----------|
| Use SQLite over Postgres | Single-file, no daemon, WAL mode handles concurrent reads |
| Qdrant over LanceDB | Native Go client, proper production features |

### Issues & Blockers
What went wrong and how it was resolved (or if it's still open).

### Idea Capture
Raw ideas from the supervisor, logged in real-time without interrupting work:
- `[RAW]` — exact words, timestamped
- `[STRUCTURED]` — cleaned up with scope and context
- `[ACTIONED]` — moved to a plan or backlog

### Agent Reviews
Different perspectives on the session's work — orchestrator, pipeline, business, review, etc.

### Next Steps
What should happen in the next session.

## Naming Convention

OCD files use a project prefix for global uniqueness:

```
{PREFIX}-OCD-{N}
```

Examples:
- `HQ-OCD-001` — first HQ session
- `NE-OCD-003` — third product-engine session
- `ACHQ-OCD-007` — seventh Org-B HQ session

Each project defines its prefix in `STATE.md`.

## Directory Structure

```
ocd/
├── INDEX.md                        ← session history (append-only)
├── TEMPLATE.md                     ← blank template (static)
├── HQ-OCD-001/
│   ├── HQ-OCD-001.md              ← session document
│   └── dosi-v03-spec.md           ← artifact from this session
├── HQ-OCD-002/
│   ├── HQ-OCD-002.md
│   ├── migration-plan.md          ← plan written during this session
│   └── api-contract.md            ← doc written during this session
```

Each session gets its own directory. **All artifacts generated during a session live inside it** — plans, architecture docs, postmortems, research notes, diagrams. This is the containment rule: nothing floats outside OCD directories.

This matters because the vector memory system traverses OCD directories to embed knowledge. Every file inherits its session's metadata (prefix, number, date, project) from the directory path. Files outside OCD dirs are invisible to embedding.

## The Index

`ocd/INDEX.md` is an append-only log of all sessions:

```markdown
| Session | Date | Focus | Status | Outcomes |
|---------|------|-------|--------|----------|
| HQ-OCD-001 | 2026-03-18 | Genesis | Complete | HQ established, DOSI v0.3 |
| HQ-OCD-002 | 2026-03-18 | Repo scaffolding | Complete | 3 repos scaffolded |
```

The AI reads this on boot to understand the full session history at a glance.

## Real-World Scale

The system has been tested at scale:
- **59 sessions** in a production workstation (OCD-001 through OCD-059)
- Covering: architecture overhauls, strategic pivots, hardware upgrades, multi-agent dispatch, production deployments
- Sessions range from 30-minute fixes to multi-hour build sessions
- The INDEX alone provides a navigable history of the entire project

## OCD as Context Unit

An OCD directory is not throwaway notes. It's a first-class knowledge unit:
- **Self-contained** — everything from a session in one place, any file type
- **Parseable** — the vector DB traverses it, extracts text, embeds everything
- **Referenceable** — "as decided in NE-OCD-003"
- **Traceable** — git commit hash ties code to the session that produced it
- **Cumulative** — every session builds on all previous sessions

### Any File Type

OCD directories welcome any notation that captures knowledge:

```
NE-OCD-007/
├── NE-OCD-007.md              ← session document
├── pipeline-flow.mermaid      ← diagram
├── db-schema-v2.sql           ← schema change
├── api-benchmark.json         ← performance data
├── adapter-architecture.svg   ← visual schematic
└── capture-sequence.txt       ← ASCII art sequence diagram
```

The vector DB parses what it can. Markdown gets chunked by headings. Structured data gets embedded with schema context. Diagrams get embedded as descriptions. Everything inside the directory is content.
