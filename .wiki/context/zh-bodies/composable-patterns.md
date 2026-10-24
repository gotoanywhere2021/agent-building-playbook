## 这是什么（What it is）

编排（orchestration）逻辑有一种长成不可维护的过程式代码的倾向：if-else 树嵌在循环里、循环嵌在回调里，工作流状态作为可变变量层层穿线。另一条路是用一小组命名的编排原语（primitive）——顺序（sequence）、条件（conditional）、扇出（fan-out）、扇入（fan-in）、循环（loop）、门禁（gate）——来构建，把任何工作流表达为这些模式的组合，而不是定制逻辑。顺序按次序运行步骤；条件依据前一步的输出分支；扇出生成并行的工作者（worker）；扇入等待并行工作者完成并聚合其结果；循环反复运行某一步骤直到条件满足；门禁在继续之前等待人工批准。这些不是特殊用途的构造——它们就是编排的词汇表。任何工作流都可以表达为这些模式的树；以这种方式表达的工作流，任何懂得这套词汇的人都能阅读、修改和调试。它还能通过把某个模式的实现替换为测试替身（test double）来测试，因为每个原语彼此隔离。反之，当编排被写成定制的过程式代码时，每个新工作流都是一门新语言，每次调试都要从头理解这门语言。

## 适用场景（When to reach for it）

- 设计超过三四步的新工作流时——先识别需要哪些编排模式，把结构表达为这些模式的组合，然后再写代码。
- 现有工作流的控制流不清晰时——通过抽取可辨认的模式（循环、条件、门禁）并使其显式化来重构。
- 构建工作流创作层或 DSL（领域专用语言）时——从一小组可组合的原语出发，而不是一个庞大的功能集；原语的组合足以覆盖复杂情形。
- 向新成员介绍某个工作流时——表达为组合原语的工作流可以用原语词汇来讲解，而无须逐步走读定制代码。

## 慎用场景（When NOT to）

- 工作流只有一两步时——对并不真正复杂的工作流而言，组合的开销不值得。
- 现有编排系统自带一组固定、不能自由组合的原语时——此时应在系统自身的模型内工作，而不是在其上再发明一层平行的组合层。
- 性能要求控制流紧耦合、开销必须最小时——可组合模式带有抽象成本，在热点循环（hot loop）中这笔成本可能要紧。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier-bundle-recipes — 其 recipe YAML 格式暴露了可组合原语（顺序步骤、foreach 循环、requires_approval 门禁），让复杂工作流能以组合的方式声明式表达
- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：点名五种工作流原语（提示词链（prompt chaining）、路由（routing）、并行化（parallelization）、编排者-工作者（orchestrator-workers）、评估器-优化器（evaluator-optimizer））作为可组合的构建块，生产级智能体系统由它们组装而成
- Huang 与 Zhou，《A Two-Dimensional Framework for AI Agent Design Patterns: Cognitive Function and Execution Topology》（arXiv:2605.13850）— https://arxiv.org/abs/2605.13850 — 形式化：定义了六种执行拓扑原型（链（Chain）、路由（Route）、并行（Parallel）、编排（Orchestrate）、循环（Loop）、层级（Hierarchy）），与本模式所述的可组合编排原语直接对应；并提出将拓扑与认知功能组合而成的 7×6 矩阵，得到 28 个命名模式

## 相关模式（Related）

- `patterns/workflows-vs-agents.md`
- `patterns/three-primitives.md`
- `patterns/gate-the-phases.md`
- `patterns/recipe-not-conversation.md`
