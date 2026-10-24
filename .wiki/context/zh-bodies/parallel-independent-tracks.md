## 这是什么（What it is）

独立任务——没有顺序依赖、没有共享可变状态的任务——才是并行执行的真正适用场景。当协调者（orchestrator）手头有一组任务，每个都需要独立的上下文窗口、且互不依赖彼此的输出时，顺序运行是纯浪费：协调者等每个任务完成才开始下一个，而算力闲置。正确的模式是把所有独立任务同时派发，然后等待全部结果再继续。这不是过早优化；对任何非平凡的独立任务集，墙钟加速与任务数呈线性关系。关键纪律是派发之前验证独立性。两个任务独立，当且仅当：任务 B 不需要任务 A 的任何输出；任务 A 与任务 B 不写同一个共享资源；它们的结果以何种顺序整合无关紧要。以上任何一条不成立，任务就不独立，必须顺序执行。并行编排最常见的失败模式是断言了不存在的独立性——因为任务看起来彼此分开就宣告它们并行，然后跑到一半才发现它们共享一个文件、一行数据库记录或一个上下文假设。独立性必须在派发前验证，不能假设。

## 适用场景（When to reach for it）

- 协调者要在同一输入上运行三个或以上分析任务（例如对同一文件做三种不同类型的代码评审）——全部可以同时启动。
- 协调者在决策前需要从多个独立来源收集信息——并行派发所有查询，然后聚合。
- 在不共享状态的多个模块上运行测试——并行派发测试 agent，等待全部结果。
- 当单任务延迟由模型响应时间或外部 I/O 主导——并行性回收了大部分墙钟成本。

## 慎用场景（When NOT to）

- 任务间存在任何依赖——如果任务 B 需要任务 A 的输出才能形成自己的输入，就必须顺序运行。
- 任务写共享可变资源且没有冲突检测机制——无协调的并发写入会损坏状态。
- 并行 agent 数量将超出资源限制（速率限制、API 配额、系统并发上限）——对扇出（fan-out）节流以留在边界内。
- 总算力成本比墙钟延迟更重要时——并行执行消耗与顺序相同的算力，只是更快；如果算力预算才是约束，并行帮不上忙。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：把并行化列为核心编排模式，尤其适用于可拆分为独立子任务的情形。
- Amplifier — https://github.com/microsoft/amplifier — recipe 默认顺序运行迭代集，并发执行是显式的可选项（parallel: true），保留给真正独立的任务集。
- Hadfield et al. / Anthropic — https://www.anthropic.com/engineering/multi-agent-research-system — How we built our multi-agent research system：实证案例研究，并行子 agent 各自探索独立研究流，相对单 agent 取得 90.2% 的性能提升；作者明确指出这一优势在可并行单元较少的编码任务上会减弱。

## 相关模式（Related）

- `patterns/single-threaded-default.md`
- `patterns/composable-patterns.md`
- `patterns/architect-then-builder.md`
- `patterns/build-five-to-throw-away.md`
