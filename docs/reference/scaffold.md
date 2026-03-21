# Scaffold Files

These are the files you need to set up DOSI in a new project. Copy them from the `scaffold/` directory in the repo, or create them manually.

## File List

```
scaffold/
├── dosi/
│   ├── STATE.md          ← project state (customize)
│   ├── DOSI-REF.md       ← protocol reference (use as-is)
│   └── ocd/
│       ├── INDEX.md      ← session index (customize project name)
│       └── TEMPLATE.md   ← session template (use as-is)
└── CLAUDE.md.example     ← AI config (customize heavily)
```

## STATE.md

The live snapshot of your project. Customize everything.

## DOSI-REF.md

A lightweight reference to the canonical DOSI protocol. Keeps the protocol portable without duplicating the full document in every project.

## INDEX.md

The append-only session log. Start empty, grows with every session.

## TEMPLATE.md

The OCD session template. Use as-is — it's designed to work for any project.

## CLAUDE.md

The AI's operating instructions. This is the most important file to customize. It tells the AI:
- What this project is
- Where the control room lives
- How to boot a session
- Project-specific conventions

See the [Getting Started](/guide/getting-started) guide for a complete example.
