## 这是什么（What it is）

奔向完全自主、长时间运行循环和多智能体编排的吸引力很强——而且通常是过早的。大多数需要自主智能体（agent）的问题，实际上只需要一次结构良好的 LLM 调用：提示词（prompt）写得规整、模型选得合适、输入质量够好。从最不具智能体特征（agentic）的选项开始：一次直接调用，没有循环、没有工具、没有编排。只有当你有证据表明更简单的方案无法弥合差距时才增加复杂度，而且一次只加一步，而不是直接跳到最自主的架构。

## 适用场景（When to reach for it）

- 设计新工作流时：在诉诸智能体之前，先问一次精心打磨的提示词能否解决问题。
- 当智能体循环已经存在、而你解释不清为什么单次调用方案会不够用时。
- 当多智能体系统持续失败或产出不稳定时——问一句：把它坍缩为更少、更可靠的步骤是否有帮助。
- 作为成本与延迟的启发式：每增加一个智能体步骤，延迟、成本与故障面都会相乘；从零开始，只添加被证明必要的东西。

## 慎用场景（When NOT to）

- 内在地需要迭代反馈的任务（代码执行、带结果检查的工具使用、与外部系统的多轮协商）——这些确实受益于智能体循环。
- 超出单个上下文窗口（context window）容量、且不丢失关键状态就无法容纳的长程任务——多步方案在这里是结构上必需的，而非偏好。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：明确建议从最简单的基于提示词的方案起步，只有当更简单的方案被证明不足时才升级到智能体
- Amplifier — https://github.com/microsoft/amplifier-bundle-recipes — 以 YAML 步骤声明的工作流，分阶段执行，带审批门（approval gate）与自动检查点（checkpoint）——确定性的、预先定义的编排，可在授予智能体开放式自主权之前先采用
- Ward Cunningham，"The Simplest Thing That Could Possibly Work"（Artima，2004）— https://www.artima.com/articles/the-simplest-thing-that-could-possibly-work — 经典先例：XP 的原则——总是先尝试最简可行方案，只有当简单版本明显失败时才增加复杂度
- Simon Willison — https://simonwillison.net/2024/Dec/20/building-effective-agents/ — 从业者评论，强调五种工作流模式是诉诸智能体之前的中间步骤；『找到可能的最简方案，只在需要时才增加复杂度』

## 相关模式（Related）

- `patterns/reliability-before-features.md`
- `patterns/code-is-cheap-maintenance-isnt.md`
