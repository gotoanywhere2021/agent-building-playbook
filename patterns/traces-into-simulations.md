---
title: Turn Production Traces Into Simulations
one_liner: Recorded agent traces are eval assets — replay them as regression scenarios, mutate them into adversarial variants, and simulate the environment so candidates can be graded safely before touching production.
dimensions: verification, observability
---

## What it is

Every production run is a recorded experiment you never have to pay for twice. Transform traces into three things: replayable regression scenarios (same input, assert same-or-better behavior), adversarial variants (perturb inputs, inject tool failures, shift distributions), and environment simulations that stand in for production — real interfaces, real tools, validator-checked outcomes. Teams that lean on simulation ("simulation-maxxing") ship faster because every candidate is graded against production-shaped environments instead of public benchmarks, and risky changes iterate without production exposure. Simulation accelerates; it does not replace — reality always gets the final word.

## When to reach for it

- The agent runs in production and you need regression protection for every change.
- Bugs or successes you want to reproduce are rare, expensive, or unsafe to recreate live.
- Public benchmarks don't cover your domain — build a private benchmark from your own traffic.
- You need to test failure handling (tool outages, malformed responses) that you can't trigger in production on purpose.

## When NOT to

- Cold start with no traces — instrument and record first (`patterns/emit-events.md`, `patterns/make-runs-replayable.md`).
- When the simulation becomes the only gate — distribution shift silently voids simulated guarantees (`patterns/safety-guarantees-dont-transfer.md`, `patterns/real-environment-execution.md`).

## Exemplars

- Snorkel AI on AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1L23T65EDw — "From Agent Traces to Agent Simulations": building private benchmarks from real interfaces and flows, with validators and expert review loops
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1KMMd69Eeb — "Simulation-Maxxing: How Nubank Ships Agents Faster": simulation-first deployment pipelines at a large bank
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1oTgq6bEDx — "VendingBench: Long-Horizon Agent Evals": what long-horizon benchmark environments reveal that short ones miss

## Related

- `patterns/make-runs-replayable.md`
- `patterns/standing-eval-capability.md`
- `patterns/real-environment-execution.md`
- `patterns/session-archaeology.md`
