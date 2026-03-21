# Getting Started

Set up DOSI in a new project in under 5 minutes.

## Prerequisites

- A project with a git repository
- An AI coding tool (Claude Code, Cursor, or similar)
- That's it

## Where Does DOSI Live?

DOSI runs anywhere. You don't need an HQ or a special repo. Just drop `dosi/` into any existing project.

**The important part:** add `dosi/` to your project's `.gitignore`. The DOSI control room is development infrastructure — it's not part of the product. It tracks your work, not your code. Keep it separate.

```gitignore
# DOSI development infrastructure
dosi/
```

This means:
- Your product repo stays clean — no session files in PRs
- `dosi/` is local to your workstation (or in a separate DOSI repo if you want it versioned)
- You can point a vector DB at any `dosi/` folder on disk — it doesn't need to be in git
- Multiple developers can have their own `dosi/` without conflicts

If you DO want to version your DOSI sessions (recommended for solo projects), either:
- Keep `dosi/` tracked in git (don't gitignore it) — simpler, everything in one repo
- Use a separate DOSI repo that mirrors your project structure — cleaner separation

For HQ-style orchestration across multiple projects, see the [HQ Pattern](/guide/hq-pattern).

## Step 1: Create the Control Room

Create a `dosi/` directory at your project root:

```bash
mkdir -p dosi/ocd
```

## Step 2: Add STATE.md

Create `dosi/STATE.md` — the live snapshot of your project:

```markdown
# {Project Name} — Project State

**Last Updated:** {today}
**Branch:** `main`
**Version:** v0.1.0
**OCD Prefix:** {PREFIX}
**Last OCD:** —
**Next OCD:** {PREFIX}-OCD-001
**Status:** New project. DOSI initialized.

---

## Architecture

{Brief description: what this project is, tech stack, key files}

## Key Files

{List the important files and what they do}
```

Choose a short, unique **OCD Prefix** for your project (e.g., `NE` for product-engine, `HQ` for headquarters).

## Step 3: Add DOSI-REF.md

Create `dosi/DOSI-REF.md` — a reference to the canonical protocol:

```markdown
# DOSI Reference

This project follows the **DOSI protocol** (Development Operational Session Instructions).

**Canonical source:** github.com/Bepely/dosi (v0.3)

## Quick Reference

1. Read `dosi/STATE.md` — where are we?
2. Read `dosi/ocd/INDEX.md` — session history
3. Create OCD directory → `dosi/ocd/{PREFIX}-OCD-{N}/{PREFIX}-OCD-{N}.md`
4. Imprint session open (who, when, goal)
5. Do the work, update OCD continuously
6. Imprint session close, update STATE.md + INDEX.md
7. Commit
```

## Step 4: Add the OCD Index and Template

Create `dosi/ocd/INDEX.md`:

```markdown
# {Project Name} — Session Index

| Session | Date | Focus | Status | Outcomes |
|---------|------|-------|--------|----------|

## Statistics

- Total sessions: 0
```

Copy the [OCD Template](/reference/ocd-template) to `dosi/ocd/TEMPLATE.md`.

## Step 5: Wire CLAUDE.md

Create or update `CLAUDE.md` at your project root:

```markdown
# {Project Name} — CTO Operating Instructions

You are the CTO of **{project}**.

Your control room is `dosi/`. Read it on every session start.

## Boot Sequence

1. Read `dosi/STATE.md` — current project state
2. Read `dosi/ocd/INDEX.md` — session history
3. Read `dosi/DOSI-REF.md` — session protocol
4. Create OCD directory at `dosi/ocd/{PREFIX}-OCD-{N}/{PREFIX}-OCD-{N}.md`
5. Imprint session open
6. Report to user: what you found, what you plan to do
7. Confirm objectives before proceeding

## Product Overview

{What this project does, tech stack, architecture}

## Conventions

- Dates: YYYY-MM-DD
- Git: `main` branch, ask before push
```

## Step 6: Run Your First Session

Open your AI tool and tell it:

> Read your control room at `dosi/`. Open your first session.

The AI will:
1. Read STATE.md and INDEX.md
2. Create `dosi/ocd/{PREFIX}-OCD-001/{PREFIX}-OCD-001.md`
3. Ask you to confirm objectives
4. Start working

When done, it closes the session, updates STATE.md and INDEX.md, and commits.

## What's Next

- [Session Lifecycle](/guide/session-lifecycle) — understand the full boot → execute → close flow
- [HQ Pattern](/guide/hq-pattern) — set up an orchestrator for multiple projects
- [Vector Memory](/guide/vector-memory) — add semantic recall across sessions
- [CLI Launcher](/guide/cli-launcher) — multi-session launcher with parallel tabs
- [Status Line](/guide/statusline) — context-aware status bar for Claude Code
