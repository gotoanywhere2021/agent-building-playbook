## 这是什么（What it is）

当编排者（orchestrator）孵化子智能体（subagent）时，默认假设常常是共享上下文越多越好——把完整的对话历史、所有先前的工具结果、迄今为止的每个决定都给它，它就拥有一切成功所需。这个假设通常是错的。被整批发送的上下文，不只携带相关信息，还携带无关的、自相矛盾的、已被推翻的。继承编排者全部历史的子智能体，同时继承每一次走错的路、每一个被丢弃的路数、每一个编排者后来推翻了的临时决定。子智能体无法区分活的信号与噪音。它把无关的东西填进自己的上下文窗口，留给要紧之物更少的空间，还可能被那些看起来像约束、实则不是的中间状态主动搞糊涂。白板委派（clean-slate delegation）把这一切倒转：任何子智能体的默认上下文是空的。编排者显式构造子智能体需要的东西——任务、约束、可视为既定前提的结论——并且只传递这些。这不是更少的信息；这是更准确的信息，去掉了搅局的杂质。编排者的职责是蒸馏，不是倾倒。

## 适用场景（When to reach for it）

- 孵化一个执行专注、自包含任务的子智能体时——给它一份针对任务的简报，而不是完整对话历史。
- 编排者的对话很长，或包含会让专注的子智能体感到困惑或分心的探索性内容时。
- 多个子智能体并行运行、每个都需要对同一组约束有一致而准确的视图时——每智能体一份简报，比每个都继承同一份长历史再各自从中提取更可靠。
- 子智能体将做出需要一次就做对的决策时——白板简报降低了无关的继承状态污染决策的概率。

## 慎用场景（When NOT to）

- 子智能体确实需要对话历史才能正确推理时——例如摘要或分析任务，完整上下文是被分析的对象本身，而不是背景。
- 构造简报的成本超过传递历史的成本时——对非常短的对话，蒸馏可能比它值的不划算。
- 子智能体正在恢复一个先前会话、且明确需要与该会话状态保持连续性时——在延续（continuation）语境下，白板是错误的默认。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier — delegate() API 默认 context_depth="none"（白板）；传递历史需要通过 context_depth="recent" 或 context_depth="all" 显式开启，使白板委派成为阻力最小的路径（据 Amplifier 团队白皮书；context_depth API 在当前公开仓库中不可见）
- Anthropic — https://www.anthropic.com/engineering/multi-agent-research-system — 『How we built our multi-agent research system』（2025）：描述 Claude Research 功能的生产级多智能体架构；包括在逼近 token 上限时孵化带干净上下文的全新子智能体的实践，连续性通过刻意的交接简报而非继承的历史来保持

## 相关模式（Related）

- `patterns/share-full-context.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/context-over-prompt.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/hang-up-call-back.md`
