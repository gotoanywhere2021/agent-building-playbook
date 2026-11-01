---
title: Act Without Being Asked
one_liner: Wire the environment's events — chats, CI results, review comments, calendar — as first-class triggers with two-stage filtering, and let the agent advance work nobody asked for; deliver speculation only after its value is confirmed.
dimensions: orchestration, meta-principles
---

## What it is

The default agent waits to be invoked, so all the work that lives "between requests" never happens — the bug discussed in the team chat, the failing CI nobody re-triggered, the meeting invite nobody answered. The super-agent design inverts this: the agent continuously watches environmental events (group chats, email and calendar, code review comments, CI results) as first-class **Triggers**, filtered in two stages — programmatic rules first, LLM semantic judgment second ("does this need action?"). The sequence of triggers under one topic or one pull request forms a **Thread**, the unit of task state. Proactivity has two gears: reactive (respond to allowed triggers) and speculative (advance work on a hypothesis of value — on a meeting invite, pre-check calendar conflicts and draft a reply; on a bug report, attempt reproduction and a fix) — with delivery gated on confirmation: speculative results are handed over only after a simple fix is confirmed to exist, never as noise. Background completions re-enter the loop as events — long tool calls return "Started" immediately — keeping the agent continuous instead of request-bound.

## When to reach for it

- Shared team environments (repos, chat spaces) where valuable work is visible but unassigned — the agent can act without occupying anyone's attention budget.
- Monitoring duty: CI, inboxes, review queues, on-call signals that today wait for a human to notice.
- Personal assistant contexts with clear permission rails — the agent prepares, the human confirms.
- Reducing session juggling: one continuous agent advances many threads instead of a human switching between 3–5 active sessions.

## When NOT to

- Noisy, high-volume environments without filtering discipline — two-stage filtering is mandatory, or the agent becomes alert fatigue.
- Irreversible or high-stakes actions — proactivity decides *when to start*, never bypasses permission gates (`patterns/autonomy-when-justified.md`, `patterns/zero-standing-credentials.md`).
- When human attention is the scarce deliverable — interrupt only when judgment is genuinely the bottleneck (`patterns/earn-the-interruption.md`).

## Exemplars

- DeepSeek Harness 团队，《Super-agent 设计探索：迈向更自主的 Agent 系统》（官方公众号，2026-10-31；转载镜像） — https://tech.ifeng.com/c/8xg9tbvWnnf — the source: four traits (连续/高效/主动/持久), Trigger→Thread event model, two-stage filtering, speculative execution delivered only after confirmation, and the demonstrated case of fixing a bug in a group chat without being @-mentioned
- deepseek-ai/dsh-superagent-prototype — https://github.com/deepseek-ai/dsh-superagent-prototype — "take as little human attention as possible, and give as much value as possible": a proactive coding agent bound to one repository that listens to GitHub (and optionally Feishu), opens a work item on each request or team-written rule, and "speaks only when someone must act or can use a result"

## Related

- `patterns/workers-execute-router-speaks.md`
- `patterns/earn-the-interruption.md`
- `patterns/autonomy-when-justified.md`
- `patterns/deterministic-rails.md`
- `patterns/production-feedback-loop.md`
