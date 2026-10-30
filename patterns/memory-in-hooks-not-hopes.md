---
title: Capture Memory in Hooks, Not in Hopes
one_liner: Memory that depends on someone remembering to save it loses exactly what matters — wire capture into lifecycle hooks (session start/end, tool use) so remembering becomes an automatic side effect of working, and price retrieval in layers.
dimensions: context-engineering, observability
---

## What it is

Discipline-based memory ("write your notes at the end") fails precisely when it matters: the session ends abruptly, context compaction eats the middle, the crash loses the tail. The robust design makes capture an infrastructure side effect: hooks at lifecycle boundaries — session start, prompt submit, tool use, session end — write observations to durable storage without any agent or human choosing to. Retrieval is the other half: re-inject relevant context automatically at session start, and expose layered search priced in tokens — a compact index (~50–100 tokens per result), a chronological timeline, then full details only for chosen IDs — so filtering before fetching saves an order of magnitude of context. Keep a privacy channel from day one: an exclusion marker (a `<private>` tag) that removes sensitive content before it ever hits storage, because auto-capture without exclusion design creates retention liabilities.

## When to reach for it

- Multi-session or multi-harness agent work where continuity across restarts, compactions, and tool boundaries matters.
- Incident archaeology: you need what the agent actually did, not what it remembers doing (`patterns/session-archaeology.md`).
- Feeding a distillation pipeline: hook-captured observations are the raw stock that `patterns/memory-into-skills.md` promotes into skills.

## When NOT to

- One-shot sessions with no future reader — capture infrastructure is pure overhead.
- Regulated or privacy-sensitive contexts without an exclusion design — auto-capture is a retention liability until `<private>`-style channels exist.
- As a substitute for distillation — a growing observation pile is storage, not knowledge; hooks feed the pipeline, skills are its product (`patterns/mine-transcripts.md`).

## Exemplars

- thedotmack/claude-mem — https://github.com/thedotmack/claude-mem — hooks on SessionStart/UserPromptSubmit/PreToolUse/PostToolUse/Stop/SessionEnd write observations to SQLite + a vector store; layered retrieval (search ~50–100 tokens/result → timeline → full details ~500–1,000 tokens) claims ~10x token savings by filtering before fetching; `<private>` tags exclude sensitive content from storage
- Anthropic, "Effective Context Engineering for AI Agents" — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — the compaction-and-notes frame this pattern automates: what to keep across boundary events is a design decision, not a habit

## Related

- `patterns/long-horizon-memory.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/memory-into-skills.md`
- `patterns/mine-transcripts.md`
- `patterns/scope-and-expire-memory.md`
