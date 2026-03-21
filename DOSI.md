# DOSI — Development Operational Session Instructions

**Version:** 0.3.0
**Created:** 2026-03-03
**Updated:** 2026-03-18
**Author:** Nick Gogin
**License:** Copyright (c) 2026 Nick Gogin. All rights reserved.
**Canonical source:** github.com/Bepely/dosi

---

## What Is DOSI

DOSI is the protocol and system for structured, AI-assisted development. OCD (Operational Context Directory) is the atomic unit of knowledge — a directory that contains everything produced during a single development session.

```
DOSI = The system (protocol, lifecycle, coordination, embedding pipeline)
OCD  = The context unit (a directory of everything from one session)
```

Every OCD directory is a self-contained context unit. It holds session documents, plans, architecture notes, schematics, diagrams, data — any file type. The vector database parses everything inside OCD directories. That's the whole point: work produces documents, documents feed the knowledge network.

Together they form a portable development workstation: drop `dosi/` into any project, point CLAUDE.md at it, and you have a structured, autonomous development environment with full session history and semantic memory.

---

## Core Principles

1. **Separation of concerns** — Development infrastructure (`dosi/`) is not product code. It's a standalone system that operates ON the product.
2. **Capture first, structure later** — Raw ideas go in immediately. Structuring happens when there's bandwidth.
3. **Autonomous with oversight** — Agents work independently. The human supervises, steers, and injects ideas without blocking the pipeline.
4. **State is explicit** — Every session starts by reading state, every session ends by writing it. No implicit knowledge.
5. **Portable** — This system works on any project. Product-specific details live in config, not in the protocol.
6. **Cumulative** — Every session adds to the knowledge network. Nothing is lost. Ideas, decisions, and lessons compound across projects and time.

---

## Session Lifecycle

### Phase 0: Boot

```
1. Read STATE.md              → Where are we?
2. Read ocd/INDEX.md          → What's the session history?
3. Read DOSI-REF.md           → How do we operate?
4. Check for active plan      → Is there a plan to execute?
5. Query knowledge network    → Surface relevant past decisions (v0.3)
6. Create OCD-{N} directory   → ocd/{PREFIX}-OCD-{N}/{PREFIX}-OCD-{N}.md
7. Imprint session open       → Record who, when, goal
8. Present relevant history   → "OCD-038 decided X, OCD-051 designed Y" (v0.3)
9. Confirm goal               → Get go/no-go before execution
```

**Session Open Imprint:** Before any work starts, the OCD file records:
- **Who** opened the session — use GitHub username or agent identity
- **When** it was opened (YYYY-MM-DD HH:MM)
- **Goal** — what the session will accomplish (confirmed with supervisor)

This imprint is the session's birth certificate. It stays immutable once written.

### Phase 1: Execution

The session runs according to the **Session Mode** (see below). During execution:

- **OCD file is updated continuously** — files modified, decisions made, blockers hit
- **STATE.md stays current** — reflects the live state at any point
- **Idea Capture is always open** — supervisor can inject ideas at any time
- **Agents work in parallel where possible** — independent tasks are dispatched concurrently
- **Knowledge queries on demand** — "recall" past decisions when making new ones (v0.3)

### Phase 2: Close

```
1. Imprint close       → Record who, when, one-line outcome
2. Documentation       → Finalize OCD, update INDEX.md, STATE.md
3. Agent Reviews       → Each perspective writes their session review
4. Git                 → Commit all changes, ask before push/merge
5. Embed session       → Chunk OCD file, embed into knowledge network (v0.3)
6. Report              → Summary, next session recommendations, open blockers
7. Snapshot            → Record the development state for continuity
```

**Session Close Imprint:**
- **Who** closed the session
- **When** it was closed
- **Outcome** — one-line summary of what was achieved

---

## OCD Naming Convention

OCD directories use a project prefix for global uniqueness across the organization:

```
{PREFIX}-OCD-{N}
```

| Component | Description | Examples |
|-----------|-------------|----------|
| **PREFIX** | Short project identifier | `HQ`, `NE`, `NAP`, `ACHQ` |
| **N** | Sequential session number | `001`, `002`, `042` |

Examples:
- `HQ-OCD-001` — HQ session 1
- `NE-OCD-003` — product-engine session 3
- `NAP-OCD-012` — admin-portal session 12
- `ACHQ-OCD-007` — Org-B HQ session 7

The prefix is defined in the project's `STATE.md` under the `OCD Prefix` field. Each project chooses its own prefix. Prefixes must be unique within the organization.

### Directory Structure

```
ocd/
├── INDEX.md                              ← session history (append-only)
├── TEMPLATE.md                           ← session template (static)
├── {PREFIX}-OCD-001/
│   ├── {PREFIX}-OCD-001.md               ← session document
│   ├── migration-plan.md                 ← artifact created during session
│   └── architecture-decision.md          ← artifact created during session
└── {PREFIX}-OCD-002/
    ├── {PREFIX}-OCD-002.md
    ├── api-contract.md
    └── postmortem.md
```

### Containment Rule

**All artifacts generated during a session MUST live inside that session's OCD directory.** Any file type is valid content:
- Session documents (`.md`)
- Plans, architecture docs, design documents
- Schematics, diagrams, flowcharts (`.svg`, `.mermaid`, `.drawio`, ASCII art in `.txt`)
- Data exports (`.json`, `.csv`, `.sql`)
- Agent definitions, prompt templates
- Screenshots, mockups (`.png`, `.jpg`)
- Any notation format that captures knowledge

An OCD directory IS the context unit. Everything inside it is content for the knowledge network. The vector DB traverses OCD directories and parses everything it finds — not just markdown, but any file type it can extract text from.

Files outside OCD directories are invisible to the embedding pipeline. The only files that live outside are operational:
- `STATE.md` — live state, updated every session (not generated, maintained)
- `DOSI-REF.md` — static protocol reference
- `ocd/INDEX.md` — session index (append-only log)
- `ocd/TEMPLATE.md` — session template (static)

---

## Session Modes

| Mode | Description | When to use |
|------|-------------|-------------|
| **Plan** | Research, design, write implementation plans | New features, architectural decisions |
| **Build** | Execute implementation plans, write code | After a plan is approved |
| **Fix** | Bugfix pass, stabilization | When bugs are blocking progress |
| **Meta** | Improve the development system itself | DOSI updates, tooling, process changes |
| **Explore** | Research, spike, prototype | Uncertain scope, needs investigation first |

A session can combine modes. Example: "Meta + Build" — improve dev tooling AND build features. The primary mode goes first in the OCD title.

---

## Agent Coordination

### Dispatch Model

The supervisor (human) steers. The orchestrator (AI) dispatches.

```
Supervisor (human)
    │
    ├── throws raw ideas ──→ Idea Capture Queue
    ├── approves/rejects  ──→ Plan decisions
    └── reads status      ──→ OCD file / STATE.md

Orchestrator (AI)
    │
    ├── dispatches parallel agents for independent tasks
    ├── sequences dependent tasks
    ├── captures and logs all decisions
    ├── queries knowledge network for context
    └── updates OCD + STATE continuously
```

### Parallel Work Rules

1. **Independent tasks → parallel agents.** If two tasks don't share files or state, dispatch them concurrently.
2. **Dependent tasks → sequential.** If task B needs task A's output, wait.
3. **Review after major steps.** After a logical chunk completes, review before continuing.
4. **Never duplicate work.** If an agent is researching X, don't also research X yourself.

### Status Reporting

The OCD session file IS the live status report. At any point, the supervisor can read the current OCD to see:
- What's been done (Actions Taken)
- What's in progress (checked/unchecked items)
- What's blocked (Issues & Blockers)
- Raw ideas captured (Idea Capture section)

---

## Idea Capture

The supervisor can inject ideas at any time during a session. These go into the **Idea Capture** section of the current OCD file.

### How It Works

1. Supervisor says something like "oh also, we should think about X"
2. Orchestrator immediately logs it in the OCD file under Idea Capture
3. Work continues uninterrupted
4. Ideas are triaged during session close or next planning phase

### Idea Format

```markdown
## Idea Capture

- **[RAW]** "exact thing the supervisor said" — captured {timestamp}
- **[STRUCTURED]** Title: description, potential scope, relates to: {feature/component}
- **[ACTIONED]** → Moved to BACKLOG / Plan / OCD-{N+1}
```

Ideas start as `[RAW]`, get structured when there's bandwidth, and get actioned when they're ready.

---

## Vector Memory (v0.3)

The knowledge network is the cumulative memory of all development sessions across all projects. It is the **Cumulative** principle applied to the development process itself.

### Architecture

```
Vector DB
└── Collection: "knowledge"
    ├── Vector: 1536-dim, cosine distance
    ├── Sources: OCD files, architecture docs, plans, postmortems, knowledge base
    └── Payload:
        ├── source_file    — path relative to project root
        ├── project        — project identifier
        ├── type           — "ocd", "architecture", "plan", "knowledge", "reference"
        ├── ocd_number     — session number (null for non-OCD docs)
        ├── section        — "decisions", "actions", "ideas", "reviews"...
        ├── date           — "YYYY-MM-DD"
        └── tags           — ["go", "migration", "qdrant"]
```

### What Gets Embedded

Every file inside an OCD directory is a candidate for embedding:
- **Session documents** (`{PREFIX}-OCD-{N}.md`) — chunked by section (decisions, actions, ideas, reviews)
- **Session artifacts** (plans, architecture docs, postmortems) — chunked by heading
- **Schematics and diagrams** (`.svg`, `.mermaid`, `.txt` ASCII art) — embedded as-is or with description
- **Structured data** (`.json`, `.csv`, `.sql`) — embedded with schema context
- **Any text-extractable file** — the pipeline parses what it can

Because all artifacts live inside OCD directories (see Containment Rule), the embedding pipeline is simple: **traverse every `ocd/{PREFIX}-OCD-*/` directory, parse every file inside it.**

### Chunking Strategy

Markdown files are chunked by `##` headings. Other text-extractable files are embedded as single chunks or split by logical boundaries. Each chunk gets:
- The section content as embedding text
- The parent file name prepended for context
- Metadata payload automatically derived from the directory path:

```
File: ocd/NE-OCD-003/api-contract.md
  → project:    derived from STATE.md or branch name
  → prefix:     "NE" (parsed from directory name)
  → ocd_number: 3 (parsed from directory name)
  → file_type:  "artifact" (not the session doc itself)
  → filename:   "api-contract.md"
  → date:       from session doc's "Opened at" field
```

Target: 500-1500 tokens per chunk.

### When to Embed

| Trigger | What | How |
|---------|------|-----|
| **Session close** | All files in the OCD directory | Traverse dir, parse every file, chunk, embed |
| **Project onboard** | All existing OCD directories | One-time bulk: walk `ocd/*/`, embed everything |
| **Re-embed** | Full rebuild | Delete collection, re-traverse all OCD dirs |

### When to Query

| Trigger | What | Why |
|---------|------|-----|
| **Session boot** | Goal text → relevant history | Surface past decisions before starting |
| **On demand** | "recall" or "what did we decide about X?" | Semantic search across all projects |
| **Cross-project** | Filter by project or search all | Connect ideas across repos |

### Cross-Project Knowledge

All projects can share the same knowledge collection. A session in one project can recall decisions made in another. Nothing is siloed. The knowledge network grows with every session, across every project.

---

## State Management & Snapshots

### Live State: `STATE.md`

Always reflects current reality. Updated during sessions. Contains:
- Current OCD number and status
- OCD prefix for this project
- Version
- Architecture summary
- What's next (priorities)
- Open blockers

### Session History: `ocd/INDEX.md`

Append-only log of all sessions. Each row is one OCD.

### Snapshots

A snapshot is the combination of:
1. The OCD session file at close
2. STATE.md at close
3. The git commit hash
4. The knowledge vectors embedded from this session (v0.3)

---

## Configuration

### Project Config

Lives in `CLAUDE.md` at the project root. Contains:
- Product overview and architecture
- Boot sequence pointing to `dosi/`
- Conventions (commit style, branching, etc.)
- Key context

### Development Config

Lives in `dosi/` (or at repo root for HQ-type repos). Contains:
- `STATE.md` — Current state (live, updated every session)
- `DOSI-REF.md` — Reference to this protocol (static)
- `ocd/INDEX.md` — Session history log (append-only)
- `ocd/TEMPLATE.md` — Session template (static)
- `ocd/{PREFIX}-OCD-*/` — Session directories (all generated artifacts inside)

### HQ Pattern

An HQ repo is a DOSI workstation that orchestrates across multiple projects. It has no product code — only development infrastructure.

| | HQ | Project `dosi/` |
|---|-----|------|
| **DOSI** | References canonical (Bepely/dosi) | References canonical (DOSI-REF.md) |
| **OCD sessions** | Org-wide sessions | Project-specific sessions |
| **Knowledge** | Cross-project, strategic | Project-specific, tactical |
| **STATE.md** | Org state (all projects) | Project state |

HQ branches from the DOSI template repo. Each organization gets its own branch.

---

## Deploying to a New Project

DOSI runs anywhere — any project, any repo. No HQ required. Just drop `dosi/` in and start.

```
1. Create dosi/ directory with:
   - STATE.md (initial state, include OCD Prefix)
   - DOSI-REF.md (reference to canonical DOSI)
   - ocd/INDEX.md (empty)
   - ocd/TEMPLATE.md (from this repo)
2. Create CLAUDE.md at project root:
   "Your control room is dosi/. Read it on every session start."
3. Add product-specific context to CLAUDE.md
4. Write {PREFIX}-OCD-001 genesis (what this project is, where it came from)
5. Start your first real OCD session
```

### Gitignore Strategy

The `dosi/` folder is development infrastructure, not product code. You have three options:

| Strategy | When | How |
|----------|------|-----|
| **Gitignore dosi/** | Team project, dosi/ is personal | Add `dosi/` to `.gitignore`, keep local or in separate repo |
| **Track in git** | Solo project, want sessions versioned | Don't gitignore — sessions commit alongside code |
| **Separate repo** | Clean separation, multiple contributors | DOSI instance in its own repo, product repo stays clean |

The vector DB doesn't care which strategy you use. It just needs a path to `dosi/ocd/` on disk.

### Deploying an HQ

```
1. Branch from Bepely/dosi master
2. Customize STATE.md with your organization's projects
3. Set up CLAUDE.md as orchestrator instructions
4. Write {PREFIX}-OCD-001 genesis
5. Clone branch as your working HQ directory
```

---

## Relationship to OCD

| | OCD | DOSI |
|---|-----|------|
| **Is** | A context unit (directory) | The system (protocol + pipeline) |
| **Purpose** | Contain everything from one session | Define how sessions operate |
| **Format** | Directory with any file types | Protocol document + scaffold |
| **Updates** | Every session produces a new one | When the system evolves |
| **Feeds** | The vector database | The development workflow |
| **Analogy** | A git commit (snapshot of work) | The git workflow (how you commit) |

---

## Version History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 0.1.0 | 2026-03-03 | Initial — session lifecycle, agent coordination, idea capture, state management | Bepely |
| 0.2.0 | 2026-03-11 | OCD directories, session imprinting (open/close), knowledge/ folder | Bepely |
| 0.3.0 | 2026-03-18 | Vector memory layer, cross-project knowledge, session boot recall, auto-embed on close, OCD naming prefixes, HQ pattern, cumulative principle | Bepely |
