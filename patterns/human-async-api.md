---
title: Treat the Human as an Async API
one_liner: Long-running agent pipelines that block on a human being available stall by design — model the human as an asynchronous interface with durable requests, signals, and wait-conditions, so work continues and answers arrive as events.
dimensions: human-factors, orchestration
---

## What it is

Agents that need human input usually stop and wait — blocking a pipeline on someone's calendar. The async-API inversion treats the human as just another service with latency and availability limits: the workflow submits a durable request (a question, an approval, a correction), records its state, continues other work, and resumes when the response arrives as a signal. Wait-conditions, not modal prompts. Escalation urgency is priced by the cost of getting it wrong — and alert fatigue is a real failure mode, so most human touchpoints should be batched, queued review work rather than live interruptions.

## When to reach for it

- Long-running workflows with approvals, corrections, or domain questions embedded mid-flight.
- Human availability is far below pipeline availability (nights, weekends, one reviewer for many runs).
- Multi-agent systems where several runs need the same scarce human judgment.
- Recovery matters: the workflow must survive restarts while a human answer is pending.

## When NOT to

- Truly synchronous collaboration — pair programming, live steering — where the conversation is the product.
- Trivial confirmations whose answer is predictable — ask the eval, not the human.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1aDpu6zEoP — "The Human Is an Async API": Temporal-based delivery agents where humans intervene via wait-conditions and signals — no blocking, durable across outages, escalation priced by error cost
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1v2uB6ZEQF — "Always-On Agents Run Production Without the On-Call Burden": standing agents whose human touchpoints are async queues, not pagers

## Related

- `patterns/earn-the-interruption.md`
- `patterns/supervise-many-agents.md`
- `patterns/agents-are-distributed-systems.md`
- `patterns/attention-is-the-scarce-resource.md`
