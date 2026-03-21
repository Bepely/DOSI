# Changelog

## v1.0.0 — 2026-03-20

The beast update. CLI redesign with Narr's design constitution.

### Added
- **CLI v1.0** — complete rewrite applying Narr's 5 design principles to terminal output
- **`dosi help`** — two-tier help system with one-line descriptions for all commands
- **`dosi version`** — show CLI and protocol versions
- **`dosi doctor`** — workstation health check (runtime, agents, knowledge, config)
- **`dosi log`** — cross-org activity timeline from all INDEX.md files
- **`dosi completion bash`** — bash completion script generator
- **`dosi close`** — renamed from `close-all` (old name still works as alias)
- **Unified render system** — shared `render_project_line()`, `render_header()`, `render_footer()` functions enforce consistent visual grid across all commands
- **Strict color system** — cyan for interactive, green/red/yellow for status only, agent names in dim monochrome
- **Summary footers** — every command output ends with aggregate stats and contextual hint

### Changed
- CLI version bumped from v0.8 to v1.0
- Selection marker changed from red `▸` to cyan `▸` (red reserved for errors/status)
- Agent names render in dim instead of status colors (fixes green = "Bree" AND "success" collision)
- All `printf` format strings unified to single spatial grid
- wt.exe launch logic deduplicated (was copy-pasted 3x, now single function)
- Four-collection knowledge architecture documented in vector memory guide
- Observer pattern documented in HQ pattern guide
- Website updated to reflect current state (v1.0 CLI, 4 collections, observer pattern, current screenshots)

### Fixed
- Repo CLI (v0.6) synced with installed version — no more version drift

## v0.3.1 — 2026-03-18

The agent update. DOSI becomes self-aware.

### Added
- **DOSI agent** — Claude Code custom agent (`~/.claude/agents/dosi.md`) that encodes the full protocol as a system prompt. Automatic boot sequence, OCD management, session lifecycle, idea capture, and close sequence.
- **Agent-first launcher** — `dosi` CLI now launches all sessions with `claude --agent dosi` by default. Both single-session and multi-tab modes.
- **CLI commands** — `dosi status` (show open/closed OCDs), `dosi close-all` (batch close), `dosi scan` (show detected projects)
- **Statusline v3** — multi-line status bar with OCD detection, DOSI version display, git stats, token/cache metrics, cost tracking

### Changed
- CLI launcher upgraded from hardcoded arrays to auto-detection (scans for STATE.md files)
- CLI version bumped to v0.6

## v0.3.0 — 2026-03-18

The knowledge update. DOSI becomes cumulative.

### Added
- **Vector memory layer** — OCD files chunked and embedded into a vector database for semantic recall
- **Cross-project knowledge** — all projects share one knowledge collection, nothing is siloed
- **Session boot recall** — AI queries knowledge network with session goal, surfaces relevant history automatically
- **Auto-embed on close** — session documents embedded at the end of every session
- **OCD naming prefixes** — `{PREFIX}-OCD-{N}` for global uniqueness across projects
- **HQ pattern** — orchestrator repos that coordinate across multiple projects using DOSI branches
- **Cumulative principle** — sixth core principle, every session compounds the knowledge network
- **Session open/close imprints** — structured birth and death certificates for each session
- **Containment rule** — all generated artifacts must live inside OCD directories for vector traversal

### Changed
- Canonical source moved from project-specific to `github.com/Bepely/dosi`
- OCD directory structure: `ocd/{PREFIX}-OCD-{N}/{PREFIX}-OCD-{N}.md`
- Projects reference DOSI via `DOSI-REF.md` instead of embedding the full protocol

## v0.2.0 — 2026-03-11

The structure update.

### Added
- OCD directories (one directory per session, allows artifacts)
- Session imprinting (open/close with who, when, goal, outcome)
- `knowledge/` folder convention for domain knowledge

### Changed
- OCD files moved from flat files to directories
- Session template updated with imprint sections

## v0.1.0 — 2026-03-03

Genesis.

### Added
- Session lifecycle (boot → execute → close)
- Session modes (Plan, Build, Fix, Meta, Explore)
- Agent coordination (dispatch model, parallel rules)
- Idea capture (RAW → STRUCTURED → ACTIONED)
- State management (STATE.md, INDEX.md, snapshots)
- Configuration model (CLAUDE.md + dosi/ separation)
- Deployment instructions
