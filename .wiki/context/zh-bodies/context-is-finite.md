## 这是什么（What it is）

上下文窗口（context window）是一笔预算，不是垃圾场。你放进上下文的每一个 token，都在与所有其他 token 争夺模型的注意力，而这注意力并非均匀分布——低信号内容（样板文字、重复、无关历史）会主动降低模型对待高信号内容的质量。甄选（curation）不是可选项；它是一门纪律：把预算留给最能改变输出的内容。把见过的所有东西都堆进上下文的智能体与编排器（orchestrator）并不是在追求周全——它们在挥霍系统中最有限的资源。

## 适用场景（When to reach for it）

- 设计系统提示词（system prompt）、工具响应或记忆注入（memory injection）的内容时：问一问哪些内容删掉也不损害结果。
- 当智能体流水线（pipeline）在步骤之间传递完整对话历史时——到下一步运行时，大部分已是噪声。
- 长时间运行的智能体产出随时间变差时——上下文膨胀（context bloat）是常见元凶。
- 评估检索（retrieval）策略时：为相关性而检索，不为完整性而检索。

## 慎用场景（When NOT to）

- 确实需要完整对话脉络来维持连贯性的探索性对话——过早截断上下文会以难以诊断的方式破坏推理。
- 每个先前步骤的出处（provenance）与可审计性都重要的任务（法律、合规、受监管领域）——如果甄选上下文会摧毁审计线索，就不要甄选。

## 实例（Exemplars）

- Liu 等，《Lost in the Middle: How Language Models Use Long Contexts》（arXiv:2307.03172）— https://arxiv.org/abs/2307.03172 — 实证支持：展示了 U 形性能曲线——模型对长上下文中段信息的表现最差，说明上下文的位置与体量会主动降低检索质量
- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — 《Effective Context Engineering for AI Agents》：把上下文框定为注意力预算（attention budget），引用『上下文腐化』（context rot）——来自大海捞针（needle-in-a-haystack）基准测试的发现：性能随上下文增长而退化——并把甄选视为维持信号质量的核心纪律
