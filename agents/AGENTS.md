# DOSI Agent Registry

Canonical source for all Bepely agent definitions. Synced to `~/.claude/agents/` and project-level `.claude/agents/` via `scripts/sync-agents.sh`.

## Resolution Order

When an agent or skill is needed, it resolves bottom-up:

```
1. Project     .claude/agents/        ← project-specific overrides
2. Org HQ      {org}/HQ/.claude/agents/  ← org-level shared agents
3. Global      ~/.claude/agents/       ← universal agents
4. DOSI Canon  ~/dosi/agents/          ← source of truth (not read by Claude directly)
```

If not found at any level → prompt to install and ask at which level.

## Agent Placement Rules

| Level | When | Example |
|-------|------|---------|
| **Global** | Agent is useful across ALL orgs and projects | `dosi`, `acx-dev` |
| **Org** | Agent is specific to one org's workflow | `acqe-review`, `acqe-viz`, `acqe-guard`, `acqe-docs` |
| **Project** | Agent is specific to one repo | (rare — usually org level is enough) |

## Orchestrators (Global)

| Agent | File | Purpose |
|-------|------|---------|
| `ant` | `orchestrators/ant.md` | Org-B CTO — org orchestrator |
| `bree` | `orchestrators/bree.md` | Org-A CTO — org orchestrator |
| `dosi` | `orchestrators/dosi.md` | DOSI protocol agent — session lifecycle |

## Specialists

| Agent | File | Level | Purpose |
|-------|------|-------|---------|
| `acx-dev` | `specialists/acx-dev.md` | Global | ACX visualization developer — builds chart extensions |
| `acqe-review` | `specialists/acqe-review.md` | Org-B | Extension reviewer — property panel, design, Qlik compliance, UX audit |
| `acqe-viz` | `specialists/acqe-viz.md` | Org-B | Visualization analyst — dataviz best practices, catches design mistakes |
| `acqe-docs` | `specialists/acqe-docs.md` | Org-B | Documentation — 3-audience (user/dev/mgmt), Docusaurus-ready, embedding |
| `acqe-guard` | `specialists/acqe-guard.md` | Org-B | Security & testing — Jest, license validation, build integrity |
| `qlik` | `specialists/qlik.md` | Org-B | Qlik Sense consultant — load scripts, data modeling, extension API |

## Retired

| Agent | Replaced By | Reason |
|-------|------------|--------|
| `acqe-panel` | `acqe-review` | Panel design absorbed into broader extension review mandate |

## Extension Build Squad

When building a new extension, the typical dispatch is:

```
1. acqe-viz    → Validate chart type choice, visual approach, data encoding
2. acx-dev     → Build the extension (pipeline, drawers, interactions)
3. acqe-review → Review the result (panel, connectivity, compliance, UX)
4. acqe-docs   → Document for all three audiences
5. acqe-guard  → Write tests, security audit
```

Ant (CTO) orchestrates. Agents can run in parallel where independent (e.g., viz assessment + docs research).

## Sync

Run `~/dosi/scripts/sync-agents.sh` to deploy agents to their target levels.

```bash
# Deploy all agents
~/dosi/scripts/sync-agents.sh

# Deploy specific agent
~/dosi/scripts/sync-agents.sh acx-dev

# Show what would be synced (dry run)
~/dosi/scripts/sync-agents.sh --dry-run
```
