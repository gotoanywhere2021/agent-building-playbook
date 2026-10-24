---
title: Instrument the Context Window
one_liner: You cannot govern a context you cannot see — before optimizing prompts, memory, or retrieval, measure what is actually in the window: its composition, its breakdown by source, and how it evolves turn by turn.
dimensions: context-engineering, observability
---

## What it is

Context engineering advice — compress, select, isolate, retrieve just-in-time — is prescription without diagnosis. The diagnosis requires seeing the patient: what fraction of the window is system prompt, tool schemas, retrieved documents, tool results, the model's own earlier outputs; how each component grows as the session runs; which component crossed its budget first and pushed out the useful material. Most teams tune context by intuition — trim a prompt here, add a memory there — and cannot tell whether the change moved the number that mattered. Instrumentation makes the window measurable: a context dashboard that reports composition (tokens by source), breakdown (which files, which tool definitions, which messages), and evolution (how the mix shifts over the session, especially across compaction events). The surprising findings are the point: tool schemas routinely dominate the budget; a single pasted file can outweigh the entire system prompt; post-compaction context loses material nobody noticed until the dashboard showed the cliff. dsh-context — a plugin that gives an agent harness a context dashboard, browser, and statistics — exists because even the engineers running the harness were operating blind on what their own context contained.

## When to reach for it

- When context costs are high or sessions die early: before buying a bigger window or writing a clever compressor, find out what is actually spending the budget.
- When agent quality degrades in long sessions: degradation is usually a context composition problem — stale tool results, growing transcripts, lost instructions — and the dashboard shows which.
- When designing or selecting tools: schema size is a choice; measure each tool's share of the always-loaded budget before adding the next one.
- When tuning compaction or memory policies: you need before/after composition to know whether the policy preserved what mattered.

## When NOT to

- When sessions are short and prompts simple: a ten-turn chat with two tools is fully visible by inspection; instrumentation is overhead without a mystery.
- When the instrumentation itself feeds back into context: a dashboard that reports into the same window it measures changes the thing it measures; report out-of-band.
- When you already know the answer and the fix: if profiling would just confirm "the transcript is too long, add compaction," do that and measure after.

## Exemplars

- dsh-context — https://github.com/bowenliang123/dsh-context — first-party of the pattern: a DeepSeek Harness plugin providing a context dashboard, sidebar, and browser with context statistics, composition, breakdown, and evolution details — built to answer "how is the context made of" before optimizing it
- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — Effective Context Engineering for AI Agents: treats context as a finite resource with a budget to be curated; measuring what occupies the window is the precondition its recommendations assume
- Langfuse — https://langfuse.com/docs — LLM observability platforms render per-call prompt composition and token accounting; the hosted version of the dashboard this pattern describes

## Related

- `patterns/context-is-finite.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/awareness-layer.md`
