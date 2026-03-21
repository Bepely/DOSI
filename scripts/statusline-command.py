#!/usr/bin/env python3
"""DOSI Statusline — Mirror's Edge × Tech-Medieval
Dynamic context-aware status bar for Claude Code.

Sigils:  ◈ Org-A  ◇ Org-B  ◆ Bepely  ○ Other
Palette: bright red accent, white primary, gray chrome, cyan model
"""

import json
import os
import subprocess
import sys

# --- Parse input ---
try:
    data = json.load(sys.stdin)
except Exception:
    data = {}

cwd = (data.get("workspace", {}).get("current_dir")
       or data.get("cwd", os.getcwd()))
model = data.get("model", {}).get("display_name", "—")
ctx = data.get("context_window", {})
ctx_pct = ctx.get("used_percentage") or 0
cost_usd = data.get("cost", {}).get("total_cost_usd")
lines_add = data.get("cost", {}).get("total_lines_added", 0)
lines_rm = data.get("cost", {}).get("total_lines_removed", 0)

# --- Project detection ---
# Resolve home dir for ~/HQ detection
home = os.path.expanduser("~")
cwd_lower = cwd.lower()

# ~/HQ is the root brain (Bepely HQ) — check first
if cwd.rstrip("/") == f"{home}/HQ" or cwd.startswith(f"{home}/HQ/"):
    sigil, project = "◆", "HQ"
elif "/orga/" in cwd_lower or cwd_lower.endswith("/orga"):
    parts = cwd.rstrip("/").split("/")
    try:
        idx = next(i for i, p in enumerate(parts) if p.lower() == "orga")
        sub = parts[idx + 1] if idx + 1 < len(parts) else "root"
    except StopIteration:
        sub = "root"
    sigil, project = "◈", f"NARR·{sub}"
elif "/orgb/" in cwd_lower or cwd_lower.endswith("/orgb"):
    parts = cwd.rstrip("/").split("/")
    try:
        idx = next(i for i, p in enumerate(parts) if p.lower() == "orgb")
        sub = parts[idx + 1] if idx + 1 < len(parts) else "root"
    except StopIteration:
        sub = "root"
    sigil, project = "◇", f"AC·{sub}"
elif "/inter/" in cwd_lower or cwd_lower.endswith("/inter"):
    parts = cwd.rstrip("/").split("/")
    try:
        idx = next(i for i, p in enumerate(parts) if p.lower() == "inter")
        sub = parts[idx + 1] if idx + 1 < len(parts) else "root"
    except StopIteration:
        sub = "root"
    sigil, project = "◈", f"INTER·{sub}"
else:
    sigil, project = "○", os.path.basename(cwd) or "~"

# --- Git branch ---
branch = ""
try:
    result = subprocess.run(
        ["git", "-C", cwd, "branch", "--show-current"],
        capture_output=True, text=True, timeout=2
    )
    if result.returncode == 0:
        branch = result.stdout.strip()
        dirty = subprocess.run(
            ["git", "-C", cwd, "status", "--porcelain"],
            capture_output=True, text=True, timeout=2
        )
        if dirty.stdout.strip():
            branch += "*"
except Exception:
    pass

# --- Context bar (10 segments) ---
ctx_pct = max(0, min(100, int(ctx_pct)))
filled = ctx_pct // 10
bar = "█" * filled + "░" * (10 - filled)

if ctx_pct > 80:
    bar_c = "\033[1;91m"   # bold bright red — danger
elif ctx_pct > 50:
    bar_c = "\033[93m"     # yellow — caution
else:
    bar_c = "\033[91m"     # bright red — Mirror's Edge accent

# --- Cost ---
cost_str = ""
cost_c = ""
if cost_usd is not None:
    cost_str = f"${cost_usd:.2f}"
    cost_c = "\033[93m" if cost_usd > 1.0 else "\033[32m"

# --- Lines delta ---
delta = ""
if lines_add or lines_rm:
    delta = f"+{lines_add} -{lines_rm}"

# --- Colors ---
R = "\033[91m"     # bright red — accent
W = "\033[97m"     # bright white — primary text
D = "\033[90m"     # dark gray — chrome / separators
C = "\033[96m"     # cyan — model
RST = "\033[0m"

sep = f"{D} │ {RST}"

# --- Assemble ---
parts = [f"{R}{sigil} {project}{RST}"]

if branch:
    parts.append(f"{W}{branch}{RST}")

parts.append(f"{C}{model}{RST}")
parts.append(f"{bar_c}{bar}{D} {ctx_pct}%{RST}")

if cost_str:
    parts.append(f"{cost_c}{cost_str}{RST}")

if delta:
    parts.append(f"{D}{delta}{RST}")

sys.stdout.write(sep.join(parts))
