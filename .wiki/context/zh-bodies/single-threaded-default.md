## 这是什么（What it is）

设计多步工作流时，本能的冲动是尽可能并行运行。请抵制这种默认冲动。单线程、线性排布的智能体（agent）——第一步完成，第二步才启动——远比并发扇出（fan-out）更容易推理、调试和修改。你能确切知道发生了什么、以什么顺序发生；你可以自上而下通读整条执行轨迹（trace）。出了问题时，故障位置是局部的，先前的上下文完好无损。并行会引入竞态条件（race condition）、冲突写入、交错的上下文以及复合的失败模式。这些问题可以解决，但解决它们要付出复杂度，而智能体系统中的复杂度倾向于层层叠加。在诉诸并行执行之前，先问一句：当前的瓶颈真的来自串行执行吗？许多情况下答案是否定的——瓶颈是 I/O 延迟、模型响应时间或人工评审周期，任何内部并发都解决不了它们。从线性开始，先度量（profile）再优化。

## 适用场景（When to reach for it）

- 在构建新工作流且尚未证明串行化是瓶颈时——从这里起步。
- 当工作流中的步骤存在隐式顺序约束时：第二步需要第一步的输出，第三步需要第二步的判断，沿链条依次类推。
- 当调试一个行为异常的多智能体系统时——先坍缩为线性执行以隔离故障，再重新引入并行。
- 当工作流运行频率低或延迟预算不紧时——并行编排的维护成本并不划算。

## 慎用场景（When NOT to）

- 当你有一组可证明相互独立的任务（输入相同、无共享状态、无顺序依赖），且串行执行的墙钟延迟（wall-clock latency）会实质性地影响结果或用户体验时——那才是并行的真正用武之地。
- 当任务结构相同且天然并行（embarrassingly parallel，例如对五十份文档运行同一分析）时——扇出是正确的模型，其编排模式也已有成熟共识。
- 当外部 I/O 操作占主导（多次 API 调用、文件抓取或搜索查询）而模型在空等结果时——此处的并发往往实现成本低、延迟收益高。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：建议从可能奏效的最简架构起步，只有在证据要求时才增加编排复杂度
- Amplifier — https://github.com/microsoft/amplifier — 该框架的 recipe 系统默认按顺序执行步骤；扇出与并行轨道是显式的可选项，而非基线
- Walden Yan，"Don't Build Multi-Agents"（Cognition，2025 年 6 月）— https://cognition.com/blog/dont-build-multi-agents — 明确主张将单线程线性智能体作为默认架构：这是遵循上下文共享与隐式决策原则的最简方式，并且『能带你走得很远』

## 相关模式（Related）

- `patterns/parallel-independent-tracks.md`
- `patterns/start-least-agentic.md`
- `patterns/autonomy-when-justified.md`
