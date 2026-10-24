## 这是什么（What it is）

设计与实现是认知上截然不同的活动。一个同时在想清楚要造什么、又动手去造的模型，往往做出孤立看合理、全局却不一致的决定——早期模块与后期模块设计风格各异，接口是摸索出来的而非规定出来的，代码刚写完设计就变了样，重构随即成为必需。两阶段模式把这两种活动拆成明确的智能体角色。架构师（architect）智能体接收目标并产出规格说明（specification）：模块边界、数据模型、接口契约、实现任务的先后次序。规格说明就是输出——不是代码。只有当规格说明完成并通过评审后，建造者（builder）智能体才开工。建造者严格按规格说明实现：它不重新设计；不改进它自认为欠佳的接口；不添加规格说明没有包含的特性。如果建造者发现规格说明不完整或自相矛盾，它将其作为一个发现上报，而不是通过实现上的选择悄悄消化掉。架构师与建造者被干净地分离，而正是这种分离维系着单智能体方式无法维持的纪律：你无法实现一个你尚未完成的设计。

## 适用场景（When to reach for it）

- 构建任何超过两三个模块的东西时——没有完整的设计环节，接口会随实现推进而漂移。
- 工作将由多个智能体或多名团队成员执行时——共享的规格说明确保每个建造者实现的是同一个设计。
- 范围足够含糊、实现者将不得不做非平凡设计决策时——这些决策属于架构师阶段，不属于实现阶段。
- 合并前需要质量评审时——规格说明给了评审者一个可对照实现来检查的靶子，而不必要求评审者从代码里逆向工程出原本的设计意图。

## 慎用场景（When NOT to）

- 任务是单个自包含的变更、没有实质设计面时——给既有函数加一个参数、修一个理解透彻的组件里的 bug——架构师阶段不增加任何价值，只会拖慢交付。
- 用户或利益相关方已经提供完整规格说明时——架构师阶段已完成；直接进入建造者。
- 工作流是探索性的、设计必须从实现中浮现时——有些问题无法预先完全规格化；严格的两阶段拆分会在规格说明里强行制造虚假的具体性。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier-foundation — 基础智能体名册明确区分 zen-architect 智能体（以无情的简洁做系统设计）与 modular-builder 智能体（按规格说明构建代码）；设计出自一个角色，实现出自另一个
- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：描述 orchestrator-workers 工作流——中央模型把复杂任务拆成子任务并委派给工人，以及智能体可暂停等待人类反馈的检查点（checkpoint）；架构师-建造者拆分把这种分解变成显式的角色分离
- Harper Reed — https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/ — 《My LLM codegen workflow atm》：实践者自述的三阶段 规格→计划→执行 LLM 代码生成工作流（先产出 spec.md，再 prompt_plan.md + todo.md，然后执行）；普及了先完成设计再碰实现的纪律
- Wang et al., "Plan-and-Solve Prompting: Improving Zero-Shot Chain-of-Thought Reasoning by Large Language Models" (arXiv:2305.04091) — https://arxiv.org/abs/2305.04091 — 经典先声：把『先计划后执行』形式化为一种提示策略，表明把『制定计划』与『执行计划』分开能减少错误；架构师-建造者拆分在提示词层面的认知基础

## 相关模式（Related）

- `patterns/bite-sized-tasks.md`
- `patterns/gate-the-phases.md`
- `patterns/proposer-authority-separation.md`
- `patterns/composable-patterns.md`
