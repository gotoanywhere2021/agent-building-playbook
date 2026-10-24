---
title: Declare Outcomes, Not Procedures
one_liner: Tell the agent what result must hold true, not the steps to take — declarative contracts let capable models plan their own route, while procedural scripts written for yesterday's models constrain today's and rot as models improve.
dimensions: meta-principles, context-engineering
---

## What it is

Stop telling agents how. A procedural instruction — "step 1 run X, step 2 edit Y, step 3 call Z" — encodes one route through the problem, written for the capability level of some past model. Capable models plan better routes than the ones you scripted, procedural scripts consume context budget restating what the model already knows, and they silently rot as models improve. The declarative alternative states the outcome as a contract: the result that must hold true, the constraints that bound it, and the verification that proves it. The agent decides how. Declarative specs are also auditable — a contract is checkable, while a procedure is only followable.

## When to reach for it

- Driving capable frontier models on tasks you would otherwise micromanage step by step.
- Repeatable, auditable workflows where the contract can be verified mechanically.
- Instructions that keep needing patches every time the model or the environment changes.
- Encoding team processes so agents can satisfy them — declare the acceptance condition, not the choreography.

## When NOT to

- The exact procedure is the requirement — compliance, financial operations, irreversible production changes. Encode those as deterministic rails, not prose (`patterns/deterministic-rails.md`).
- Weaker or specialized models where your scaffolding was load-bearing — migrate incrementally and ablate as capability rises (`patterns/self-ablating-harness.md`).

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1Nvn26tETp — "Stop Telling Agents How" (OpenProse): a Markdown-native, event-driven agent language built on declarative contracts — declare the outcome, the agent decides the how
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1cpa66aEnR — "Get Out of the Model's Way": over-instruction as a tax on capable models
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1L2uB6ZEkQ — "Guide, Verify, Solve": the working middle ground — steer loosely, verify mechanically, intervene on failure

## Related

- `patterns/context-over-prompt.md`
- `patterns/state-the-target.md`
- `patterns/self-ablating-harness.md`
- `patterns/deterministic-rails.md`
