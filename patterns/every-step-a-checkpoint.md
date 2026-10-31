---
title: Every Step a Checkpoint; the Workspace Stays Ephemeral
one_liner: Git commits are agent-optional, so stop depending on them — put a versioned substrate beneath the workspace that commits each tool call automatically into an append-only, content-addressed store, and let the workspace itself be a disposable view.
dimensions: reliability, observability
---

## What it is

Agents don't run `git commit` — so the unit of recoverable state ends up being whatever the agent happened to leave behind. Invert the layering: give each agent a copy-on-write workspace mounted over committed history, and commit its delta automatically after every tool call into an append-only, content-addressed store. Three properties fall out. Rollback becomes free — every step is a checkpoint to return to, no agent cooperation required. Branching becomes cheap — a second agent forks any commit without copying the base, and same-file conflicts are *refused* rather than silently resolved unless an explicit last-write-wins policy says otherwise. Audit becomes structural — the store only grows, saved objects are never rewritten, so "what exactly did the agent do to these files" is a diff, not an investigation. Deduplication makes it practical: edits cost the size of the change, not the size of the file, so hundreds of checkpoints of a real project compress to megabytes.

## When to reach for it

- Long autonomous runs where "rewind to step N" must be possible without the agent having committed.
- Multiple agents working one tree in parallel — fork cheaply, merge deliberately, refuse silent overwrites (`patterns/worktree-per-parallel-session.md` for the session-level variant).
- Audit and incident archaeology over file state: prove what changed at each step, not just at merge time.
- Expensive-to-reproduce environments where "just rerun it" is the costly answer.

## When NOT to

- Disposable one-shot sandboxes with no future reader — plain scratch space is cheaper.
- Sequential-write or huge-binary workloads where copy-on-write overhead dominates the benefit.
- As the sole copy of unrecoverable data while the store lacks crash durability — some implementations are explicit that the store survives the session, not a power loss; keep real backups outside.

## Exemplars

- Ephemeral-AI-Lab/layerfs — https://github.com/Ephemeral-AI-Lab/layerfs — the pattern as infrastructure: FUSE workspaces over a single-file SQLite store; per-tool-call commits; content chunking that held 157 snapshots of a 4.94 GB tree in ~100 MB (19.9× smaller than Btrfs + zstd); conflict refusal with opt-in `.lww`; honest limits documented (no crash durability in disposable profile, no FIFOs/sockets/device nodes)
- tobi/try — https://github.com/tobi/try — the same idea at shell scale: run any command against a snapshot-backed view and commit or discard afterwards; prior art for "the workspace is a view, history is the product"

## Related

- `patterns/worktree-per-parallel-session.md`
- `patterns/make-runs-replayable.md`
- `patterns/sandbox-by-default.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/agents-are-distributed-systems.md`
