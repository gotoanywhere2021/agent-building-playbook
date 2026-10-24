---
title: Safety Guarantees Don't Transfer
one_liner: Constraints satisfied in the training environment are not constraints in the deployment environment — distribution shift silently voids safety guarantees, so re-verify safety under shift and keep a runtime shield as the last line of defense.
dimensions: reliability, verification
---

## What it is

A safety property demonstrated during training is a statement about that distribution, not about the system. The evidence is uncomfortable and now empirical: benchmarking eight safe RL algorithms on a unified clinical simulator (insulin dosing for diabetes, across three diabetes types and three age groups), policies that satisfy their constraints during training frequently violate the same safety requirements on unseen patients — the *safety generalization gap*. The general shape matters more than the domain: an agent can degrade gracefully in quality under distribution shift and catastrophically in safety, because constraints are typically satisfied by exploiting regularities of the training distribution (which patients, which states, which edge cases appear) rather than by understanding the constraint. The discipline has two halves. First, treat training-time safety validation as in-distribution evidence only: re-evaluate the constraint under shift — unseen users, unseen populations, new sites, changed environments — before trusting it. Second, keep a runtime shield as the last line of defense: an independent filter that checks each action against the constraint at deployment time, using a model of the system's dynamics rather than the learned policy's judgment, so the guarantee does not depend on the policy's generalization. In the clinical benchmark, test-time shielding restored safety across all eight algorithms and every patient group — 13–14% time-in-range gains for the strongest baselines — while improving the other clinical metrics too. The shield does not make re-verification unnecessary; the two halves answer different questions: re-evaluation tells you *how bad* the shift is, the shield bounds the damage while you learn.

## When to reach for it

- When an agent moves between environments: a new customer base, new sites, new device populations, a regulatory region change — anywhere the deployment distribution differs from the one your guardrails were validated on.
- When guardrails were tuned and validated only on training or simulation traffic: that validation is in-distribution evidence, not a transferable guarantee.
- When the cost of a constraint violation is irreversible (health, money, data loss, trust): quality regressions can be rolled back; safety regressions compound.
- When the underlying model or policy is updated: every update re-rolls the generalization dice; re-verify the constraint and re-test the shield.

## When NOT to

- When the environment is genuinely closed and stationary and the validation distribution equals the deployment distribution — then ordinary monitoring suffices; do not build shield machinery for a gap that cannot occur.
- When the constraint check itself requires capabilities the runtime does not have — a shield that needs a dynamics model you cannot maintain becomes a second system to keep correct; a simpler invariant or rate limit may be the honest choice.
- When used as an excuse to skip training-time safety work: the shield bounds damage, it does not teach the policy the constraint; both halves exist because each covers the other's blind spot.

## Exemplars

- Kwon, Lamp & Feng, "Safety Generalization Under Distribution Shift in Safe Reinforcement Learning: A Diabetes Testbed" (ICML 2026) — https://arxiv.org/abs/2601.21094 — first-party of the pattern: reveals the safety generalization gap across eight safe RL algorithms on a unified clinical simulator, and shows test-time shielding with learned dynamics models restores safety across all algorithms and patient populations
- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents: recommends sandboxed testing before real-world deployment and layered guardrails with human escalation; the runtime shield is the guardrail layer kept structurally independent of the policy whose generalization cannot be trusted
- Munroe et al., "Safety Filter Learning: A Survey" — https://arxiv.org/abs/2409.03813 — formalizes: a survey of safety filters that override or project learned-policy actions to guarantee constraint satisfaction at runtime — the control-theoretic lineage the runtime shield draws on

## Related

- `patterns/brownfield-is-the-real-test.md`
- `patterns/real-environment-execution.md`
- `patterns/deterministic-rails.md`
- `patterns/guardrails-and-escalation.md`
