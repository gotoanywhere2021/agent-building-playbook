## 这是什么（What it is）

agent 工作流分布在一个从轻量到重量的频谱上，频谱上的每个点对某些工作都是正确答案，对其余工作则是错误答案。一次性提示（one-shot prompt）最适合微小任务、原型、局部修改和点子发散，当你过度信任背后没有任何持久状态的貌似合理的输出时它会失败。slash-goal 或 Ralph 循环适合目标清晰、歧义适中、你只想要一次简单自主推进的场景，它的失败方式是缺少足够检查点地跑得太久。技能驱动（skill-driven）的工作流捕捉可复用的、人类形态的过程——头脑风暴、规划、评审、实现——当技能隐藏了复杂性、或者过时、过宽时它会失败。图（graph）工作流适合规划、执行、验证、反馈可分离的多阶段工作，它的失败方式是要求重型的搭建，最终变成一个以维护测试装置（harness）为业的项目。层级式 agent 组织处理需要众多子 agent、专家角色和长期监督的大型计划，失败于注意力过载、问责不清和过度的 token 消耗。工作室（studio）或生产系统适合复杂、创造性的高混合度工作——每个项目都不同但复用角色与工具——缺乏强有力的人类方向和良好的产物纪律时会失败。选择标准是失败的代价、意图的清晰度、工作的规模和可重复的程度——纪律在于刻意选择，而不是按习惯或时尚。两个失败方向让这条纪律变得具体：显而易见的一个是简单循环就够时伸手去拿重型图；更隐蔽的反面是，团队见识过重型工具之后常常退化成逐个功能的临时提示，因为一次性提示的小奖励是即时的，而结构的回报是延迟的。两者都是缺乏意图性的失败——是工作、而不是多巴胺，来挑选拓扑（topology）。

## 适用场景（When to reach for it）

- 任何新工作流开始时，在伸手去拿你上次用的拓扑之前——按四个标准挑选，而不是按肌肉记忆。
- 当一个工作流不断超时或烧 token：你可能重了一个档位，应当降到更轻的拓扑。
- 当一个轻量循环不断产出错误但貌似合理的输出、且没有任何状态可检查：你轻了一个档位，应当增加结构。
- 当工作可重复到值得被编码——把它从临时提示提升为技能（skill）或图。
- 为团队方法制定标准时：显式命名拓扑，让人们停止无意识的默认。

## 慎用场景（When NOT to）

- 真正的一次性工作：任何关于拓扑的斟酌都比直接跑一次性提示更贵。
- 团队没有余力维护重型测试装置（harness）时——一个你养不起的图或工作室，比一个你养得起的循环更糟。
- 作为过度架构化的借口：如果简单循环就够，建图就是失败模式，而不是目标。

## 实例（Exemplars）

- Hadfield et al. / Anthropic — https://www.anthropic.com/engineering/multi-agent-research-system — How we built our multi-agent research system：区分受益于多 agent 并行（广度优先研究）的任务与需要共享顺序上下文的任务（大多数编码工作），让拓扑与工作的匹配变得具体且有实证支撑。
- Walden Yan / Cognition — https://cognition.com/blog/dont-build-multi-agents — Don't Build Multi-Agents：论证并行子 agent 在相互依赖的工作上会失败，因为行动携带隐式决策，冲突的决策导致糟糕结果；主张对这类负载使用拥有完整上下文的单个顺序 agent。
- Cemri et al., "Why Do Multi-Agent LLM Systems Fail?" (arXiv:2503.13657) — https://arxiv.org/abs/2503.13657 — 对 7 个多 agent 系统框架中 14 种失败模式的实证分类；许多失败可追溯到拓扑与任务的错配（系统设计问题与 agent 间失配两类）。
- Yarmohammadtoosky & Xie, "LLM-Powered Multi-Agent Systems: A Survey of Collaboration and Learning Strategies" (ICAIDS '26) — https://dl.acm.org/doi/10.1145/3806262.3806263 — 形式化：把协作结构（分层式、集中式、去中心化、定制）与任务匹配的分类学，交互策略（合作、竞争、辩论、混合）与学习方法（人在回路、强化学习、自我改进、微调、迭代交互）构成另外两条轴

## 相关模式（Related）

- `patterns/recipe-not-conversation.md`
- `patterns/shape-work-as-an-attractor.md`
- `patterns/start-least-agentic.md`
- `patterns/self-ablating-harness.md`
