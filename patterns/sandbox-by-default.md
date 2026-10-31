---
title: Give the Agent a Sandbox, Not Your Machine
one_liner: Run autonomous agents inside disposable isolation by default — an agent with raw access to your machine, network, or data will eventually do damage, and the only real question is the blast radius.
dimensions: security, reliability
---

## What it is

Agents execute shell commands, write files, and call networks with imperfect judgment — and untrusted content (web pages, repos, tickets) is a standing prompt-injection surface. A sandbox — a container, MicroVM, devcontainer, or ephemeral cloud workspace — converts "the agent might do something destructive" from a catastrophe into an event you clean up by deleting the sandbox. Isolation is not a statement of distrust in the model; it bounds the blast radius of wrong context, injected instructions, compromised dependencies, and plain mistakes. Practice has converged on isolation tiers (OS user → container → MicroVM → ephemeral cloud fleet), with unattended "YOLO mode" execution treated as acceptable only inside one.

## When to reach for it

- Any agent that runs generated or unreviewed code: coding agents, eval harnesses, batch pipelines.
- Unattended or scheduled runs where no human confirms each action.
- Agents that ingest untrusted content while executing — the classic injection chain.
- Third-party agents, skills, or plugins you did not author.

## When NOT to

- Read-only analysis over non-sensitive data with a human confirming every step.
- Long-lived shared infrastructure whose entire purpose is mutable state — there, isolate the agent's workspace and scope its credentials (see `patterns/zero-standing-credentials.md`) instead of pretending the world can be contained.

## Exemplars

- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1HgJ26DEdc — "Sandboxing Is Not Optional": surveys four practical isolation approaches for coding agents and argues isolation should be the default, not an afterthought
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1VYpG6UEmh — "How I Learned to Stop Worrying and Love the Sandbox": practitioner account of moving agent execution into sandboxes end to end
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1oaH96iEio — "YOLO Mode Safety: MicroVM Sandboxes for Any Agent" (Docker): making unattended agent execution safe with MicroVM-grade isolation
- AI Engineer podcast (Mindofuture zh-dub) — https://www.bilibili.com/video/BV1XoNm6TE5F — "From Fork to Fleet: Designing an Agent Sandbox Cloud": what it takes to run fleets of isolated agent environments as a service

- Ephemeral-AI-Lab/layerfs — https://github.com/Ephemeral-AI-Lab/layerfs — isolation taken to the filesystem: each agent gets an ephemeral copy-on-write FUSE workspace over shared committed history, compute "exists only while a command runs," and unmounting discards the overlay — never the history
## Related

- `patterns/zero-standing-credentials.md`
- `patterns/deterministic-rails.md`
- `patterns/autonomy-when-justified.md`
- `patterns/real-environment-execution.md`
