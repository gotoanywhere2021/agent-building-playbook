---
title: Compile Taste Into Detectors
one_liner: Taste feels un-checkable, so teams leave it to model judgment — and every model converges on the same generic slop; instead, compile your taste's failure modes into deterministic detectors that run automatically on every artifact the agent edits, before it can declare done.
dimensions: tool-design, taste
---

## What it is

Ask a model to "make it beautiful" and you get the same cream page, default font stack, and gradient-accent cards every model produces — because taste enforced by judgment regresses to the distribution, while the *failure modes* of taste are perfectly checkable. The move is to compile the tells into deterministic rules — no LLM involved: linters, rule engines, hook scripts that scan every artifact the agent touches and block completion while findings stand. The detector owns the negatives (the 60-odd recognizable clichés, the cramped padding, the contrast failures); model judgment keeps the positives (composition, concept, the bold move no rule would suggest). Crucially, the detector runs as a hook at the edit site, not as a review step someone must remember — the slop check fires before the agent can say "done."

## When to reach for it

- A quality domain where output decays into recognizable clichés (UI, writing voice, slide decks, commit messages) and review keeps catching the same nits.
- You can already name the tells precisely — each rule is one named failure mode with a threshold.
- Review is the bottleneck: push the repetitive half of taste review into the gate so human/agent attention lands on judgment.

## When NOT to

- Taste you cannot yet articulate as rules — write the rubric and collect examples first (`patterns/good-pile-bad-pile.md`); a vague detector is worse than none.
- Rules that would freeze style into dogma — ship an allow/ignore list and revisit; the detector encodes yesterday's taste, and it should be easy to amend.
- Properties better served by scored judgment — detectors catch binary tells; ranking and nuance stay with critique (`patterns/calibrate-the-judge.md`).

## Exemplars

- pbakaus/impeccable — https://github.com/pbakaus/impeccable — 62 deterministic rules flagging AI-slop tells ("Inter for everything," purple-to-blue gradients, cards nested in cards), running three ways: an agent hook that scans every UI file before completion, a CLI, and a browser overlay; born from Anthropic's frontend-design skill
- Simon Willison on linting as taste — https://simonwillison.net/2020/Feb/11/codespell/ — the general shape: encode recurring human review findings as automated checks so the check outlives the reviewer's attention

## Related

- `patterns/critic-applications.md`
- `patterns/self-verification.md`
- `patterns/fail-loud-harnesses.md`
- `patterns/develop-your-taste.md`
- `patterns/good-pile-bad-pile.md`
