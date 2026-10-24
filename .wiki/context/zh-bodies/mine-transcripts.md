## 这是什么（What it is）

组织产生海量的对话尾气（conversational exhaust）——会议转录（transcript）、agent 会话日志、Slack 线程、支持对话——而条件反射式的做法是把每一条总结成整洁的笔记、其余丢弃。这恰恰扔掉了最有价值的部分。转录本身往往比生成的会议纪要更有用，因为它是可以从其中推导出许多不同结构化产物的原材料，每种产物服务一个独特目的。主题聚类（topic clusters）揭示跨会话反复出现的主题。实体图（entity graphs）追踪对话不断触及的人、项目、工具、概念和关系。矛盾清单（contradiction lists）呈现战略、价值观或需求相互冲突之处。行动库（action repositories）抽取埋在讨论中的任务、承诺和决策。Takebook 概括某个个人或组织对一个反复出现的主题的真实想法。人格素材（persona material）为领域专属评审者和数字孪生提供养料。模式候选（pattern candidates）标记值得编纂的重复性操作手法。统摄一切的洞见是：工作流不是『记录一切然后祈祷』——而是记录、变换、结构化、评估、检索。没有变换步骤的记录是转录囤积：它产出的是存储，不是知识，而没人能查询或信任的存储是负债，不是资产。

## 适用场景（When to reach for it）

- 当团队积累了无人回访的转录、日志或聊天历史——那里有潜在知识，但前提是把它变换成可查询的产物。
- 当相同的问题、决策或分歧在会议间反复出现、却没人能指出它们上次在哪里被解决——实体图和行动库让历史变得可导航。
- 构建应当反映某个真人或组织思维方式的领域专属评审者、数字孪生或人格时——去挖他们的转录做 takebook 和人格素材，而不是手写一个猜测。
- 想发现团队已经在隐式使用的模式时——转录挖掘为模式登记处（registry）提供模式候选。
- 评估检索到的上下文是否真正有用时——派生的结构化产物远比原始转录转储更容易评估和检索。

## 慎用场景（When NOT to）

- 还没决定派生产物必须回答什么问题时——盲目变换产出的另一种淤泥（sludge），与囤积没有两样。
- 高度敏感或受监管的对话，留存与派生会带来隐私或合规暴露——范围、同意与删除策略优先。
- 没有复用价值的一次性对话——变换流水线是开销，只在语料规模上才有回报。
- 当一份轻量摘要确实够用、且没人会需要结构时——不要为单条状态更新建实体图。

## 实例（Exemplars）

- Park et al., "Generative Agents: Interactive Simulacra of Human Behavior" (arXiv:2304.03442) — https://arxiv.org/abs/2304.03442 — 形式化：记忆流 + 反思机制随时间把原始经验记录变换为更高层的结构化洞见，与本模式为组织转录主张的『记录→变换→结构化』流水线同构。
- Anthropic Applied AI Team, "Effective context engineering for AI agents" — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — 形式化：把结构化笔记、压缩和 agent 自管理记忆确立为在长时任务中把原始对话上下文变成可查询、可检索知识的具体技术。
- 2389 Research, summarize-meetings — https://github.com/2389-research/summarize-meetings — 一方实践（first-party）：把积压的会议转录变成互连的知识图谱——并行 agent 分批处理每个月份，抽取人物、行动项、概念和项目桩，并用 wiki 链接把它们连起来；对约 600 场真实会议运行过，而不是沦为无人重读的录音。

## 相关模式（Related）

- `patterns/contradiction-extraction.md`
- `patterns/shadow-then-transform.md`
- `patterns/build-a-pattern-registry.md`
- `patterns/auditable-artifacts.md`
