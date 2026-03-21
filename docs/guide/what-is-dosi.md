# What is DOSI?

**DOSI** (Development Operational Session Instructions) is a governance protocol for AI-assisted software development. It defines how a human supervisor and an AI coding partner collaborate across structured development sessions.

## The Problem

When you use an AI coding tool (Claude Code, Cursor, Copilot), every session starts cold. The AI doesn't know:

- What you built yesterday
- What architectural decisions you made last week
- Why you chose SQLite over Postgres
- What's blocked and what's next

You end up repeating context, re-explaining decisions, and losing momentum between sessions.

## The Solution

DOSI provides three things:

### 1. A Session Protocol

Every session follows a lifecycle:

```
Boot    → Read state, read history, confirm objectives
Execute → Work, log continuously, capture ideas
Close   → Finalize docs, commit, embed into memory, snapshot
```

The AI reads the protocol on boot and knows exactly how to operate.

### 2. Operational Memory (OCD)

Every session produces an **OCD** (Operational Context Directory) — a self-contained context unit. The session document, plus every artifact created during the session — plans, schematics, diagrams, data, any file type.

Session 47 can read what session 1 decided. No context is lost.

### 3. A Knowledge Network (v0.3)

OCD files get chunked and embedded into a vector database. On boot, the AI queries the knowledge network with the session's goal and surfaces relevant history automatically.

*"Last time you worked on the adapter system, you decided X in OCD-038 and refined it in OCD-051."*

## DOSI vs OCD

| | DOSI | OCD |
|---|------|-----|
| **Is** | The system (protocol + pipeline) | A context unit (directory) |
| **Contains** | How to operate | Everything from one session |
| **File types** | Protocol document | Any — `.md`, `.svg`, `.json`, `.sql`, diagrams, schematics |
| **Updates** | When the system evolves | Every session produces a new one |
| **Goal** | Structure the workflow | Feed the vector DB |

## Who Made This

DOSI was created by **Bepely** ([GitHub](https://github.com/Bepely)) and battle-tested across 60+ development sessions building production software with Claude. It evolved through three major versions as the development practice matured.

## Where Does It Run?

Anywhere. DOSI doesn't require a special repo or an HQ setup. Drop `dosi/` into any project and start working.

The `dosi/` folder is development infrastructure, not product code. You can:
- **Gitignore it** — keep it local, point a vector DB at it on disk
- **Track it in git** — version your sessions alongside your code (good for solo projects)
- **Put it in a separate repo** — clean separation between product and process

You don't need HQ. You don't need multi-project orchestration. One project, one `dosi/` folder, one AI partner — that's the simplest DOSI setup, and it works.

HQ is just a pattern for when you scale to multiple projects. See [HQ Pattern](/guide/hq-pattern).

## Core Principles

1. **Separation of concerns** — `dosi/` operates ON the product, not IN it
2. **Capture first, structure later** — raw ideas in immediately
3. **Autonomous with oversight** — AI works independently, human steers
4. **State is explicit** — read on boot, write on close
5. **Portable** — works on any project, any AI tool
6. **Cumulative** — every session compounds the knowledge network
