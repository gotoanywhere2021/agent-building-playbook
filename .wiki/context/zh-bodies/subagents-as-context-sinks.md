## 这是什么（What it is）

编排者（orchestrator）在自己上下文里处理的每一项任务都会累积 token：工具调用、中间推理、冗长的输出、失败的分支。经过长工作流，这种累积会削弱编排者对全局的推理能力——早期决策被近期的噪音挤占，窗口里塞满了只与某个已完成子任务相关的内容。把子智能体（sub-agent）用作上下文汇聚点（context sink）反转了这一动态：当一项任务细节繁重、但其产出是清晰的产物（artifact）或摘要时，把它整个委托给一个全新的智能体。该智能体以空的上下文窗口运行，吸收子任务的全部细节，只返回结果——一个文件路径、一份结构化摘要、一个通过/失败判定、一个生成的产物。编排者的上下文累积的是摘要，而不是过程记录（transcript）。细节从此永远离开编排者的账本。这首先不是性能优化；它是一个关于认知架构的决策——编排者需要记住什么，才能对下一步做出好的决策。

## 适用场景（When to reach for it）

- 当子任务有清晰、可表达的输出，但执行路径复杂（文件分析、代码评审、研究、综合）时——委托它，接收输出而非过程。
- 当编排者在中途接近上下文上限时——找出下一个重活，在上下文进一步膨胀之前路由给子智能体。
- 当同一类子任务在多个步骤中反复出现（评审 N 个文件、处理 N 条记录）时——每个实例都是独立的上下文汇聚点；任务相互独立时可并行。
- 当子任务的错误或失败不应把重试循环与诊断输出污染进编排者上下文时——把失败隔离在子智能体内，接收一份结构化失败报告，在编排者层面决定如何处置。

## 慎用场景（When NOT to）

- 编排者必须对子任务的执行细节而非仅仅结果进行推理的任务——某些调试或探索性任务要求编排者看到中间步骤，而不只是结果。
- 子任务琐碎之极时——为一次文件读取或一行变换创建子智能体，只增加延迟与协调成本，没有上下文收益。
- 子任务的结果大到返回给编排者的摘要几乎与在编排者自身上下文里运行一样贵时——先做压缩（compress），再在『留在上下文内』与『委托执行』之间选择。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：描述了编排者-工作者（orchestrator-workers）模式——中央 LLM 动态拆解任务、委托给工作者 LLM 并综合结果——这种委托隐含地为每个工作者的上下文设置了边界
- Amplifier — https://github.com/microsoft/amplifier — task 工具正是为这一模式而设计：它派生一个子会话，运行自己的编排循环，在独立上下文中吸收工作，再把结果返回给调用会话
- Anthropic — https://www.anthropic.com/engineering/multi-agent-research-system — 出处：明确把子智能体描述为上下文压缩机制——『子智能体通过在各自的上下文窗口中并行运行来促进压缩……然后再为核心研究智能体提炼出最重要的 token』
- LangChain Team — https://www.langchain.com/blog/context-engineering-for-agents — 正式化：把『隔离（isolate）』列为上下文工程的四大动作之一；跨智能体或跨环境分割上下文，正是阻止编排者累积的机制
- Yan，"Don't Build Multi-Agents" — https://cognition.com/blog/dont-build-multi-agents — 反方观点：认为决策分散到多个子智能体会以导致不一致的方式割裂上下文；请与『慎用场景』中关于需要共享中间状态的任务的判据对照阅读

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/thin-pointers.md`
- `patterns/start-least-agentic.md`
