---
title: Hill-Climb the Harness, Don't Rewrite It
one_liner: Improve agents by many small, measured deltas against a fixed eval suite — accept only score-positive changes and mine every failure into a new eval case — not by speculative rewrites.
dimensions: verification, workflow-discipline
---

## What it is

Agent improvement is an optimization problem, not an essay rewrite. Hill climbing: run the eval suite, change one thing (a prompt clause, a tool description, a retrieval parameter), re-run, keep the change only if the score rises, revert if it doesn't. The discipline kills the two dominant failure modes of agent iteration — vibes-based rewrites that silently regress, and changes nobody can attribute. Reflection-based methods (GEPA-style) show models can propose these deltas themselves by reading their own failure traces. The compounding side effect: every mined failure becomes a permanent eval case, so the suite grows exactly where the system is weakest — improving agents is, at bottom, a data-mining problem.

## When to reach for it

- Iterating prompts, skills, tool descriptions, or harness parameters with any regularity.
- An agent has plateaued and opinions about "what to change" are diverging.
- A regression appeared after a "clearly better" change — reconstruct which delta caused it.
- Building self-improvement loops where the agent proposes its own changes.

## When NOT to

- The harness architecture is wrong — no number of one-line deltas fixes a structural mismatch; restructure, then resume hill climbing.
- No eval suite exists yet — build it first (`patterns/eval-driven-development.md`), or you are hill-climbing in the fog.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV16GJ26JErf — "Hill-Climbing Skills: Improving Agents Without Changing the Model": empirical iteration on skills as the primary improvement lever
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1Xaaf6MEv7 — "Beating RL With Reflection: GEPA and Optimizing Everything": reflective prompt optimization as measured hill climbing
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV136by6REo9 — "Improving Agents Is a Data-Mining Problem": mining production failures into eval cases and improvements
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1Mdpu6KE9T — "From Blind Spots to Merged PRs: Continuous Agent Performance Optimization": a standing loop that converts blind spots into score-positive merges

## Related

- `patterns/eval-driven-development.md`
- `patterns/calibrate-the-judge.md`
- `patterns/harness-before-model.md`
- `patterns/rebuild-often.md`
