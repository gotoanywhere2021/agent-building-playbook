---
title: A Shared Loop, Not a Supervisor
one_liner: Coordination capacity, not model capability, is what caps agent-team size — replace the central orchestrator with one identical collaboration loop per agent plus shared artifacts (repo, board, chat), and let members claim, negotiate, and merge work themselves.
dimensions: orchestration, meta-principles
---

## What it is

Hierarchical orchestration scales until the supervisor becomes the bottleneck: it must decompose, assign, track, and integrate everything, and its coordination budget saturates long before the workers do. The flat alternative encodes coordination as protocol instead of as a boss. Microsoft's Agensh experiment ran up to 1,024 same-model agents with no central orchestrator: every agent executes an identical asynchronous loop — gather context, claim a sub-task, act and share findings, verify, merge — over shared infrastructure (a git workspace, a message channel, and a typed context board of observed facts, failures, claims, and patch summaries). Overlapping claims get negotiated agent-to-agent; conflicts surface as merge problems, not dispatch decisions. Measured effects: on a from-scratch rebuild of pandoc, hidden-test pass rate rose from 33.89% (1 agent) to 50.94% (128) to 55.06% (1,024); on the five hardest ProgramBench tasks, 19.31% to 28.78% (1 → 128); larger teams also hit milestones faster (128 agents reached the 30% mark in ~30 minutes versus ~90 for 32, never for 1). Roles — interface negotiators, peer reviewers, integrators — emerged from the loop rather than being assigned.

## When to reach for it

- Large, decomposable build or rebuild work with mechanically verifiable acceptance (hidden tests, build gates) — the regime where claims and merges can be adjudicated by artifacts.
- You have measured that supervisor throughput, not worker capability, is the scaling bottleneck.
- Exploring organization size as a capability variable: the same model at team sizes 1 → 128 → 1024 behaves like a different system.
- You want emergent specialization — reviewers and integrators self-selecting — instead of hand-designed role taxonomies.

## When NOT to

- Default first: for most work the least-agentic, single-threaded option remains correct — fan-out needs a concrete, measured reason (`patterns/single-threaded-default.md`).
- Tight coupling, shared invariants, or continuous global reasoning — conflicting implicit decisions carry bad results; parallel swarm makes that worse, not better.
- Returns diminish fast: 128 → 1,024 agents bought only +4.12 points in the experiment — price the marginal agent against the actual delta before scaling (`patterns/delegation-token-economics.md`).
- Accountability and cost matter: "who answers for this result" is unanswered in a bossless swarm, and resource cost per point gained was not tracked — regulated and production-shared-state systems should not adopt this on demo evidence.
- Self-organization still sits on preset conditions: the loop, the claim protocol, the verification requirement, and the tooling were given. You still design the constitution; the agents only fill the org chart.

## Exemplars

- Zhan et al., "Agensh: Scaling Organizational Intelligence to 1,024 Agents" (Microsoft Research, arXiv:2609.26781) — https://arxiv.org/html/2609.26781v1 — the primary source: no central orchestrator, one five-step loop per agent, shared workspace/chat/context board, emergent roles at n=8/32/128/1024
- Datawhale / 数据派THU zh analysis — https://mp.weixin.qq.com/s/vlthjY1ftpBd-HaaKkxf6w — accessible Chinese walk-through of the experiment design, scaling numbers, and caveats (diminishing returns, unmeasured cost, accountability gap)

## Related

- `patterns/single-threaded-default.md`
- `patterns/match-topology-to-the-work.md`
- `patterns/agents-are-distributed-systems.md`
- `patterns/supervise-many-agents.md`
- `patterns/delegation-token-economics.md`
