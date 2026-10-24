## 这是什么（What it is）

正在执行任务的智能体（agent）无法同时评估任务是否正在走偏。工作智能体的注意力被任务占满；它在自身计划的语境里解读每一步，因而对跨越多步的模式在结构上失明——目标的渐进漂移、每次迭代都以不同说辞自我合理化的反复失败、自第三步起一路攀升的资源指标。感知层（awareness layer）是从执行上下文之外注视主智能体的第二观察者：它读取事件流、监控指标、把当前状态与预期轨迹对比，在差距变得显著时介入。这不是工作流意义上的监督者——它不指挥智能体的下一个动作。它是一名哨兵：一个站在不同观察点、带着不同议程的进程，唯一的职责是注意那些工作智能体所处位置注意不到的事情。感知层是让长时间自主运行变得可恢复的东西。没有它，智能体要么跑到成功、要么耗尽资源，没有任何机制去捕获『自信地朝着错误方向前进』的情形。

## 适用场景（When to reach for it）

- 智能体将在错误会复利的任务上运行超过几步时：检查中间状态的观察者能在问题尚可挽回时抓住它。
- 主智能体有已知的偏差或盲区时：专注于生成步骤的规划智能体，受益于一个检查生成步骤是否偏离原意的观察者。
- 资源消耗要紧时：监控 token 用量、API 调用次数或墙钟时间的感知层，能在失控的工作造成损害之前将其打断。
- 构建无人值守长期运行的系统时：人类操作者无法持续盯着；自动化的感知层就是替代品。
- 系统的失败模式是『静默成功』——无错完成却产出错误结果：独立验证输出属性的观察者能抓住这一类失败。

## 慎用场景（When NOT to）

- 任务很短、整个执行在一个上下文窗口内即可观察——感知层的价值来自其外部观察点；对短任务，这个观察点并不需要。
- 添加观察者会使一个预算紧张、失败模式本就廉价且可见的任务的算力成本翻倍——感知层是投资；不是每个任务都值得。
- 观察者本身引入的复杂度超过它解决的那部分——规格不清、误报或打断正确工作的感知层，比没有观察者更糟。从监控起步，而非从干预起步。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier-foundation — session-analyst 智能体：一个专职观察者，分析会话事件流（events.jsonl）、诊断失败、检索会话历史——从执行智能体上下文之外，暴露它们自身无法观察到的模式
- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：为长时间运行的智能体任务推荐人在回路（human-in-the-loop）检查点与监控，作为智能体无法自我提供的一种感知
- Sinha et al., "Training Deliberative Monitors for Black-Box Scheming Detection" (arXiv:2605.29601) — https://arxiv.org/abs/2605.29601 — 训练小型外部监控模型，仅凭轨迹就能检测智能体的密谋（scheming），无需访问内部推理；这是感知层作为执行智能体上下文之外独立观察者的一个具体实现
- Dong et al., "AgentOps: Enabling Observability of LLM Agents" (arXiv:2411.05285) — https://arxiv.org/abs/2411.05285 — 跨智能体生命周期、为监控与异常检测而需追踪的工件分类学；定义了感知层所依赖的可观测性基础设施

## 相关模式（Related）

- `patterns/emit-events.md`
- `patterns/session-archaeology.md`
- `patterns/real-environment-execution.md`
