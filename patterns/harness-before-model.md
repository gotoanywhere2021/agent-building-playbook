---
title: Blame the Harness Before the Model
one_liner: When an agent underperforms, audit the surrounding harness — context assembly, tool contracts, retrieval, and scoring — before swapping models or rewriting prompts; the harness usually has more headroom and fewer regressions.
dimensions: reliability, meta-principles
---

## What it is

"Your agent didn't fail — your harness did." The model proposes; the harness owns everything around the proposal: what enters the context window, how tools present their results, how state and permissions are committed, how outputs are scored, and what happens on failure. Most production agent failures trace to defects in that periphery — stale context, ambiguous tool contracts, broken retrieval, judges rewarding the wrong thing — not to missing model capability. Swapping models is expensive and regressive; fixing the harness compounds, because the same improved harness makes the next, better model better too.

## When to reach for it

- An agent fails or plateaus and the team's first instinct is "try the newer model."
- Eval scores look noisy or strange — suspect the scoring harness before the outputs.
- Behavior differs between environments that "should" be identical — context assembly or tool state is drifting.
- You are about to rewrite a prompt wholesale — check whether the harness fed it bad inputs.

## When NOT to

- After a minimal repro shows the model genuinely cannot do the task class — no harness fixes a missing capability.
- Regulated deployments that mandate a specific model — fix the harness anyway, but expect the ceiling the model sets.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1e9MR6PEjz — "Your Agent Didn't Fail, Your Harness Did" (OpenAI): most agent failures originate in the surrounding system — model proposes, harness owns state, permissions, and proof of results
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1DfMe6uEQZ — "What if the Harness Mattered More Than the Model": argues reliability comes from the control system around the engine, not the engine's horsepower
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV15rL86DEi8 — "Harnesses in AI: A Deep Dive": systematic tour of what a harness must own — context, tools, evaluation, recovery

## Related

- `patterns/invest-the-expensive-model-in-the-harness.md`
- `patterns/fail-loud-harnesses.md`
- `patterns/hill-climb-dont-rewrite.md`
- `patterns/deterministic-rails.md`
