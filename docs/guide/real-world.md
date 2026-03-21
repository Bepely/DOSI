# Real-World Usage — Bepely's Workflow

This is the actual daily workflow of **Bepely** ([GitHub](https://github.com/Bepely)) — the creator of DOSI. Not a hypothetical. Not a tutorial. This is how it runs in production, every day.

The creator is a solo developer building **Narr** (a content engine in Go + SvelteKit) and working at a charting library company as a software engineer. Two completely separate codebases, two organizations, one developer, one AI partner (Claude Code). DOSI is the system that keeps everything documented and searchable across 60+ development sessions — across both.

---

## The Setup

The creator runs WSL2 Ubuntu on Windows 11. Everything lives in his home directory:

```
~/
├── HQ/                         ← root brain (cross-org, meta, DOSI updates)
├── dosi/                       ← DOSI protocol repo (this site)
├── inter/                      ← Inter project (Bepely IP)
├── org-a/
│   ├── HQ/                     ← Org-A orchestrator (planning, coordination)
│   ├── product-engine/            ← Go engine (the product)
│   └── admin-portal/      ← SvelteKit frontend (the product)
└── org-b/
    ├── HQ/                     ← Org-B orchestrator
    └── ...
```

Three tiers of HQ, each with its own OCD prefix:

| HQ | Prefix | What it's for |
|---|---|---|
| `~/HQ/` | BHQ | Cross-org decisions, DOSI updates, workstation setup |
| `~/org-a/HQ/` | NHQ | Org-A-specific planning, multi-repo coordination |
| `~/org-a/product-engine/` | NE | Engine work (building the actual product) |

## The Daily Routine

You double-click **DOSI** on his Windows desktop. Windows Terminal opens with the DOSI launcher — a multi-select menu showing all projects, their OCD prefixes, and last session numbers. He picks the sessions he needs today and they open as parallel tabs, each running Claude Code with a context-aware [status line](/guide/statusline).

```
  D O S I  v1.0

  1  ◆ Bepely HQ          BHQ   dosi  ● BHQ-OCD-008
  2  ◈ Org-A HQ            NHQ   bree  ○ NHQ-OCD-010
  3  ◈ Product Engine        NE    bree  ○ NE-OCD-009
  4  ◈ Admin Portal  NAP   bree  – no sessions
  5  ⏣ DOSI Protocol      DOSI  dosi  ○ DOSI-OCD-002

  → 2 3  [Enter]

  Launching 2 session(s)

  ▸ Tab 1: ◈ Org-A HQ  bree  → ~/org-a/HQ
  ▸ Tab 2: ◈ Product Engine  bree  → ~/org-a/product-engine

  Ctrl+Tab — next tab │ Ctrl+Alt+<N> — jump to tab
```

Two tabs open. Each one boots Claude, reads its `CLAUDE.md`, and starts a DOSI session. The status line at the bottom of each tab shows the project sigil, git branch, model, context usage, and cost — so you always know where he is, even with 4+ tabs open.

Or, if it's a full day: `dosi all`. Every available project opens in its own tab.

### Working on the engine

```bash
# From the DOSI launcher, pick 3 — or:
dosi 3
```

Claude reads `CLAUDE.md` → reads `dosi/STATE.md` → reads `dosi/ocd/INDEX.md` → creates `dosi/ocd/NE-OCD-007/NE-OCD-007.md` → asks: *"Last session added records endpoints. What are we doing today?"*

You say: *"Add the sessions endpoints."*

Claude builds. Updates the OCD file as it goes — actions taken, decisions made, files created.

You interrupt mid-session: *"Oh also, we need rate limiting on the capture endpoint."*

Claude logs it under Idea Capture and keeps working on sessions endpoints. No derail. No lost thought.

Session closes. Claude finalizes the OCD, updates STATE.md and INDEX.md, commits. Done.

### Planning across org repos

```bash
cd ~/org-a/HQ
claude
```

Claude boots as the Org-A orchestrator. It can dispatch work to product-engine and admin-portal. HQ sessions are for migration planning, cross-repo architecture, org decisions.

### Meta work (DOSI updates, workstation setup)

```bash
cd ~/HQ
claude
```

This is where BHQ-OCD-001 happened — the session that bootstrapped WSL2, published DOSI v0.3, created the HQ hierarchy, scaffolded product-engine, and cleaned up GitHub. All documented in one OCD directory.

## What a Session Produces

After a session, the OCD directory contains everything:

```
dosi/ocd/NE-OCD-007/
├── NE-OCD-007.md              ← session document (decisions, actions, ideas, outcomes)
├── sessions-api-design.md     ← design doc written during session
├── endpoint-mapping.json      ← data created during session
└── rate-limiting-notes.md     ← idea capture, fleshed out into a doc
```

Any file type. Markdown, JSON, SQL, Mermaid diagrams, SVG schematics. All inside the OCD directory. All parseable by a vector database later.

## GitHub Visibility

The creator has collaborators waiting to join the Org-A. They'll see the product repos. They won't see the HQs. And his Org-B work stays completely separate — private HQ under his personal account, the company never sees his orchestration layer.

```
Bepely (personal account, PRIVATE)
├── HQ                 ← private (root brain)
├── inter              ← private (Bepely IP)
├── orgb-HQ        ← private (Org-B orchestration)
└── DOSI               ← PUBLIC (it's the protocol)

YourOrg (org, collaborators see these)
├── product-engine        ← shared with Org-A collaborators
├── admin-portal  ← shared with Org-A collaborators
└── .github

Org-B (company repos — separate from DOSI entirely)
└── (Org-B project repos, managed through orgb-HQ)
```

Orchestration stays invisible. Product code is shared. Two organizations, one developer, one system. Clean separation.

## The Key Numbers

- **60+** development sessions documented
- **3** major DOSI versions (v0.1 → v0.2 → v0.3)
- **3** HQ tiers (personal → org → project)
- **8+** OCD prefixes registered (BHQ, DOSI, INT, NHQ, NE, NAP, ACHQ, ACQE...)
- **1** person, 1 AI partner, zero context lost

## The Status Line

Every Claude Code session shows a live status bar:

```
◈ NARR·product-engine │ main* │ Opus │ ███░░░░░░░ 34% │ $1.22 │ +87 -12
```

Project sigils tell you where you are at a glance:
- **◈** Org-A projects
- **◇** Org-B projects
- **◆** Bepely personal / HQ
- **⏣** DOSI Protocol

Context bar goes red → yellow → bold red as you fill the window. Cost turns yellow past $1. Git branch shows `*` when dirty. All automatic — the script detects the project from the working directory.

See [Status Line](/guide/statusline) for setup.

## What Makes It Work

It's not the protocol. It's not the naming convention. It's not the HQ hierarchy.

It's the fact that **documentation is generated while you work**. You don't write docs after the fact. You don't maintain a wiki. You don't update a changelog manually. You work with your AI partner, and the OCD directory fills up as a byproduct.

Session 47 knows what session 1 decided. Not because someone wrote it down — because the system wrote it down while session 1 was happening.

That's DOSI.
