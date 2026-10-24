---
title: Drive the Structured Surface, Not the Screen
one_liner: Before an agent pokes a UI pixel by pixel, go one layer down — DOM/HTML, an API, an MCP server, a CLI — because structured surfaces are deterministic and verifiable where screen-poking is ambiguous and drift-prone.
dimensions: tool-design, reliability
---

## What it is

Computer-use agents inherit the full ambiguity of pixels: layout drift, async loading, occlusion, and near-miss clicks — which is why "99% accurate" browser agents still fail in production; the long tail is the job. Before reaching for screen-poking, look one layer down: HTML/DOM the agent can parse natively, a REST/GraphQL API, an MCP server, a CLI. Structured surfaces are deterministic, cheap to verify, and immune to visual redesigns. Reserve UI automation for surfaces you neither own nor can introspect — and there, wrap every step in verification (assert post-conditions, diff screenshots, retry with backoff) instead of trusting the click. When you own the product, expose the structured surface deliberately.

## When to reach for it

- Browser automation or computer-use tasks where any structured access exists.
- Integrating agents with SaaS products — check for APIs, MCP servers, or export surfaces first.
- Designing your own product's agent interface — an agent-native surface beats simulating a human.
- A UI automation pipeline keeps breaking on cosmetic changes.

## When NOT to

- Genuinely visual judgment (design review, visual QA) — pixels are the subject.
- A closed UI with no structured access is truly the only surface — automate it with per-step verification and checkpoints, and treat fragility as a cost line.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1fMKv6LE2Y — "HTML Is All Agents Need" (HeyGen): LLMs are natively fluent in HTML/CSS — rendering structured output beat pixel-level generation for video creation
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1vHH163Ebv — "Why 99% Accurate Browser Agents Still Fail": the compounding long tail of UI automation and how verification closes the gap
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1gAbd6SE7d — "Computer Use at the Edge of the Statistical Cliff": where pixel-level agents break and structured alternatives win
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1RMbz63EmJ — "The Dark Arts of Web Automation: Teaching Agents to Use Sites Like Humans": hard-won techniques for when only the UI exists

## Related

- `patterns/tools-for-agents.md`
- `patterns/namespace-tools.md`
- `patterns/critic-applications.md`
- `patterns/self-verification.md`
