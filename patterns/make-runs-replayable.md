---
title: Make Runs Replayable
one_liner: Capture a run as an append-only, canonicalized event log so the same events always rebuild the same state — then any later change is a diff against a recorded run, not a fresh act of faith.
dimensions: verification, observability
---

## What it is

Most agent runs are vapor: they happen once, in a specific context, and what remains is a chat transcript nobody can execute again. A replayable run is different — its decisive steps are recorded as typed, ordered events with stable identifiers and canonical formatting (sorted keys, normalized timestamps, hash chains), and the state at any point is a pure function of the event log. Two properties follow. First, *reconstruction*: append-only logs rebuild current state field-for-field — if the rebuild disagrees with what is deployed, something was edited by hand, and you want to know that. Second, *comparison*: because replays are deterministic within a controlled environment, you can run the old events through the new logic and diff the outputs — golden-master testing applied to agent behavior. The engineering discipline lives in the boundaries: determinism applies to committed events, not to model prose (the model is not deterministic; the ledger is); environment differences — locale, clock, external services — are normalized or declared; and captures are bounded so the record stays reviewable. FDE Gym rebuilds any session byte-stably from its hash-chained JSONL event log; ai-deals-aggregator rebuilds derived data twice and requires byte-identical output; REA records deterministic captures so a later change can be diffed against recorded behavior instead of re-argued from memory.

## When to reach for it

- When you must prove a behavior change didn't change anything else: replay recorded events through the modified pipeline and diff; "no diff" is evidence, not a claim.
- When long-running or multi-agent work must be recoverable: a hash-chained event log with idempotent commands survives crashes and lets a new process resume exactly where the old one stopped.
- When agent decisions get audited after the fact: the log is the audit trail — committed judgments can be reconstructed without trusting anyone's memory of the run.
- When building training or eval harnesses: deterministic replay is what makes a practice run gradeable, retryable, and fair across attempts.

## When NOT to

- When the work is exploratory and each run is disposable: replay infrastructure is a tax on output that will never be compared.
- When you cannot control the environment: a "replay" that depends on live external services is a re-run with extra steps — normalize or record those boundaries first.
- When full determinism is impossible: capture what is stable (inputs, commands, committed decisions) and mark the rest as observational — a partially replayable record beats none, if its limits are stated.

## Exemplars

- FDE Gym — https://github.com/flingjie/FDE-Gym — first-party of the pattern: append-only JSONL event logs with SHA-256 hash chains, write-ahead journals for crash recovery, per-command idempotency, and byte-stable replay within a locale — same committed events, same rebuilt state
- ai-deals-aggregator — https://github.com/buguoshixc/ai-deals-aggregator — reproducibility gates: derived JSON must be byte-identical to source-layer output, feeds and plans are rebuilt twice and compared, and append-only history logs must reconstruct current data field-for-field
- REA (Reverse Engineer Anything) — https://github.com/morluto/rea — deterministic, bounded captures of app and process behavior with declared normalization, so a later change is compared against the recorded run; comparisons fail toward "unknown" rather than claiming equivalence from partial evidence
- Martin Fowler, "Event Sourcing" — https://martinfowler.com/eaaDev/EventSourcing.html — classic antecedent: application state as a replayable sequence of events, with reconstruction, temporal queries, and audit

- Ephemeral-AI-Lab/layerfs — https://github.com/Ephemeral-AI-Lab/layerfs — the append-only principle applied to the filesystem: every tool call commits its delta into a content-addressed store that "only grows," so "what did the agent change at step N" is a diff against recorded state, not an investigation
## Related

- `patterns/emit-events.md`
- `patterns/auditable-artifacts.md`
- `patterns/session-archaeology.md`
- `patterns/test-what-not-how.md`
