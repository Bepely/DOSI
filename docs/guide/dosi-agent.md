# DOSI Agent

The DOSI agent is a Claude Code custom agent that encodes the full DOSI protocol as a system prompt. It turns any Claude Code session into a DOSI-aware session — automatic boot sequence, OCD management, idea capture, and session close.

## What It Does

The agent is the **protocol brain**. It knows:

- The full session lifecycle (boot → execute → close)
- OCD naming, containment rule, session modes
- How to read STATE.md, create OCD directories, update INDEX.md
- Idea capture protocol (RAW → STRUCTURED → ACTIONED)
- Your conventions (commits, git, identity)
- The HQ pattern and scope rules
- The known prefix registry

It does NOT contain product-specific knowledge — that stays in each project's `CLAUDE.md`.

## Agent vs MCP

| | Agent | MCP Server |
|---|-------|-----------|
| **What** | System prompt | Tool server |
| **Role** | Brain — knows *what* to do | Hands — knows *how* to do it |
| **Implements** | Protocol knowledge, lifecycle, conventions | `dosi_create_ocd()`, `dosi_read_state()`, `dosi_embed()` |
| **Dependency** | None — works with built-in tools (Read, Write, Bash) | Requires MCP server running |
| **When** | Now | When the MCP server is ready |

The agent works today using Claude's built-in tools to read/write files. When the MCP server lands, the agent stays the same — it just gets dedicated DOSI tools instead of generic file operations.

## Installation

Save the agent file to your Claude Code agents directory:

```bash
mkdir -p ~/.claude/agents
# Copy dosi.md to ~/.claude/agents/dosi.md
```

The agent file contains the full DOSI v0.3 protocol, boot sequence, session lifecycle, and all conventions.

## Usage

### Direct Launch

```bash
claude --agent dosi
```

### Via CLI Launcher (default)

The `dosi` CLI launcher uses the agent by default. Every session launched through `dosi` runs with `--agent dosi`:

```bash
dosi              # interactive menu → launches with --agent dosi
dosi all          # all sessions → each tab uses --agent dosi
dosi 1 3          # specific sessions → --agent dosi
```

### What Happens on Boot

When the agent starts, it runs the DOSI boot sequence automatically:

1. **Detect project** — finds `STATE.md`, extracts prefix and last OCD number
2. **Read state** — reads `STATE.md`, `ocd/INDEX.md`, `DOSI-REF.md`
3. **Check for active plan** — looks for in-progress sessions
4. **Create OCD directory** — `ocd/{PREFIX}-OCD-{N}/`
5. **Imprint session open** — records who, when, goal
6. **Present context** — summarizes recent sessions and open items
7. **Confirm objectives** — asks for go/no-go before starting work

### During Execution

- OCD file updated continuously
- Ideas captured immediately when you throw them
- STATE.md kept current
- Containment rule enforced (all artifacts inside OCD dir)

### On Close

Say "close session", "wrap up", or "done" and the agent will:

1. Imprint session close (who, when, outcome)
2. Finalize OCD file (actions, decisions, outcomes, next steps)
3. Append to `ocd/INDEX.md`
4. Update `STATE.md` (bump Last OCD, update date)
5. Commit with conventional format

## Keeping It Updated

The agent file at `~/.claude/agents/dosi.md` tracks the DOSI protocol version. When the protocol changes:

1. Update `DOSI.md` (canonical spec)
2. Update `~/.claude/agents/dosi.md` (agent prompt)
3. Update `docs/guide/dosi-agent.md` (this page)
4. Log the change in the changelog

The agent includes the known prefix registry and conventions. If you add a new project or change a convention, update the agent file.

::: tip Future: Auto-sync
When the DOSI MCP server is ready, protocol updates can be synced automatically — the MCP reads the canonical spec, and the agent queries the MCP for current state. Until then, manual updates.
:::

## Customization

The agent is a markdown file. You can:

- **Add project-specific prefixes** — update the Known Prefixes table
- **Change conventions** — modify the Conventions section
- **Add new session modes** — extend the Session Modes table
- **Adjust close behavior** — customize what happens on session close

The agent is designed to be forked per organization if needed, but for solo use a single global agent covers everything.

## File Location

```
~/.claude/agents/dosi.md    ← the agent (global, applies to all projects)
```

This is separate from project-level `CLAUDE.md` files. Both get loaded when you run `claude --agent dosi` in a project directory — the agent handles protocol, the project handles product context.
