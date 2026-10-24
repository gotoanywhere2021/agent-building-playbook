---
title: Skills Load on Trigger, Not Always-On
one_liner: Ship methodology as a library of skills whose always-loaded footprint is a tiny index of names and trigger descriptions — the full process document enters context only when its trigger fires, and gates make using it mandatory instead of advisory.
dimensions: context-engineering, workflow-discipline
---

## What it is

A team's process knowledge — how to brainstorm a spec, how to write a plan, how to debug systematically — faces a loading dilemma. Bake it into the system prompt and it consumes context on every turn whether or not it applies, crowding out the task at hand. Leave it in a docs folder and the agent never finds it at the moment it matters. Skills resolve this with a two-layer design: each process document is a standalone unit with a name, a one-paragraph description stating *when* to use it, and a full body; only the name-and-description index stays always-loaded. The agent scans the index at each task boundary, and when the current situation matches a description — "about to implement without a plan", "tests failing and you're guessing at fixes" — it loads that skill's body into context, follows it, and lets it fall away. The description is not metadata; it is the trigger mechanism, and it is where most of the engineering effort goes: a trigger that fires too rarely leaves the discipline unused, one that fires too often loads irrelevant process. Superpowers demonstrates the third ingredient that makes this work: usage is gated, not suggested — the workflow requires a design doc before implementation and a failing test before code, so the skill is not advice the model may skip but a phase boundary it cannot cross without invoking.

## When to reach for it

- When you have more process knowledge than context: a dozen disciplines at a few thousand tokens each would dominate a system prompt; as a triggered library they cost one line each until needed.
- When the discipline is phase-specific: brainstorming before code, review before merge, a debugging protocol on repeated failure — each trigger maps cleanly to a task boundary.
- When your process keeps being skipped: if the model "knows" the methodology but drifts from it mid-task, a trigger plus a gate converts intention into invocation.
- When one skill library must serve many harnesses and models: name-plus-trigger-plus-body is the lowest common denominator every agent can consume.

## When NOT to

- When the knowledge is needed on every turn — core identity, output format, hard constraints: those belong in the always-loaded context; skills are for episodic process, not standing policy.
- When triggers cannot be stated observably: "when the work is complex" loads everywhere; "when about to implement a multi-file change without an approved plan" loads exactly once.
- When the body is so short it fits in the description — a two-line checklist does not need a loading mechanism; the loading overhead exceeds the content.

## Exemplars

- Superpowers — https://github.com/obra/superpowers — first-party of the pattern: Jesse Vincent's agentic skills framework (Claude Code, Codex, Cursor, Gemini CLI and more); every skill is a name, a trigger description, and a full methodology body; a bootstrap skill makes the agent check the index before any task, and the pipeline's gates — design doc before implementation, failing test before code — make loading mandatory, not advisory: "mandatory workflows, not suggestions"
- Anthropic — https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills — formalizes: Agent Skills are folders of instructions discovered by their descriptions and loaded into context only when relevant, with optional executable scripts attached
- Amplifier — https://github.com/microsoft/amplifier — the recipe system pairs each recipe with an invocation trigger; per the Amplifier team's white papers the always-loaded surface stays minimal while recipes enter context on demand

## Related

- `patterns/just-in-time-retrieval.md`
- `patterns/recipe-not-conversation.md`
- `patterns/gate-the-phases.md`
- `patterns/context-is-finite.md`
