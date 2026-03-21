---
layout: home
hero:
  name: DOSI
  text: AI Development Protocol
  tagline: Documentation-first protocol for solo developers working with AI. Work produces documents, documents feed the vector DB, the vector DB remembers everything.
  actions:
    - theme: brand
      text: What is DOSI?
      link: /guide/what-is-dosi
    - theme: alt
      text: Get Started
      link: /guide/getting-started
    - theme: alt
      text: View on GitHub
      link: https://github.com/Bepely/dosi
features:
  - title: Session Lifecycle
    details: Every development session follows a structured lifecycle — boot, execute, close. State is read on entry, written on exit. No implicit knowledge.
  - title: Operational Context Directories
    details: OCD directories are context units. Every session produces a directory containing the session doc, plans, schematics, diagrams — any file type. All parseable by the vector DB.
  - title: Agent Coordination
    details: Human supervises, AI orchestrates. Parallel dispatch for independent tasks. Sequential for dependencies. Idea capture without interruption.
  - title: Vector Memory
    details: Every session embeds into a knowledge network. Past decisions surface automatically on boot. Cross-project recall. Nothing is lost.
  - title: Portable Workstation
    details: Drop dosi/ into any project, point CLAUDE.md at it. Instant structured development environment with full session history.
  - title: HQ Pattern
    details: Orchestrator repos that coordinate across multiple projects. Branch from the DOSI template, customize for your organization.
  - title: CLI Launcher & Status Line
    details: Multi-session launcher opens parallel tabs with one click. Context-aware status line shows project sigil, git state, model, context usage, and cost — per session, live.
---

## How It Works

```
Supervisor (human)                    Orchestrator (AI)
    │                                      │
    ├── sets objectives ──────────────→    boot: read state, history, protocol
    ├── injects ideas  ───────────────→    capture: log immediately, triage later
    ├── approves/steers ──────────────→    execute: dispatch agents, update OCD
    └── reads status   ←──────────────    close: finalize docs, embed, snapshot
```

DOSI sits between you and your AI coding partner. It gives the AI operational memory — where you are, what happened before, and how to work.

Without this, every session starts cold. With it, session 47 knows what session 1 decided.

## The Stack

| Component | What It Is | Analogy |
|-----------|-----------|---------|
| **DOSI** | The system — protocol + embedding pipeline | Git workflow docs |
| **OCD** | Context unit — directory of everything from one session | A git commit |
| **STATE.md** | Live snapshot — where are we now | Working tree status |
| **CLAUDE.md** | Project config — what are we building | README for the AI |
| **Knowledge Network** | Vector memory — recall anything | Searchable brain |

## Built By

**[Bepely](https://github.com/Bepely)** — Created by Bepely. Battle-tested across 60+ sessions building production software with Claude.
