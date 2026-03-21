#!/usr/bin/env bash
# DOSI Agent Sync — deploy canonical agents to their target levels
#
# Usage:
#   sync-agents.sh              # sync all agents
#   sync-agents.sh acx-dev      # sync specific agent
#   sync-agents.sh --dry-run    # show what would be done
#
# Resolution levels:
#   Global:  ~/.claude/agents/
#   Org:     {org}/HQ/.claude/agents/ + symlinks into projects
#   Project: {project}/.claude/agents/

set -euo pipefail

DOSI_ROOT="${HOME}/dosi"
AGENTS_DIR="${DOSI_ROOT}/agents"
GLOBAL_DIR="${HOME}/.claude/agents"
DRY_RUN=false
TARGET_AGENT=""

# Parse args
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    *) TARGET_AGENT="$arg" ;;
  esac
done

# Agent placement map
# Format: agent_name:level:org_root
# level: global | org
# org_root: path to org root (only for org-level agents)
declare -A AGENT_MAP=(
  # Orchestrators — global
  ["ant"]="global"
  ["bree"]="global"
  ["dosi"]="global"

  # Specialists — global
  ["acx-dev"]="global"

  # Specialists — Org-B
  ["acqe-review"]="org:${HOME}/orgb"
  ["acqe-viz"]="org:${HOME}/orgb"
  ["acqe-guard"]="org:${HOME}/orgb"
  ["acqe-docs"]="org:${HOME}/orgb"
  ["qlik"]="org:${HOME}/orgb"
)

# Retired agents — will be cleaned up during sync
RETIRED_AGENTS=("acqe-panel")

# Known projects per org (for symlink distribution)
declare -A ORG_PROJECTS=(
  ["${HOME}/orgb"]="extensions"
  # Add more: ["${HOME}/orga"]="product-engine admin-portal"
)

log() { echo "[sync] $*"; }
dry() { if $DRY_RUN; then echo "[dry-run] $*"; return 0; else return 1; fi; }

find_agent_file() {
  local name="$1"
  local file=""
  # Check orchestrators first, then specialists
  for dir in orchestrators specialists; do
    if [[ -f "${AGENTS_DIR}/${dir}/${name}.md" ]]; then
      file="${AGENTS_DIR}/${dir}/${name}.md"
      break
    fi
  done
  echo "$file"
}

deploy_global() {
  local name="$1"
  local src="$2"
  local dest="${GLOBAL_DIR}/${name}.md"

  if dry "symlink ${src} → ${dest}"; then return; fi

  mkdir -p "${GLOBAL_DIR}"
  # Remove existing (file or symlink)
  rm -f "${dest}"
  ln -sf "${src}" "${dest}"
  log "✓ ${name} → global (${dest})"
}

deploy_org() {
  local name="$1"
  local src="$2"
  local org_root="$3"
  local hq_dir="${org_root}/HQ/.claude/agents"
  local hq_dest="${hq_dir}/${name}.md"

  # 1. Deploy to org HQ
  if dry "symlink ${src} → ${hq_dest}"; then :; else
    mkdir -p "${hq_dir}"
    rm -f "${hq_dest}"
    ln -sf "${src}" "${hq_dest}"
    log "✓ ${name} → org HQ (${hq_dest})"
  fi

  # 2. Symlink into each known project
  local projects="${ORG_PROJECTS[${org_root}]:-}"
  for project in $projects; do
    local proj_dir="${org_root}/${project}/.claude/agents"
    local proj_dest="${proj_dir}/${name}.md"

    if dry "symlink ${src} → ${proj_dest}"; then continue; fi

    mkdir -p "${proj_dir}"
    rm -f "${proj_dest}"
    ln -sf "${src}" "${proj_dest}"
    log "✓ ${name} → project (${proj_dest})"
  done

  # 3. Also deploy to global so agents are available everywhere
  deploy_global "${name}" "${src}"
}

cleanup_retired() {
  for name in "${RETIRED_AGENTS[@]}"; do
    local targets=(
      "${GLOBAL_DIR}/${name}.md"
    )

    # Add org HQ and project targets
    for org_root in "${!ORG_PROJECTS[@]}"; do
      targets+=("${org_root}/HQ/.claude/agents/${name}.md")
      local projects="${ORG_PROJECTS[${org_root}]:-}"
      for project in $projects; do
        targets+=("${org_root}/${project}/.claude/agents/${name}.md")
      done
    done

    for target in "${targets[@]}"; do
      if [[ -e "$target" || -L "$target" ]]; then
        if dry "remove retired ${target}"; then continue; fi
        rm -f "${target}"
        log "✗ removed retired agent: ${target}"
      fi
    done
  done
}

sync_agent() {
  local name="$1"
  local placement="${AGENT_MAP[${name}]:-}"

  if [[ -z "$placement" ]]; then
    log "⚠ Unknown agent: ${name} (not in AGENT_MAP)"
    return 1
  fi

  local src
  src=$(find_agent_file "$name")
  if [[ -z "$src" ]]; then
    log "⚠ No source file found for: ${name}"
    return 1
  fi

  local level="${placement%%:*}"
  local org_root="${placement#*:}"

  case "$level" in
    global)
      deploy_global "$name" "$src"
      ;;
    org)
      deploy_org "$name" "$src" "$org_root"
      ;;
    *)
      log "⚠ Unknown level: ${level} for ${name}"
      return 1
      ;;
  esac
}

# Main
if [[ -n "$TARGET_AGENT" ]]; then
  sync_agent "$TARGET_AGENT"
else
  log "Syncing all agents..."
  cleanup_retired
  for name in "${!AGENT_MAP[@]}"; do
    sync_agent "$name"
  done
  log "Done. $(ls -1 "${GLOBAL_DIR}"/*.md 2>/dev/null | wc -l) agents in global dir."
fi
