---
title: Calibrate the Judge Before Trusting the Score
one_liner: An LLM judge inherits the biases of the models it grades — anchor it to known-good and known-bad cases, prefer deterministic checks first, and monitor the judge itself for drift.
dimensions: verification, reliability
---

## What it is

LLM-as-judge scales human-like grading, and it lies confidently: self-preference for its own model family's style, sycophancy toward plausible output, length bias, and rubric drift across versions. Treat judge scores as readings from a biased instrument that must be calibrated before use. Deterministic verifiers — tests, parsers, schema checks, simulations — come first because they cannot be sweet-talked; LLM judges fill only the space mechanical checks cannot reach. A calibrated judge has: a fixed rubric, a calibration set of agreed good and bad outputs it demonstrably separates, tracked agreement over time, and ideally more than one independent judge for contested calls.

## When to reach for it

- Auto-grading agent outputs in eval suites or CI quality gates.
- Using model scores as the reward signal in self-improvement or optimization loops — an uncalibrated judge optimizes toward its own biases.
- Comparing candidate prompts, skills, or models where small deltas must be real.

## When NOT to

- Deterministic checks fully cover the property you care about — don't grade what you can assert.
- Volumes are small enough that a human reads every output anyway — spend the effort on rubric-writing for humans.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1j9p76zEUr — "Your LLM Judge Is a Confident Liar: Build Better Verifiers": failure modes of uncalibrated LLM graders and stronger verifier designs
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1ftKs6QEpW — "In the Land of AI Agents, the Verifiers Are King": verification quality as the binding constraint on agentic systems
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1pXKr66Eg7 — "Build Evals That Actually Matter": grounding eval design in real value rather than leaderboard theater
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1win26oEyU — "Evaluating High-Risk AI Agents with Phoenix and Claude": tracing and grading pipelines where judge behavior is observable

## Related

- `patterns/eval-driven-development.md`
- `patterns/standing-eval-capability.md`
- `patterns/adversarial-parallel-review.md`
- `patterns/critic-applications.md`
