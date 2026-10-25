FILE patterns/adversarial-parallel-review | urls=3 ok=2 bad=1 skip=0
200 | https://arxiv.org/abs/1805.00899 | patterns/adversarial-parallel-review
200 | https://arxiv.org/abs/2407.00215 | patterns/adversarial-parallel-review
TIMEOUT | https://github.com/2389-research/simmer | patterns/adversarial-parallel-review
FILE patterns/anchor-on-canonical-names | urls=2 ok=0 bad=2 skip=0
TIMEOUT | https://github.com/lexler/augmented-coding-patterns/blob/main/documents/patterns/semantic-anchors.md | patterns/anchor-on-canonical-names
TIMEOUT | https://llm-coding.github.io/Semantic-Anchors/ | patterns/anchor-on-canonical-names
FILE patterns/automate-but-avoid-mystery-house | urls=3 ok=2 bad=1 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/automate-but-avoid-mystery-house
TIMEOUT | https://github.com/microsoft/amplifier-bundle-recipes | patterns/automate-but-avoid-mystery-house
200 | https://www.dbreunig.com/2026/03/26/winchester-mystery-house.html | patterns/automate-but-avoid-mystery-house
FILE patterns/build-a-pattern-registry | urls=5 ok=2 bad=2 skip=1
TIMEOUT | https://en.wikipedia.org/wiki/A_Pattern_Language | patterns/build-a-pattern-registry
TIMEOUT | https://en.wikipedia.org/wiki/Design_Patterns | patterns/build-a-pattern-registry
200 | https://arxiv.org/abs/2305.16291 | patterns/build-a-pattern-registry
200 | https://skills.2389.ai | patterns/build-a-pattern-registry
RATE_LIMITED_SKIP | https://github.com/voyager-crew/voyager | patterns/build-a-pattern-registry
FILE patterns/clear-stop-condition | urls=1 ok=1 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/clear-stop-condition
FILE patterns/context-is-finite | urls=2 ok=2 bad=0 skip=0
200 | https://arxiv.org/abs/2307.03172 | patterns/context-is-finite
200 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | patterns/context-is-finite
FILE patterns/declare-outcomes-not-procedures | urls=3 ok=3 bad=0 skip=0
200 | https://www.bilibili.com/video/BV1Nvn26tETp | patterns/declare-outcomes-not-procedures
200 | https://www.bilibili.com/video/BV1cpa66aEnR | patterns/declare-outcomes-not-procedures
200 | https://www.bilibili.com/video/BV1L2uB6ZEkQ | patterns/declare-outcomes-not-procedures
FILE patterns/design-the-loop | urls=2 ok=2 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/design-the-loop
200 | https://www.anthropic.com/news/developing-computer-use | patterns/design-the-loop
FILE patterns/earn-the-interruption | urls=1 ok=0 bad=1 skip=0
TIMEOUT | https://ics.uci.edu/~gmark/chi08-mark.pdf | patterns/earn-the-interruption
FILE patterns/fail-loud-harnesses | urls=3 ok=2 bad=0 skip=1
200 | https://www.anthropic.com/research/building-effective-agents | patterns/fail-loud-harnesses
200 | https://www.jamesshore.com/v2/blog/2004/fail-fast | patterns/fail-loud-harnesses
RATE_LIMITED_SKIP | https://github.com/buguoshixc/ai-deals-aggregator | patterns/fail-loud-harnesses
FILE patterns/gate-the-phases | urls=2 ok=1 bad=0 skip=1
200 | https://ideas.repec.org/a/eee/bushor/v33y1990i3p44-54.html | patterns/gate-the-phases
RATE_LIMITED_SKIP | https://github.com/obra/superpowers | patterns/gate-the-phases
FILE patterns/hang-up-call-back | urls=1 ok=1 bad=0 skip=0
200 | https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html | patterns/hang-up-call-back
FILE patterns/instrument-the-context-window | urls=3 ok=2 bad=0 skip=1
RATE_LIMITED_SKIP | https://github.com/bowenliang123/dsh-context | patterns/instrument-the-context-window
200 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | patterns/instrument-the-context-window
200 | https://langfuse.com/docs | patterns/instrument-the-context-window
FILE patterns/leverage-over-efficiency | urls=1 ok=1 bad=0 skip=0
200 | https://www.shortform.com/blog/andrew-grove-high-output-management/ | patterns/leverage-over-efficiency
FILE patterns/match-agent-metaphor-to-layer | urls=3 ok=1 bad=1 skip=1
TIMEOUT | https://en.wikipedia.org/wiki/Intentional_stance | patterns/match-agent-metaphor-to-layer
RATE_LIMITED_SKIP | https://en.wikipedia.org/wiki/The_Media_Equation | patterns/match-agent-metaphor-to-layer
200 | https://www.anthropic.com/engineering/multi-agent-research-system | patterns/match-agent-metaphor-to-layer
FILE patterns/namespace-tools | urls=2 ok=2 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/namespace-tools
200 | https://www.anthropic.com/engineering/writing-tools-for-agents | patterns/namespace-tools
FILE patterns/persist-environment-facts | urls=2 ok=2 bad=0 skip=0
200 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | patterns/persist-environment-facts
200 | https://arxiv.org/abs/2511.12884 | patterns/persist-environment-facts
FILE patterns/real-environment-execution | urls=7 ok=2 bad=1 skip=4
200 | https://www.anthropic.com/research/building-effective-agents | patterns/real-environment-execution
RATE_LIMITED_SKIP | https://github.com/microsoft/amplifier-bundle-digital-twin-universe | patterns/real-environment-execution
200 | https://12factor.net/dev-prod-parity | patterns/real-environment-execution
TIMEOUT | https://copyconstruct.medium.com/testing-in-production-the-hard-parts-3f06cefaf592 | patterns/real-environment-execution
RATE_LIMITED_SKIP | https://github.com/2389-research/scenario-testing | patterns/real-environment-execution
RATE_LIMITED_SKIP | https://github.com/2389-research/ish | patterns/real-environment-execution
RATE_LIMITED_SKIP | https://github.com/THUDM/AgentBench | patterns/real-environment-execution
FILE patterns/register-the-unknowns | urls=3 ok=1 bad=0 skip=2
RATE_LIMITED_SKIP | https://github.com/morluto/rea | patterns/register-the-unknowns
RATE_LIMITED_SKIP | https://github.com/microsoft/amplifier | patterns/register-the-unknowns
200 | https://sre.google/sre-book/postmortem-culture/ | patterns/register-the-unknowns
FILE patterns/safety-guarantees-dont-transfer | urls=3 ok=3 bad=0 skip=0
200 | https://arxiv.org/abs/2601.21094 | patterns/safety-guarantees-dont-transfer
200 | https://www.anthropic.com/research/building-effective-agents | patterns/safety-guarantees-dont-transfer
200 | https://arxiv.org/abs/2409.03813 | patterns/safety-guarantees-dont-transfer
FILE patterns/self-modifying-context-needs-review | urls=2 ok=2 bad=0 skip=0
200 | https://arxiv.org/abs/2310.08560 | patterns/self-modifying-context-needs-review
200 | https://simonwillison.net/2022/Sep/12/prompt-injection/ | patterns/self-modifying-context-needs-review
FILE patterns/shape-work-as-an-attractor | urls=2 ok=1 bad=1 skip=0
200 | https://arxiv.org/abs/2512.10350 | patterns/shape-work-as-an-attractor
429 | https://www.lesswrong.com/posts/rvbjZMp6aEDn2jiyp/mapping-llm-attractor-states | patterns/shape-work-as-an-attractor
FILE patterns/skills-load-on-trigger | urls=3 ok=1 bad=0 skip=2
RATE_LIMITED_SKIP | https://github.com/obra/superpowers | patterns/skills-load-on-trigger
200 | https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills | patterns/skills-load-on-trigger
RATE_LIMITED_SKIP | https://github.com/microsoft/amplifier | patterns/skills-load-on-trigger
FILE patterns/subagents-as-context-sinks | urls=5 ok=4 bad=0 skip=1
200 | https://www.anthropic.com/research/building-effective-agents | patterns/subagents-as-context-sinks
RATE_LIMITED_SKIP | https://github.com/microsoft/amplifier | patterns/subagents-as-context-sinks
200 | https://www.anthropic.com/engineering/multi-agent-research-system | patterns/subagents-as-context-sinks
200 | https://www.langchain.com/blog/context-engineering-for-agents | patterns/subagents-as-context-sinks
200 | https://cognition.com/blog/dont-build-multi-agents | patterns/subagents-as-context-sinks
FILE patterns/thin-pointers | urls=3 ok=2 bad=0 skip=1
RATE_LIMITED_SKIP | https://github.com/microsoft/amplifier | patterns/thin-pointers
200 | https://www.langchain.com/blog/context-management-for-deepagents | patterns/thin-pointers
200 | https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html | patterns/thin-pointers
FILE patterns/train-against-simulated-counterparts | urls=3 ok=1 bad=0 skip=2
RATE_LIMITED_SKIP | https://github.com/flingjie/FDE-Gym | patterns/train-against-simulated-counterparts
RATE_LIMITED_SKIP | https://github.com/TheAgentCompany/TheAgentCompany | patterns/train-against-simulated-counterparts
200 | https://arxiv.org/abs/2305.16291 | patterns/train-against-simulated-counterparts
FILE patterns/write-select-compress-isolate | urls=3 ok=3 bad=0 skip=0
200 | https://www.langchain.com/blog/context-engineering-for-agents | patterns/write-select-compress-isolate
200 | https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html | patterns/write-select-compress-isolate
200 | https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html | patterns/write-select-compress-isolate
BATCH B00 DONE files=27 urls=73 ok=46 bad=10 skip=17
FILE patterns/agents-are-distributed-systems | urls=3 ok=3 bad=0 skip=0
200 | https://www.bilibili.com/video/BV1i3tU6TEeb | patterns/agents-are-distributed-systems
200 | https://www.bilibili.com/video/BV1o3tU6TEbE | patterns/agents-are-distributed-systems
200 | https://www.bilibili.com/video/BV178gS6AEke | patterns/agents-are-distributed-systems
FILE patterns/auditable-artifacts | urls=3 ok=3 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/auditable-artifacts
200 | https://github.com/microsoft/amplifier | patterns/auditable-artifacts
200 | https://martinfowler.com/eaaDev/EventSourcing.html | patterns/auditable-artifacts
FILE patterns/bite-sized-tasks | urls=3 ok=3 bad=0 skip=0
200 | https://github.com/microsoft/amplifier-bundle-superpowers | patterns/bite-sized-tasks
200 | https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/ | patterns/bite-sized-tasks
200 | https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/ | patterns/bite-sized-tasks
FILE patterns/checkpoint-handoff-file | urls=3 ok=3 bad=0 skip=0
200 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | patterns/checkpoint-handoff-file
200 | https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus | patterns/checkpoint-handoff-file
200 | https://arxiv.org/abs/2310.08560 | patterns/checkpoint-handoff-file
FILE patterns/code-is-cheap-maintenance-isnt | urls=2 ok=2 bad=0 skip=0
200 | https://blog.acolyer.org/2020/02/14/programs-life-cycles-laws/ | patterns/code-is-cheap-maintenance-isnt
200 | https://c2.com/doc/oopsla92.html | patterns/code-is-cheap-maintenance-isnt
FILE patterns/critic-applications | urls=4 ok=4 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/critic-applications
200 | https://github.com/microsoft/amplifier-bundle-superpowers | patterns/critic-applications
200 | https://arxiv.org/abs/2304.05128 | patterns/critic-applications
200 | https://arxiv.org/abs/2303.11366 | patterns/critic-applications
FILE patterns/demand-independent-proof | urls=4 ok=4 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/demand-independent-proof
200 | https://github.com/microsoft/amplifier-bundle-superpowers | patterns/demand-independent-proof
200 | https://arxiv.org/abs/2310.01798 | patterns/demand-independent-proof
200 | https://deepmind.google/blog/specification-gaming-the-flip-side-of-ai-ingenuity/ | patterns/demand-independent-proof
FILE patterns/document-intent | urls=2 ok=2 bad=0 skip=0
200 | https://pages.cs.wisc.edu/~remzi/Naur.pdf | patterns/document-intent
200 | https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions | patterns/document-intent
FILE patterns/eval-driven-development | urls=4 ok=4 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/eval-driven-development
200 | https://arxiv.org/abs/2411.13768 | patterns/eval-driven-development
200 | https://hamel.dev/blog/posts/evals/ | patterns/eval-driven-development
200 | https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents | patterns/eval-driven-development
FILE patterns/finishing-is-the-bottleneck | urls=3 ok=2 bad=1 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/finishing-is-the-bottleneck
TIMEOUT | https://en.wikipedia.org/wiki/Theory_of_constraints | patterns/finishing-is-the-bottleneck
200 | https://dora.dev/guides/dora-metrics-four-keys/ | patterns/finishing-is-the-bottleneck
FILE patterns/governance-is-infrastructure | urls=2 ok=2 bad=0 skip=0
200 | https://www.openpolicyagent.org/ | patterns/governance-is-infrastructure
200 | https://www.nist.gov/itl/ai-risk-management-framework | patterns/governance-is-infrastructure
FILE patterns/human-async-api | urls=2 ok=2 bad=0 skip=0
200 | https://www.bilibili.com/video/BV1aDpu6zEoP | patterns/human-async-api
200 | https://www.bilibili.com/video/BV1v2uB6ZEQF | patterns/human-async-api
FILE patterns/just-in-time-retrieval | urls=4 ok=4 bad=0 skip=0
200 | https://www.anthropic.com/news/contextual-retrieval | patterns/just-in-time-retrieval
200 | https://arxiv.org/abs/2005.11401 | patterns/just-in-time-retrieval
200 | https://arxiv.org/abs/2307.03172 | patterns/just-in-time-retrieval
200 | https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents | patterns/just-in-time-retrieval
FILE patterns/make-runs-replayable | urls=4 ok=4 bad=0 skip=0
200 | https://github.com/flingjie/FDE-Gym | patterns/make-runs-replayable
200 | https://github.com/buguoshixc/ai-deals-aggregator | patterns/make-runs-replayable
200 | https://github.com/morluto/rea | patterns/make-runs-replayable
200 | https://martinfowler.com/eaaDev/EventSourcing.html | patterns/make-runs-replayable
FILE patterns/memory-into-skills | urls=5 ok=5 bad=0 skip=0
200 | https://www.bilibili.com/video/BV1Gzpq6DE77 | patterns/memory-into-skills
200 | https://www.bilibili.com/video/BV1jVpB6tEEJ | patterns/memory-into-skills
200 | https://www.bilibili.com/video/BV1NBNh6jEX9 | patterns/memory-into-skills
200 | https://www.bilibili.com/video/BV1W97L6PEZS | patterns/memory-into-skills
200 | https://www.bilibili.com/video/BV1exuA6sE5C | patterns/memory-into-skills
FILE patterns/parallel-independent-tracks | urls=3 ok=3 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/parallel-independent-tracks
200 | https://github.com/microsoft/amplifier | patterns/parallel-independent-tracks
200 | https://www.anthropic.com/engineering/multi-agent-research-system | patterns/parallel-independent-tracks
FILE patterns/proposer-authority-separation | urls=3 ok=2 bad=1 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/proposer-authority-separation
200 | https://github.com/microsoft/amplifier-bundle-recipes | patterns/proposer-authority-separation
TIMEOUT | https://www.cs.virginia.edu/~evans/cs551/saltzer/ | patterns/proposer-authority-separation
FILE patterns/recon-before-action | urls=5 ok=5 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/recon-before-action
200 | https://github.com/microsoft/amplifier-foundation | patterns/recon-before-action
200 | https://code.claude.com/docs/en/best-practices | patterns/recon-before-action
200 | https://arxiv.org/abs/2407.01489 | patterns/recon-before-action
200 | https://arxiv.org/abs/2605.00080 | patterns/recon-before-action
FILE patterns/requirements-are-disguised-solutions | urls=3 ok=3 bad=0 skip=0
200 | https://geraldmweinberg.com/Site/Exploring_Requirements.html | patterns/requirements-are-disguised-solutions
200 | https://xyproblem.info | patterns/requirements-are-disguised-solutions
200 | https://www.library.hbs.edu/working-knowledge/clay-christensens-milkshake-marketing | patterns/requirements-are-disguised-solutions
FILE patterns/search-over-list | urls=3 ok=3 bad=0 skip=0
200 | https://www.anthropic.com/news/contextual-retrieval | patterns/search-over-list
200 | https://www.anthropic.com/engineering/writing-tools-for-agents | patterns/search-over-list
200 | https://arxiv.org/abs/2307.16789 | patterns/search-over-list
FILE patterns/session-archaeology | urls=3 ok=3 bad=0 skip=0
200 | https://github.com/microsoft/amplifier-foundation | patterns/session-archaeology
200 | https://arxiv.org/abs/2606.04990 | patterns/session-archaeology
200 | https://arxiv.org/abs/2604.05485 | patterns/session-archaeology
FILE patterns/simulated-review-squad | urls=4 ok=4 bad=0 skip=0
200 | https://arxiv.org/abs/2303.17760 | patterns/simulated-review-squad
200 | https://arxiv.org/abs/2307.07924 | patterns/simulated-review-squad
200 | https://arxiv.org/abs/2308.00352 | patterns/simulated-review-squad
200 | https://github.com/2389-research/review-squad | patterns/simulated-review-squad
FILE patterns/state-the-target | urls=3 ok=3 bad=0 skip=0
200 | https://github.com/lexler/augmented-coding-patterns/blob/main/documents/patterns/point-the-target.md | patterns/state-the-target
200 | https://github.com/lexler/augmented-coding-patterns/blob/main/documents/obstacles/negative-bleedthrough.md | patterns/state-the-target
200 | https://aclanthology.org/2020.acl-main.698/ | patterns/state-the-target
FILE patterns/tests-first-on-api-change | urls=3 ok=3 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/tests-first-on-api-change
200 | https://github.com/microsoft/amplifier-bundle-superpowers | patterns/tests-first-on-api-change
200 | https://www.informit.com/store/test-driven-development-by-example-9780321146533 | patterns/tests-first-on-api-change
FILE patterns/tools-for-agents | urls=3 ok=3 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/tools-for-agents
200 | https://www.anthropic.com/engineering/writing-tools-for-agents | patterns/tools-for-agents
200 | https://arxiv.org/abs/2302.04761 | patterns/tools-for-agents
FILE patterns/work-backward-from-the-shipping-dock | urls=2 ok=2 bad=0 skip=0
200 | https://www.anthropic.com/research/building-effective-agents | patterns/work-backward-from-the-shipping-dock
200 | https://workingbackwards.com/concepts/working-backwards-pr-faq-process/ | patterns/work-backward-from-the-shipping-dock
BATCH B03 DONE files=26 urls=83 ok=81 bad=2 skip=0
WORKER W2 STOPPED 2026-10-25T10:33:53Z
