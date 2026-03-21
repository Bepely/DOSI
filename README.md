<p align="center">
  <br>
  <strong>D O S I</strong>
  <br>
  <em>Development Operational Session Instructions</em>
  <br>
  <br>
  <a href="https://bepely.github.io/DOSI/">Documentation</a> · <a href="https://bepely.github.io/DOSI/guide/getting-started">Get Started</a> · <a href="https://bepely.github.io/DOSI/guide/what-is-ocd">What is OCD?</a>
  <br>
  <br>
</p>

---

> **You build software with AI. DOSI makes sure neither of you forgets what happened.**

You're a solo developer working with Claude, Cursor, or any AI coding agent. You ship features, make architecture calls, debug production, pivot strategies — and none of it gets written down. Next week you don't remember why you chose SQLite over Postgres. Next month the AI starts from zero.

**DOSI turns every development session into structured, embeddable documents — automatically, as you work.**

```
You work with AI  →  documents are generated as you go  →  vector DB eats them later
                                                           ↓
                                              any future session can recall any past decision
```

That's it. Everything else in DOSI exists to make this pipeline work.

---

## What You Get

**SESSION PROTOCOL** — Every session follows a lifecycle. Boot reads state + history. Execute logs everything. Close finalizes and commits. No session starts cold.

**OCD DIRECTORIES** — Every session produces an Operational Context Directory. A self-contained unit with the session doc, plans, schematics, data exports, diagrams — any file type. The directory IS the knowledge unit.

**CONTAINMENT RULE** — Everything generated during a session lives inside its OCD directory. Nothing floats. This makes the vector DB pipeline dead simple:

```
Walk ocd/*/  →  parse every file  →  metadata from path  →  embed  →  done
```

**IDEA CAPTURE** — You're watching the AI refactor a database. You think: *"we should add rate limiting."* Say it. The AI logs it and keeps working. No interruption, no lost ideas.

**HQ PATTERN** — Orchestrator repos that coordinate across multiple projects. Each project has its own OCD sessions. HQ sits above all of them.

---

## 30-Second Setup

```bash
mkdir -p dosi/ocd
```

Copy `scaffold/` into your project. Wire `CLAUDE.md` to point at `dosi/`. Done.

[Full setup guide →](https://bepely.github.io/DOSI/guide/getting-started)

---

## How a Session Looks

```
Boot    → AI reads STATE.md + INDEX.md, opens NE-OCD-007
Execute → you build, AI updates the OCD file as you go
Close   → AI finalizes, commits, session preserved forever
```

What you end up with:

```
dosi/ocd/
├── NE-OCD-007/
│   ├── NE-OCD-007.md           ← session doc (decisions, actions, ideas)
│   ├── migration-plan.md       ← plan created during session
│   ├── api-contract.md         ← doc created during session
│   ├── data-flow.mermaid       ← diagram sketched during session
│   └── benchmark-results.json  ← data captured during session
```

Every file in that directory is content. Every directory is a context unit. Every context unit is embeddable.

---

## DOSI vs OCD

```
DOSI                                    OCD
────────────────────────                ────────────────────────
The system                              A context unit
Protocol + lifecycle + coordination     One directory per session
Defines HOW you work                    Contains WHAT happened
Markdown protocol document              Any file type — .md .svg .json .sql .mermaid
Goal: structure the workflow             Goal: feed the vector database
```

---

## The Containment Rule

This is the core design constraint:

> **All artifacts generated during a session MUST live inside that session's OCD directory.**

Plans. Architecture docs. Postmortems. Schematics. SQL schemas. Mermaid diagrams. Screenshots. Data exports. Everything.

Files outside OCD directories are invisible to the embedding pipeline. Only four things live outside:
- `STATE.md` — live state (updated, not generated)
- `DOSI-REF.md` — protocol reference (static)
- `ocd/INDEX.md` — session log (append-only)
- `ocd/TEMPLATE.md` — session template (static)

This constraint is what makes the system work. One rule, zero configuration, infinite scalability.

---

## Battle-Tested

Built by a solo developer using Claude across **60+ development sessions** on production software.

Architecture overhauls. Strategic pivots. Multi-agent dispatch. Full-stack Go + SvelteKit builds. Hardware migrations. Business model design. All documented, all structured, all embeddable.

```
v0.1  2026-03-03  Session lifecycle, agent coordination, idea capture
v0.2  2026-03-11  OCD directories, session imprinting, knowledge folders
v0.3  2026-03-18  Containment rule, OCD prefixes, HQ pattern, vector-ready
```

---

## Repo Structure

```
├── DOSI.md              ← canonical protocol (v0.3)
├── scaffold/            ← drop into any project
│   ├── dosi/
│   │   ├── STATE.md
│   │   ├── DOSI-REF.md
│   │   └── ocd/
│   │       ├── INDEX.md
│   │       └── TEMPLATE.md
│   └── CLAUDE.md.example
├── docs/                ← VitePress docs site
└── LICENSE
```

---

## License

Source available. View, study, and fork for personal and educational use. Production use requires a commercial license. See [LICENSE](LICENSE).

---

<p align="center">
  Created by <strong><a href="https://github.com/Bepely">Bepely</a></strong> · Bepely
</p>
