## 这是什么（What it is）

委派（delegation）不是免费的。当编排器（orchestrator）生成（spawn）一个子智能体（subagent）时，它要花 token 构建简报（briefing），为子智能体的完整执行付费（包括它自己的上下文、推理与输出），然后还要再付一次，把结果消费回编排器的上下文。委派的决策始终是一次 token 支出——问题在于，相对于在编排器自己的上下文里执行这项工作，这笔支出是不是最便宜的完成方式。对短小、机械的任务，委派开销可能超过直接在行内（inline）完成的成本；对冗长、细节繁重的任务，委派几乎总是更便宜，因为它防止编排器的上下文被过程性内容塞满——这些内容在任务完成后就无关紧要了。经济模型是：当（简报成本 + 子智能体执行成本 + 结果摄取成本）<（在编排器上下文中运行任务的成本 + 被消耗上下文 token 的机会成本）时委派。明确理解这个取舍可以避免两种失败模式：过度委派——编排器为琐碎小任务生成子智能体、白付开销没有收益；以及委派不足——编排器把一切都放在行内跑，耗尽上下文，随着窗口塞满无关细节而质量退化。

## 适用场景（When to reach for it）

- 设计多智能体流水线（pipeline）时，为每个委派决策建模其 token 经济：估算简报大小、预期子智能体成本与结果大小，并与行内执行的成本比较。
- 当任务的执行会产生编排器并不需要的大量中间细节——日志行、中间推理、冗长的工具输出——而委派能把这些细节完全挡在编排器上下文之外时。
- 在三个任务用并行子智能体跑还是按序行内跑之间做选择时——并行选项在墙钟时间（wall-clock）上可能更便宜，但每个子智能体都要付自己的上下文启动成本；先核实经济账，再默认并行委派总是更好。
- 当子智能体可以用比编排器更便宜的模型时——模型档位的节省可能抵过委派开销，使得即使本可行内执行的任务，委派在经济上也更优。

## 慎用场景（When NOT to）

- 任务琐碎至极（一次查找、一行变换）时——委派开销占主导，行内执行在 token 与延迟上都更便宜。
- 让子智能体进入状态所需的简报几乎和编排器当前上下文一样大时——没有上下文节省，开销纯属浪费。
- 子智能体返回的结果必须被编排器全量消费时——如果编排器需要子智能体产出的每一个 token，委派没有任何上下文收益，只剩开销。
- 工作流运行在对成本不敏感、token 经济不约束设计的环境中时——这种情况优先简洁，而非经济效率。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier — delegate() API 是进行 token 经济委派决策的主要机制；context_depth 参数控制简报成本（none = 最小简报，all = 完整历史简报），model_role 参数控制子智能体执行成本；两者都显式化，促使工程师推敲每次委派调用的经济账（依据 Amplifier 团队的白皮书；delegate() API 及其参数在当前公开仓库中并不可见）
- Anthropic Engineering，《How we built our multi-agent research system》— https://www.anthropic.com/engineering/multi-agent-research-system — 实证支持：量化多智能体委派开销的生产数据（智能体消耗的 token 约为聊天的 4 倍；多智能体流水线约 15 倍）；说明只有任务价值足够高，才值得支付委派成本

## 相关模式（Related）

- `patterns/match-model-to-stage.md`
- `patterns/role-based-routing.md`
- `patterns/subagents-as-context-sinks.md`
- `patterns/context-is-finite.md`
- `patterns/clean-slate-delegation.md`
