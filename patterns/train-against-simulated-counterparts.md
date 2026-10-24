---
title: Train Against Simulated Counterparts
one_liner: Build practice environments where the counterpart — the customer, the reviewer, the evaluator — is an AI running behind a context firewall with deterministic phase gates, so deliberate practice is graded, replayable, and free of leaked answers.
dimensions: verification, workflow-discipline
---

## What it is

The skills that matter most in agentic work — eliciting requirements from an evasive stakeholder, defending a design under challenge, defining a problem before jumping to solutions — are exactly the ones that cannot be practiced safely on the job, where the counterpart is a real customer and a bad attempt is expensive. A training gym solves this by simulating the counterpart: an AI customer that releases facts only when asked the right questions and holds interests and hidden constraints; an evidence tracker that records which claims are actually supported; an evaluator that grades against criteria the learner never sees. The engineering that makes it more than role-play is separation and determinism: the roles run as isolated model calls behind a field-level context firewall — the customer cannot see the grading rubric, the evaluator cannot see the customer's private facts, and canary strings prove leakage is structurally impossible — while a deterministic state machine, not model prose, decides whether each phase gate is passed. The whole session is an append-only event log that replays for review and focused retry. Benchmarks like TheAgentCompany demonstrate the same structure scaled up: a simulated company whose consequential, multi-application tasks measure what agents can actually do end to end. The pattern generalizes: any capability that involves a counterpart can be trained against a simulated one, provided the simulation is isolated, the gates are deterministic, and the answers stay behind the wall.

## When to reach for it

- When the failure cost of live practice is high: requirements discovery, incident response, design defense, negotiation — practice where the mistake is free.
- When the skill is a *process*, not an answer: phase gates grade whether the learner asked before proposing and evidenced claims before framing — the state machine enforces an order that prose grading would wave through.
- When evaluating agents end to end: the same simulated-counterpart structure doubles as an eval — scoring real tasks in a simulated organization, not toy question-answering.
- When you need fair retry: deterministic gates plus a replayable log mean a retry starts clean and a regrade is stable.

## When NOT to

- When the counterpart's realism *is* the skill — negotiating with a specific hard person, or operating a tool with real side effects: simulation teaches the shape, not the stakes; schedule real practice too.
- When a checklist or rubric suffices: if "did you ask about budget?" is the whole lesson, a static rubric beats a simulated customer.
- When leakage would invalidate the grade but you cannot enforce isolation: an unguarded simulator where the learner can read the rubric trains gaming, not skill.

## Exemplars

- FDE Gym — https://github.com/flingjie/FDE-Gym — first-party of the pattern: a training gym for forward-deployed engineers with an AI customer, an evidence tracker, and an evaluator behind a field-level context firewall, deterministic phase gates from discovery to pitch defense, and byte-stable replay for review and focused retry
- TheAgentCompany — https://github.com/TheAgentCompany/TheAgentCompany — benchmark: agents work as employees in a simulated software company — internal chat, GitLab, wikis, colleague interactions — performing consequential tasks graded programmatically; its findings (self-verification and asking for help remain the weakest skills) feed back into agent design
- Wang et al., "Voyager: An Open-Ended Embodied Agent with Large Language Models" (arXiv:2305.16291) — https://arxiv.org/abs/2305.16291 — adjacent discipline: an agent that builds skill iteratively in Minecraft's simulated world; the curriculum is the environment, not a rubric

## Related

- `patterns/simulated-review-squad.md`
- `patterns/gate-the-phases.md`
- `patterns/real-environment-execution.md`
- `patterns/make-runs-replayable.md`
