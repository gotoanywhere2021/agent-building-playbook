## 这是什么（What it is）

一个做着重要工作却不留任何记录的系统就是黑箱。事后从输出反推——试图从现存的东西推断发生过什么——是考古（archaeology），不是可观测性（observability）。在关键时刻发出结构化事件（structured event），就是让系统讲述自身执行的实践：工具调用完成时，发出一条带输入和输出的完成事件；走了某个决策分支时，发出一条带决策依据的决策事件；发生重试时，发出一条带失败原因的重试事件。这些事件不是日志行——它们是带类型的结构化记录，携带足以在事后重建系统推理的信息。关键差别在意图：日志行是写给开发者的便条；事件是系统的一等输出，其设计目的就是被其他系统、智能体、仪表盘和分析管道消费。会发出事件的智能体（agent）是可观测的；只会往 stdout 打印的智能体只能靠猜。

## 适用场景（When to reach for it）

- 在每一次重要的状态转换处：会话开始、会话结束、任务分配、任务完成、交接、失败、重试。每个对理解本次运行有意义的转换都应产生一条记录。
- 当做出影响后续行为的决策时：走了哪个分支、选了哪个工具、选了哪个模型。没有记录的决策是不可见的。
- 当发起外部调用时：工具调用、API 调用、数据库写入。记录输入、输出、延迟和结果。外部调用是价值最高的事件，因为它们是系统与世界交互的接触点。
- 当构建任何将无人值守运行的管道（pipeline）时：没有事件流的无人值守系统一旦失败便无法诊断。对自主运行而言，事件发出不是可选项。
- 当设计多智能体系统中智能体之间的交接时：一个智能体执行所产生的事件，就是下一个智能体的工作记忆，也是编排器（orchestrator）的审计线索。

## 慎用场景（When NOT to）

- 当事件量在不加过滤的情况下会压垮下游消费者时：以合适的粒度发出。把推理输出的每个 token 都发成事件不是可观测性——那是掩盖信号的噪音。
- 当事件包含不应被持久化的敏感数据时——凭证、个人身份信息（PII）或安全令牌不应出现在事件载荷中。发出前先清洗，或使用结构化脱敏。
- 当系统确实短命、用完即弃、其行为永远无需分析时——但对这一判断要诚实；大多数看似用完即弃的系统，事后都被证明有重要后果。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier — 事件优先的可观测性：『重要的事情就发出事件』——智能体的重要动作发出结构化事件，写入带追踪 ID 以便关联的 JSONL 事件日志（依据 Amplifier 团队的白皮书；在公开仓库中，amplifier-foundation 的 session-analyst 智能体正是基于这些 events.jsonl 流工作）
- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：建议智能体在每一步从环境获取『真值（ground truth）』——工具调用结果、代码执行输出——以评估进展；这是在每个转换处做结构化事件捕获的理由
- Martin Fowler, "Event Sourcing" — https://martinfowler.com/eaaDev/EventSourcing.html — 经典先例：2005 年软件工程的规范表述：『把应用状态的所有变更捕获为事件序列』；本模式直接呼应的经典软件工程模式，涵盖重建、时序查询与审计能力
- AlSayyad et al., "AgentTrace: A Structured Logging Framework for Agent System Observability" (arXiv:2602.10133) — https://arxiv.org/abs/2602.10133 — 形式化：为 LLM 智能体跨运营、认知与情境层面的结构化事件捕获建立形式体系；将本模式直接实现为安全、问责与实时监控的基础层

## 相关模式（Related）

- `patterns/awareness-layer.md`
- `patterns/real-environment-execution.md`
- `patterns/session-archaeology.md`
