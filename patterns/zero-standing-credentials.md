---
title: Agents Hold Zero Standing Credentials
one_liner: Don't give agents persistent secrets — broker short-lived, narrowly scoped, audited access per action, so a compromised or confused agent exposes minutes of scope instead of your whole system.
dimensions: security, tool-design
---

## What it is

An agent that holds a standing API key, database password, or OAuth token is one prompt injection or context-poisoning event away from mass exfiltration. Invert the trust model: the agent holds no secrets at all. For every sensitive action it calls a broker — a proxy, gateway, or approval service — which authenticates the workload, issues a grant scoped to that single operation, stamps an auditable receipt, and expires the grant immediately. Humans keep root authority; agents carry delegable, revocable, per-action proofs. The question "how many credentials should your agent have?" has a production-tested answer: zero.

## When to reach for it

- Any agent that touches databases, cloud accounts, payment systems, or third-party APIs.
- Platforms running other people's agents in multi-tenant environments.
- Agents acting on behalf of end users against user-scoped resources.
- Any agent that reads untrusted content while holding any form of access — injection turns reading into acting.

## When NOT to

- Throwaway local prototypes where the "credentials" are your own already-exposed dev environment — still prefer scoping, but the threat model is smaller.
- Fully offline evaluation over synthetic data with no external reach.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV179p76zEMD — "How Many Credentials Should Your AI Agent Have? Zero": the case for brokering every privileged action instead of handing agents secrets
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1MBJ26aEAq — "How AI Agents Leak Secrets, and How to Stop It": concrete exfiltration paths for over-credentialed agents and mitigations
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1dzg66PE6m — "Better Agent Auth": identity and delegation patterns designed for agents rather than reused human login flows

## Related

- `patterns/sandbox-by-default.md`
- `patterns/guardrails-and-escalation.md`
- `patterns/governance-is-infrastructure.md`
- `patterns/proposer-authority-separation.md`
