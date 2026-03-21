# Status Line

DOSI includes a context-aware status line for Claude Code that shows your current project, git state, model, context usage, and session cost — at a glance.

## What It Looks Like

```
◈ ORGA·HQ │ main │ Opus │ █░░░░░░░░░ 12% │ $0.47 │ +42 -7
```

Each segment:

| Segment | Meaning |
|---------|---------|
| `◈ ORGA·HQ` | Project context — sigil + org + subproject |
| `main` | Git branch (`*` appended if dirty) |
| `Opus` | Active Claude model |
| `█░░░░░░░░░ 12%` | Context window usage (10-segment bar) |
| `$0.47` | Session cost so far |
| `+42 -7` | Lines added/removed this session |

## Project Sigils

The status line detects your working directory and assigns a sigil:

| Sigil | Context | Example |
|-------|---------|---------|
| ◈ | Org-A projects | `◈ ORGA·HQ`, `◈ ORGA·product-engine` |
| ◇ | Org-B projects | `◇ AC·extensions`, `◇ AC·HQ` |
| ◆ | Bepely personal | `◆ HQ`, `◆ BPL·DOSI` |
| ⏣ | DOSI Protocol | `⏣ DOSI` |
| ⬡ | Inter | `⬡ INT` |
| ○ | Other / unknown | `○ my-project` |

This means you always know which organization context you're operating in — especially when running multiple sessions in parallel tabs.

## Color Palette

The status line uses a **Mirror's Edge**-inspired palette:

| Color | Usage |
|-------|-------|
| Bright red | Sigil and project name — the accent color |
| White | Primary info (git branch) |
| Cyan | Model name |
| Red → Yellow → Bold red | Context bar (normal → caution → danger) |
| Green → Yellow | Cost (under $1 → over $1) |
| Dark gray | Separators, secondary info |

The context bar shifts color as you approach limits:
- **0–50%** — red accent (normal)
- **50–80%** — yellow (caution)
- **80–100%** — bold red (danger — context getting full)

## How It Works

Claude Code's `statusLine` feature pipes a JSON payload to a command on every refresh. The payload includes:

```json
{
  "workspace": { "current_dir": "/home/user/org-a/HQ" },
  "model": { "display_name": "Opus" },
  "context_window": { "used_percentage": 12 },
  "cost": { "total_cost_usd": 0.47, "total_lines_added": 42, "total_lines_removed": 7 }
}
```

The DOSI status line script (`~/.claude/statusline-command.py`) reads this JSON, detects the project context from the directory path, queries git for branch/dirty state, and outputs a formatted ANSI string.

## Installation

### 1. Save the script

```bash
mkdir -p ~/.claude
curl -o ~/.claude/statusline-command.py \
  https://raw.githubusercontent.com/Bepely/DOSI/main/scripts/statusline-command.py
```

### 2. Configure Claude Code

Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "python3 ~/.claude/statusline-command.py"
  }
}
```

That's it. The status line appears immediately in your next Claude Code session.

## Customization

### Adding your own org context

Edit the project detection in `statusline-command.py`:

```python
elif "/mycompany/" in cwd_lower:
    sigil, project = "⬡", f"MC·{sub}"
```

Pick any Unicode character as your sigil.

### Changing colors

The color constants at the bottom of the script use ANSI escape codes:

```python
R = "\033[91m"    # bright red — accent
W = "\033[97m"    # bright white — primary
D = "\033[90m"    # dark gray — chrome
C = "\033[96m"    # cyan — model
```

Change these to match your terminal theme.

### Hiding segments

Comment out or remove any `parts.append(...)` line to hide a segment. For example, to hide cost:

```python
# if cost_str:
#     parts.append(f"{cost_color}{cost_str}{RST}")
```

## Multi-Session Visibility

When running multiple DOSI sessions via the [CLI launcher](/guide/cli-launcher), each tab gets its own status line showing that tab's project context. Combined with Windows Terminal tab titles (set by the launcher), you always know:

- **Tab title**: which project this tab is (e.g. "◈ Product Engine")
- **Status line**: live state of that session (branch, context %, cost)

This is how you operate across 3–6 parallel sessions without losing track of where you are.
