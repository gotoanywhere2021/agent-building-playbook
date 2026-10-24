## 这是什么（What it is）

单个上下文窗口装不下一个为期一周的项目的完整历史。长时程记忆（long-horizon memory）不是单一技术，而是三种互补策略的组合运用。压缩（compaction）：随着会话历史变老、早期步骤的细节不再比其结果更重要，大刀阔斧地总结历史——记录决定了什么，而不是决策是如何达成的；记录构建了什么，而不是过程中的每次失败尝试。紧凑摘要取代冗长的转录。笔记文件（notes files）：在上下文窗口之外维护一份持续更新的运行文档，累积决策、悬而未决的问题、已发现的事实和下一步行动；每次会话以读取该文件开始、以更新该文件结束。隔离（isolation）：任何输出定义清晰的子任务都是新开一个子 agent 会话的候选——该会话只继承子任务所需的上下文，完成工作后返回一份摘要，不在主会话的上下文中留下残余。三者合起来：压缩处理过去，笔记处理当前状态，隔离处理未来的工作——而三者的共同点是防止陈旧、稠密、低信号的历史累积，正是这种累积拖垮长时任务的性能。

这些策略之下是一个结构性区分：记忆不是单一无差别的存储，而是一个由多层组成的栈，每层有自己的范围、生命周期和内容。命名这些层次，正是让按范围检索成为可能的前提。

| 层 | 范围 | 示例 |
|---|---|---|
| **工作上下文（Working context）** | 当前任务或会话 | 提示词、直接相关的文件、近期工具输出 |
| **项目状态（Project state）** | 当前仓库或专项 | 规范、计划、冲刺文档、测试、决策日志 |
| **会话历史（Session history）** | 此前尝试与交接 | 日志、摘要、失败的路径、未决问题 |
| **人格连续性（Persona continuity）** | 长期 agent 的风格与角色 | 偏好、职责、规范、语气、反复出现的习惯 |
| **组织知识（Organizational knowledge）** | 团队或公司实践 | 政策、领域术语表、架构规则、支持模式 |
| **外部模式库（External pattern library）** | 共享的生态知识 | 可复用模式、技能（skill）、校验器、工作流配方 |

决定性的规则是：系统不应默认注入所有层。它应当为当下检索最小的有用集合——一次代码修改很少需要组织术语表，人格连续性偏好也很少属于一次性的子任务。到处注入每一层，恰恰会重建压缩与隔离所要防止的那种陈旧稠密的上下文。

## 适用场景（When to reach for it）

- 当任务将跨越数个会话、无法在单个上下文窗口内完成。
- 当工作上下文大部分由已完成步骤的历史构成——到了压缩的时候。
- 当一个会话中发现的事实需要在下一个会话中可靠可用——趁第一个会话结束之前，现在就开一个笔记文件。
- 当一个大型子任务有清晰的输出、可以在不需要完整历史的情况下向一个全新 agent 描述——隔离它。
- 当 agent 在长会话中性能逐渐退化——通常说明上下文压缩已经欠账。

## 慎用场景（When NOT to）

- 在单个会话内完成、无需跨会话携带的短任务——笔记文件与压缩策略的开销不值得。
- 每一步决策都需要完整历史的任务（某些法律、合规或审计工作流）——压缩不得销毁审计轨迹；将其归档而非替换。

## 实例（Exemplars）

- Packer et al., "MemGPT: Towards LLMs as Operating Systems" (arXiv:2310.08560) — https://arxiv.org/abs/2310.08560 — 虚拟上下文管理的经典形式化：分层记忆与快慢存储之间的 OS 式分页；是本模式的压缩+笔记+隔离栈最直接的理论模型。
- Park et al., "Generative Agents: Interactive Simulacra of Human Behavior" (arXiv:2304.03442) — https://arxiv.org/abs/2304.03442 — 实证演示：记忆+反思+检索架构在 25 个 agent 的模拟中维持连贯行为；长时程记忆策略的早期实践锚点。
- Sumers et al., "Cognitive Architectures for Language Agents" (arXiv:2309.02427) — https://arxiv.org/abs/2309.02427 — CoALA 框架：为语言 agent 形式化了模块化记忆层；本模式表格中的分层记忆分类与 CoALA 对工作记忆、情景记忆、语义记忆和程序记忆的划分直接对应。
- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — Effective Context Engineering for AI Agents（2025 年 9 月）：把压缩（总结后重启）与外部笔记文件描述为一等策略；实现本模式最直接适用的工程参考。

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/persist-environment-facts.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/subagents-as-context-sinks.md`
- `patterns/scope-and-expire-memory.md`
