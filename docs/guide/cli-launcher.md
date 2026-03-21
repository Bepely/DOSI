# CLI Launcher

DOSI ships with a terminal launcher that makes starting sessions instant — one project at a time, or all of them in parallel tabs. Every session launches with the [DOSI agent](/guide/dosi-agent) by default (`claude --agent dosi`), so the full protocol is active from the first prompt.

## Usage

```bash
dosi                     # interactive menu
dosi all                 # launch all available sessions as tabs
dosi 1 3 5               # launch specific sessions by number
dosi scan                # show detected projects (no launch)
dosi status              # show open/closed status of all OCDs
dosi close               # close all open OCD sessions
dosi knowledge           # show all Qdrant collection stats (alias: dosi k)
dosi doctor              # workstation health check
dosi log                 # cross-org activity timeline
dosi help                # show all commands
dosi version             # show CLI and protocol version
dosi 1 -m "lets go"      # launch with initial prompt
dosi all -m "boot up"    # launch all with initial prompt
```

## Interactive Mode

```
  D O S I  v1.0

  ────────────────────────────────────────────────

  1  ◆ Bepely HQ          BHQ   dosi  ● BHQ-OCD-008
  2  ◇ Org-B HQ        ACHQ  ant   ○ ACHQ-OCD-005
  3  ◈ Org-A HQ            NHQ   bree  ○ NHQ-OCD-010
  4  ◈ Product Engine        NE    bree  ○ NE-OCD-009
  5  ◈ Admin Portal  NAP   bree  – no sessions
  6  ⏣ DOSI Protocol      DOSI  dosi  ○ DOSI-OCD-002

  ────────────────────────────────────────────────
  6 projects · enter numbers to select · a=all · q=quit

  →
```

### Selection

- **Type a number** (e.g. `2`) to toggle it. Type more numbers to select multiple.
- **`a`** selects all available projects and launches immediately.
- **Enter** launches the selected sessions.
- **`q`** quits.

### What Happens

| Selection | Behavior |
|-----------|----------|
| 1 project | `cd` into it, `exec claude --agent dosi` (replaces current shell) |
| 2+ projects | Opens a new **Windows Terminal** window with one tab per project, each running `claude --agent dosi` |

When launching multiple tabs, the launcher shows a summary and hotkey reference before opening the window:

```
  Launching 2 session(s)

  ▸ Tab 1: ◈ Org-A HQ  bree  → ~/org-a/HQ
  ▸ Tab 2: ◈ Product Engine  bree  → ~/org-a/product-engine

  ────────────────────────────────────────────────
  Windows Terminal Hotkeys
  Ctrl+Tab          │ Next tab
  Ctrl+Shift+Tab    │ Previous tab
  Ctrl+Alt+<N>      │ Jump to tab N
  Ctrl+Shift+W      │ Close tab
  Ctrl+Shift+T      │ New tab
  ────────────────────────────────────────────────
```

## CLI Mode

Skip the menu entirely:

```bash
# Launch all sessions
dosi all

# Launch Org-A HQ and Product Engine
dosi 2 3

# Launch just one (same as picking it from the menu)
dosi 1
```

## What You See

- **Sigil** — org-specific icon (◈ ◇ ◆ ⏣ ⬡ or ○)
- **Workspace name** — the project or HQ
- **Prefix** — the OCD prefix for that workspace
- **Agent** — which agent runs in this project (dosi, bree, ant, etc.)
- **Status** — `●` open (red), `○` closed (green), `–` no sessions (dim)
- **Last OCD** — pulled from STATE.md, shows where you left off

## How It Works

The launcher is a bash script at `~/.local/bin/dosi`. It auto-detects DOSI-enabled projects by scanning for `STATE.md` files:

```bash
# Scans $HOME (depth 4) for STATE.md files with OCD Prefix
# No hardcoded arrays — add a project, it appears automatically
```

It reads `STATE.md` (at root for HQs, at `dosi/STATE.md` for projects), extracts the OCD prefix, determines the correct agent from the project path, and shows the current session status.

Multi-session launch uses `wt.exe` (Windows Terminal CLI) to open tabs from WSL:

```bash
wt.exe new-tab --title "◈ Org-A HQ" -- wsl.exe -d Ubuntu-24.04 -- bash -ilc 'cd ~/org-a/HQ && claude' \
  ; new-tab --title "◈ Product Engine" -- wsl.exe -d Ubuntu-24.04 -- bash -ilc 'cd ~/org-a/product-engine && claude'
```

Each tab gets a titled sigil so you can identify sessions at a glance.

## Desktop Shortcut

For a one-click launch from Windows, create a `.vbs` file on your desktop:

```vb
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "wt.exe new-tab --title ""◈ D O S I"" -- wsl.exe -d Ubuntu-24.04 -- bash -ilc dosi", 0, False
```

Double-click to open the DOSI menu in Windows Terminal. No CMD flash.

## Adding a Workspace

No configuration needed. The launcher auto-detects any project that has a `STATE.md` file with an `**OCD Prefix:**` field. Just [scaffold a new project](/guide/getting-started) and it appears in the menu automatically.

To customize the org sigil or agent for your project path, edit the `sigil_for()` and `agent_for()` functions in the launcher script.

## Installation

Save the script to your PATH:

```bash
mkdir -p ~/.local/bin
curl -o ~/.local/bin/dosi https://raw.githubusercontent.com/Bepely/DOSI/main/scripts/dosi
chmod +x ~/.local/bin/dosi
```

Make sure `~/.local/bin` is in your PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

## DOSI Agent Integration

The launcher runs `claude --agent dosi` by default. The [DOSI agent](/guide/dosi-agent) is a Claude Code custom agent that encodes the full protocol as a system prompt — automatic boot sequence, OCD management, and session lifecycle.

Without the agent, Claude still works but you'd need to manually instruct it to follow the DOSI protocol. With the agent, it's automatic from the first prompt.

## Customization

The script runs `exec claude --agent dosi` by default. Change it to whatever AI tool you use:

```bash
cd "$dir" && exec cursor    # for Cursor
cd "$dir" && exec aider     # for Aider
```

The launcher is tool-agnostic. DOSI works with any AI coding partner.
