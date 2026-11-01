---
title: Workers Execute; the Router Speaks
one_liner: In a router/worker system one mouth keeps the voice coherent — the router owns all human interaction and global context, workers run in isolated sessions and report status, and threads (one topic or one PR) — not chat sessions — are the unit of work.
dimensions: orchestration, human-factors
---

## What it is

When work grows past one loop, the communication topology decides whether the system stays coherent. The router/worker answer: the **Router** handles all human interaction, maintains global context, and dispatches; **Workers** execute concrete tasks in mutually isolated sessions and report status and results back — they never reply to users directly. The task unit is the **Thread**: the sequence of triggers under one IM topic or one pull request, which workers can subscribe to directly so related events bypass the router under load. Long tool calls become asynchronous — start/stop with an immediate "Started" — and their results re-enter as events, so the router stays responsive while work runs. Under stress the design amortizes well: raising trigger load from ~1 to ~40/minute grew average batch size 1.0→2.8 and per-request latency 2.5s→3.9s while per-decision inference cost *dropped* 6.4s→1.6s — batching the backlog improves throughput. The motivation is human, not machine: a person can only follow 3–5 active sessions, and one persistent agent advancing many threads beats a human juggling parallel chats.

## When to reach for it

- Assistant-style systems where a human is the audience and one coherent voice matters — specialists with conflicting prompts are the failure to avoid.
- Multi-worker repos or teams with mixed event streams (issues, PRs, chats, CI) that would otherwise become N parallel sessions to babysit.
- When session-switching is the measured bottleneck, not model capability.

## When NOT to

- Bossless swarms over mechanically verifiable work — where claims and merges adjudicate themselves, a router is a bottleneck, not a benefit (`patterns/shared-loop-not-supervisor.md`).
- Work that fits one loop — don't build two tiers for one agent's job (`patterns/start-least-agentic.md`).
- A worker that must talk to the user directly — the one case that justifies a full handoff (`patterns/split-by-context-not-org-chart.md`).

## Exemplars

- DeepSeek Harness 团队，《Super-agent 设计探索：迈向更自主的 Agent 系统》（官方公众号，2026-10-31；转载镜像） — https://tech.ifeng.com/c/8xg9tbvWnnf — the source: Router 承接人类交互并分派，Worker 在隔离会话中并发执行且不直接回复用户；Thread = 一个 IM 话题或一个 PR 的触发序列；压测数据（批处理摊薄单次推理 6.4s→1.6s）
- deepseek-ai/dsh-superagent-prototype — https://github.com/deepseek-ai/dsh-superagent-prototype — the prototype shape: a web panel "shows what needs a person," the agent "replies in the original conversation" (e.g., with a PR) — a router-owned surface, one voice per thread

## Related

- `patterns/act-without-being-asked.md`
- `patterns/split-by-context-not-org-chart.md`
- `patterns/shared-loop-not-supervisor.md`
- `patterns/supervise-many-agents.md`
- `patterns/match-agent-metaphor-to-layer.md`
