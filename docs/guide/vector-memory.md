# Vector Memory

*Added in DOSI v0.3*

The knowledge network gives your AI agent long-term memory across all sessions and all projects.

## The Problem

By session 30, you have 30 OCD files full of decisions, architecture notes, and lessons learned. The AI can't read all of them on every boot — it would blow the context window. But it still needs to know what was decided in session 12 when making a related decision in session 31.

## The Solution

Embed OCD files into a vector database. On boot, query with the session's goal. Relevant history surfaces automatically.

## Architecture

Each organization or concern gets its own Qdrant collection. Collections never mix at the storage level — cross-org knowledge mixing happens only in the agent's context window.

```
Qdrant
├── Collection: "dosi-core"        ← protocol, foundational knowledge
├── Collection: "knowledge"        ← org 1 dev history, decisions
├── Collection: "knowledge-orgb"    ← org 2 dev history, decisions
└── Collection: "personal-vault"     ← personal content (optional)
```

Each collection uses the same schema:

```
Vector: 1536-dim, cosine distance
Sources: all .md files inside ocd/{PREFIX}-OCD-*/ directories
Payload:
    ├── source_file    — path relative to project root
    ├── project        — project identifier
    ├── prefix         — "NE", "HQ", etc. (parsed from dir name)
    ├── ocd_number     — session number (parsed from dir name)
    ├── is_session_doc — true if filename matches dir name
    ├── filename       — "api-contract.md", "NE-OCD-003.md"
    ├── section        — "decisions", "actions", "ideas" (from ## heading)
    ├── date           — from session doc "Opened at" field
    └── tags           — freeform metadata
```

Each collection is served by the same MCP server binary with a different `DOSI_COLLECTION` environment variable. One binary, many instances.

## The Containment Rule

All generated artifacts live inside OCD directories. This is what makes the embedding pipeline dead simple:

```
Point vector DB at any DOSI instance folder
  → Walk ocd/*/
  → For each directory: parse prefix + number from dir name
  → For each .md file inside: chunk by ## headings
  → Each chunk gets metadata auto-derived from the path
  → Embed
```

No configuration. No file lists. No "which docs matter?" — everything inside OCD dirs matters. Everything outside is operational (STATE.md, INDEX.md) and not embedded.

## Chunking Strategy

All `.md` files inside OCD directories are chunked by `##` headings. Each chunk gets:
- The section content as embedding text
- The parent filename prepended for context
- Metadata payload auto-derived from the directory path

Target: 500-1500 tokens per chunk.

## When to Embed

| Trigger | What | How |
|---------|------|-----|
| **Session close** | All files in the current OCD directory | Traverse dir, chunk each `.md`, embed |
| **Project onboard** | All existing OCD directories | Walk `ocd/*/`, embed everything |
| **Re-embed** | Full rebuild | Delete collection, re-traverse all OCD dirs |

## When to Query

| Trigger | What | Why |
|---------|------|-----|
| **Session boot** | Goal → relevant history | Surface past decisions before starting |
| **On demand** | "what did we decide about X?" | Semantic search |
| **Cross-project** | Search across all projects | Connect ideas |

## Multi-Collection Architecture

Organizations get their own knowledge collections. Within an organization, all projects share one collection — your engine repo can recall a UX decision from your frontend repo.

Cross-org knowledge stays isolated at the storage level. An HQ-level agent (like the [Observer pattern](/guide/hq-pattern)) can query multiple collections in a single session, but the data never mixes in the database.

```
Org A Agent → reads/writes Collection A
Org B Agent → reads/writes Collection B
HQ Agent    → reads Collection A + B (writes to neither)
```

The knowledge network grows with every session. Nothing is lost.

## Implementation

DOSI is vector DB agnostic. The protocol defines the chunking and metadata strategy — the specific database is up to you:

- **Qdrant** — native gRPC clients for Go, Python, Rust, JS
- **Chroma** — Python-first, simple
- **Pinecone** — managed, serverless
- **LanceDB** — embedded, file-based

The key requirement: structured metadata filtering (by project, type, section, date).
