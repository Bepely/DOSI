# HQ Pattern

An HQ is a DOSI workstation that orchestrates across multiple projects. It has no product code — only development infrastructure.

## When to Use HQ

Use the HQ pattern when you have:
- Multiple repos that need coordination
- Cross-project decisions (tech stack, conventions, architecture)
- Organization-level planning and state tracking

## How It Works

HQ is a branch of the DOSI template repo (`Bepely/dosi`). Each organization gets its own branch:

```
Bepely/dosi
├── master          ← clean template (you are reading this)
├── OrgA_HQ         ← Organization A HQ
└── OrgB_HQ         ← Organization B HQ
```

The branch starts from the template and gets customized with:
- `STATE.md` — organization state, project registry
- `CLAUDE.md` — orchestrator instructions
- `ocd/` — organization-level sessions
- `knowledge/` — cross-project knowledge base
- `agents/` — CTO agent definitions for sub-projects

## HQ vs Project dosi/

| | HQ | Project `dosi/` |
|---|-----|------|
| **DOSI** | References canonical source | References canonical source |
| **OCD sessions** | Org-wide (planning, coordination) | Project-specific (features, bugs) |
| **Knowledge** | Cross-project, strategic | Project-specific, tactical |
| **STATE.md** | All projects, org priorities | Single project state |
| **CLAUDE.md** | Orchestrator — dispatches to projects | CTO — builds the product |

## Setting Up an HQ

1. Clone the DOSI repo
2. Create a branch: `git checkout -b {Org}_HQ`
3. Write `CLAUDE.md` with orchestrator instructions
4. Write `STATE.md` with your project registry
5. Create your first OCD session
6. Push the branch

Then clone this branch as your working HQ directory:

```bash
git clone -b Narr_HQ https://github.com/Bepely/dosi.git ~/org-a/HQ
```

## Agent Dispatch from HQ

HQ sessions can dispatch work to sub-projects:

```
HQ Session (HQ-OCD-005)
├── Agent 1 → cd ~/org/engine → run ENG-OCD-008
├── Agent 2 → cd ~/org/frontend → run FE-OCD-012
└── Orchestrator stays in HQ, tracks progress
```

Each agent opens its own OCD in its own project. HQ tracks the cross-project coordination.

## Observer Pattern (Optional)

A top-level HQ can operate as an **Observer** — a cross-org orchestrator with restricted write access.

The Observer can:
- **Read** knowledge from multiple organization collections simultaneously
- **Produce** artifacts in its own OCD directory
- **Not push** to any remote — ask the supervisor first
- **Not write** to org-specific knowledge collections directly

This is useful when you have multiple organizations and need a single brain that sees everything but touches nothing. When the Observer finds something actionable, it documents it as an artifact and hands it to the right org-level session to execute.

```
Top-Level HQ (Observer)
├── reads: Org A knowledge collection
├── reads: Org B knowledge collection
├── writes: its own OCD artifacts only
└── delegates: action items to org-level sessions
```
