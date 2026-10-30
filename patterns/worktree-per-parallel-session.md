---
title: One Worktree per Parallel Session
one_liner: Parallel agent sessions need filesystem isolation, not just context isolation — give each its own branch and git worktree, verify a clean test baseline in it before starting, and let merging be the only integration point.
dimensions: workflow-discipline, orchestration
---

## What it is

Two agents sharing one checkout collide in ways context isolation cannot fix: interleaved builds, mutual clobbered untracked files, one session's half-finished state breaking the other's tests. The git-native fix is the worktree: one task, one branch, one worktree (`git worktree add ../repo-task feature/task`), so each session gets its own working directory while sharing the same object store. The discipline has two extra moves that make it work: verify a clean test baseline inside the worktree before the agent starts (so "broken" is never inherited ambiguity), and treat merge as the single deliberate integration point where conflicts are resolved once, by a human or an integrating agent, instead of continuously by collision.

## When to reach for it

- Multiple agent sessions (or agents and humans) working the same repository concurrently.
- Parallel attempts at one task, or variant comparison — each variant lives in its own tree until a winner merges (`patterns/parallel-attempts-at-one-task.md`, `patterns/build-five-to-throw-away.md`).
- A long-running background agent must not disturb the interactive session's working state.
- Tasks whose toolchains write fixed-path build outputs that would collide in one directory.

## When NOT to

- A single sequential session — a worktree is ceremony with no payoff (`patterns/single-threaded-default.md`).
- Tasks sharing mutable state outside git — databases, deployed services, external APIs. Worktrees isolate files only; pair with data isolation or run serially (`patterns/agents-are-distributed-systems.md`).
- Steps with ordering dependencies — if task B consumes task A's output, they are one pipeline, not two worktrees.

## Exemplars

- obra/superpowers — https://github.com/obra/superpowers — the `using-git-worktrees` skill: creates an isolated branch workspace and verifies a clean test baseline before starting any parallel work; part of a 300k-star skills framework
- Git documentation — https://git-scm.com/docs/git-worktree — the primitive itself: multiple working trees attached to one repository, each on its own branch

## Related

- `patterns/parallel-independent-tracks.md`
- `patterns/parallel-attempts-at-one-task.md`
- `patterns/build-five-to-throw-away.md`
- `patterns/clean-slate-delegation.md`
