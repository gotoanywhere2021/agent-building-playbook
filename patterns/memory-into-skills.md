---
title: Distill Memory Into Skills
one_liner: Memory that only remembers is a growing liability — periodically distill recurring wins and fixes from agent memory into named, versioned, eval-gated skills, then let the raw memory expire.
dimensions: knowledge, workflow-discipline
---

## What it is

Agent memory accumulates session notes, fixes, and preferences. Left alone it bloats, contradicts itself, and poisons context (see `patterns/scope-and-expire-memory.md`). The higher-value move is promotion, not accumulation: when the same fix, workflow, or judgment keeps recurring, distill it into a skill — a small, named, versioned process document that loads on trigger — and demote the raw history to expiring memory. Self-improving agent teams take this further: let the agent draft its own skills from its session history, then gate promotion behind evals and review. Memory records what happened once; skills make it happen on purpose.

## When to reach for it

- The same fix or handling keeps reappearing across sessions and notes files keep growing.
- Onboarding or environment knowledge gets re-explained to the agent every week.
- Building a continual-learning loop: failure → note → skill → eval → default behavior.
- A skill library exists but nobody trusts what's in it — add the eval gate before promotion.

## When NOT to

- One-off tasks — distillation has fixed costs that only recurring behavior amortizes.
- Volatile domains where distilled skills go stale faster than they pay off — prefer scoped, expiring memory.
- No eval exists to gate the promotion — build the eval first, or the skill canonizes a bad habit.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1Gzpq6DE77 — "Turning Agent Memory Into Skills That Work": the memory → skill promotion pipeline in practice
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1jVpB6tEEJ — "From 36 to 100: How a Self-Improving Agent Writes Its Own Skills": an agent that drafts, tests, and adopts its own skills, measured score 36 → 100
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1NBNh6jEX9 — "Don't Ship Skills Without Evals": why ungraded skills are unverified behavior changes
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1W97L6PEZS — "Turn Notes Into Memory" (Hugging Face): structuring raw notes into retrievable agent memory as the input side of distillation
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1exuA6sE5C — "We Vetted 2,000 AI Skills Before They Reached Developers": what a review gate over a large skill corpus catches

## Related

- `patterns/skills-load-on-trigger.md`
- `patterns/scope-and-expire-memory.md`
- `patterns/long-horizon-memory.md`
- `patterns/self-modifying-context-needs-review.md`
