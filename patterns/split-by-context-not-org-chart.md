---
title: Split by Context, Not by Org Chart
one_liner: Draw agent-system boundaries where context isolation pays — parallel fresh windows, bloat, conflicting tool needs, user-facing handoffs — never along team org charts or problem taxonomies; subagents that mirror departments produce the telephone game, sprawl, and the Frankenprompt.
dimensions: orchestration, human-factors
---

## What it is

When a system grows beyond one loop, the first question is where to cut. The default in large organizations is to cut along the org chart — one subagent per team, per product line, per problem type — and the result is predictable: agents that cannot see each other's context play the telephone game, fidelity decaying at every handoff; subagent sprawl accumulates hundreds of overlapping specialists with no owner; every team bolts its rules onto its slice until the prompts conflict (the "Frankenprompt"); and latency compounds because every hop is a nested model loop. Anthropic's enterprise deployments found the alternative repeatedly outperforms: split work by **context boundaries, not problem type** — merge tightly coupled specialists (chained outputs, shared data, frequently co-called) into one loop, and keep a subagent only where isolation itself pays: parallel tasks needing fresh disposable windows, measurable context bloat, conflicting tool needs, or an agent that must talk to the user directly. Skills carry each team's process knowledge into the shared loop, so ownership shifts from owning an agent to owning a skill — with one central team owning the system prompt and end-to-end evals.

## When to reach for it

- Designing a multi-agent system from scratch — draw the cut at context boundaries before anyone proposes a subagent per department.
- Inheriting an over-structured system: dozens of specialist subagents, inconsistent voice, rising latency, handoff bugs.
- A proposal says "give each team its own agent" — that is the org chart talking, not the context.
- Deciding keep-vs-fold for an existing subagent: keep only if isolation demonstrably pays (the four cases above); otherwise fold it in and let skills hold the knowledge.

## When NOT to

- Genuine context-isolation wins: parallel fan-outs with disposable fresh windows, tasks that measurably bloat the main loop, tool sets that conflict, user-facing handoffs — subagents stay right there (`patterns/subagents-as-context-sinks.md`, `patterns/parallel-independent-tracks.md`).
- Small systems that fit one loop — don't split at all (`patterns/single-threaded-default.md`, `patterns/start-least-agentic.md`).
- Regulatory silos that legally require separation — the boundary is then external and real; encode it, don't argue it away.

## Exemplars

- Diane Sarkis, "Building Agents: When to Fold Subagents Into Your Main Agent Loop" (Anthropic, Oct 2026) — https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop — the source: org-chart mirroring, telephone-game fidelity loss, "hundreds of overlapping subagents," the Frankenprompt, ~2x latency win on fold-in, the four keep-side criteria, and an eval-gated migration sequence (kit: github.com/anthropics/single-agent-loop-kit)
- Melvin Conway, "How Do Committees Invent?" (1968) — http://www.melconway.com/Home/Committees_Paper.html — the original law: system designs mirror organizational communication structures; this pattern is its agent-era restatement and escape
- Cemri et al., "Why Do Multi-Agent LLM Systems Fail?" (arXiv:2503.13657) — https://arxiv.org/abs/2503.13657 — independent evidence: inter-agent misalignment and system-design failures dominate the 14-mode taxonomy of multi-agent failures

## Related

- `patterns/single-threaded-default.md`
- `patterns/match-topology-to-the-work.md`
- `patterns/subagents-as-context-sinks.md`
- `patterns/self-ablating-harness.md`
- `patterns/skills-load-on-trigger.md`
- `patterns/share-full-context.md`
