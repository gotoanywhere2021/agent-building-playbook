---
title: Agents Are Distributed Systems
one_liner: A multi-step agent is a distributed system — partial failure, lost responses, retries, and drift are normal — so apply the classic discipline: idempotency, timeouts, scoped permissions, checkpoints, and observability, instead of agent magic.
dimensions: meta-principles, orchestration
---

## What it is

Once an agent calls tools, talks over networks, and mutates external state, it inherits every distributed-systems failure mode: the tool call times out after committing, the retry double-charges, the run dies at step 9 of 12, memory drifts from the authority of record. Treat it as what it is. Each tool call is a fallible remote call — give it idempotency keys and request IDs. Control flow around model judgment stays deterministic. Permissions are scoped and revocable. Every step persists so runs recover instead of restarting. Circuit breakers, budget limits, and rate limits stop retry storms. Memory is a cache with an explicit source of truth. None of this is exotic — it is the discipline engineering already learned, applied to a new kind of caller.

## When to reach for it

- Any agent doing side-effecting work: writes, purchases, deployments, external API calls.
- Multi-agent topologies where one agent's output is another's input.
- Long-running pipelines that must survive interruptions and resume.
- Post-incident reviews where "the agent behaved weirdly" needs a precise mechanism, not a shrug.

## When NOT to

- A single well-crafted LLM call with no external state — the discipline is overhead there (`patterns/start-least-agentic.md`).
- Pure computation over local files where all state is process-local and cheap to redo.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1i3tU6TEeb — "AI Agents Are Just Distributed Systems Now": idempotency keys, scoped permissions, compensation, circuit breakers, and cache-with-authority memory for agents
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1o3tU6TEbE — "Agents Are Where Microservices Were in 2015": the operational maturity curve agents will follow, and what early adopters should steal now
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV178gS6AEke — "Why We Killed Our Multi-Agent Pipeline": a post-mortem where missing distributed-systems discipline, not model quality, sank the project

## Related

- `patterns/three-primitives.md`
- `patterns/deterministic-rails.md`
- `patterns/make-runs-replayable.md`
- `patterns/workflows-vs-agents.md`
