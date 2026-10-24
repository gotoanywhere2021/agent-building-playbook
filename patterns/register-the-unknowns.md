---
title: Register the Unknowns
one_liner: An unresolved question is not a failure — an unregistered one is. Give every open question a first-class record with severity, scope, and the evidence that would resolve it, then revise it append-only as understanding improves.
dimensions: reliability, verification, observability
---

## What it is

An agent's honest output includes what it does not know — but most harnesses have no place to put that. "I'm not sure whether X" lives in prose, gets compacted away, and resurfaces later as a confident claim or, worse, as a silent gap nobody remembers was open. The alternative is to make unknowns first-class: a residual-unknown record with a stable identity, the concrete question, a severity, a domain, the evidence currently supporting and contradicting it, the kind of evidence — an artifact inspection, a controlled replay, a live observation — that could actually resolve it, and an append-only revision history as hypotheses change. The discipline has a hard edge: an unknown is a legitimate terminal state, but it must be *registered*, with its resolution requirements stated — "unknown" is never allowed to silently mean "verified" or "not applicable." This inverts the usual incentive: agents are rewarded for tidy-looking reports, so unregistered uncertainty gets absorbed into confident prose. A ledger flips the accounting — the run that ends with five registered unknowns and no fabricated closure is more trustworthy than the run that ends with everything marked done. REA, a reverse-engineering toolkit where every conclusion must carry its evidence and limitations, treats this ledger as core infrastructure: unknowns survive the session, block conclusions that depend on them, and can only be closed by the class of evidence they declare.

## When to reach for it

- When agent output feeds later decisions: an unregistered unknown compounds silently downstream; a registered one can be queried, prioritized, and closed on purpose.
- When work spans sessions or agents: prose-level uncertainty does not survive handoff; records do.
- When conclusions must be auditable: each claim cites its evidence, and each open question names the evidence that would settle it — reviewers check the ledger, not the tone.
- When a domain mixes strong evidence with inference: make the boundary explicit per claim instead of letting prose blur it.

## When NOT to

- When the unknown is trivial and local — "this variable name might be stale," resolved in the next line: a ledger entry costs more than the risk it manages.
- When the audience needs a decision now and the ledger would become an excuse not to decide: register the unknown *and* state the working assumption; the record disciplines the assumption, it does not replace the decision.
- When no mechanism could ever resolve the record: an unresolvable ledger becomes ritual; scope it to questions with a declared evidence path.

## Exemplars

- REA (Reverse Engineer Anything) — https://github.com/morluto/rea — first-party of the pattern: an agent toolkit for reverse engineering where every analysis result ships with its evidence and limitations, and residual unknowns are structured records — stable id, question, severity, domain, supporting and contradicting evidence, required authority and environment, recommended probes — revised append-only until resolved or explicitly withdrawn
- Amplifier — https://github.com/microsoft/amplifier — the honest-stopping principle: when required evidence cannot be obtained, the agent must stop and report the gap rather than fabricate closure (per the Amplifier team's white papers; not visible in the current public repos)
- Google SRE Book, "Postmortem Culture" — https://sre.google/sre-book/postmortem-culture/ — adjacent discipline: incident reviews that end with tracked, owned follow-up items rather than narrative closure — the same ledger habit applied to defects instead of open questions

## Related

- `patterns/evidence-before-assertions.md`
- `patterns/demand-independent-proof.md`
- `patterns/mark-skipped-steps.md`
- `patterns/fail-loud-over-fallbacks.md`
