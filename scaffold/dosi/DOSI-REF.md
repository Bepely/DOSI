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

## Session Modes

| Mode | When |
|------|------|
| Plan | New features, architectural decisions |
| Build | Execute implementation plans |
| Fix | Bugfix, stabilization |
| Meta | Dev tooling, process |
| Explore | Research, spike, prototype |
