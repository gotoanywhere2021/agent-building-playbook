## 这是什么（What it is）

在编排代码里硬编码模型名会制造脆弱的依赖：每当供应商发布更好的模型、弃用旧模型或调整定价，代码库里的每一处引用都得更新。本模式把路由意图与模型身份解耦：把能力需求表达为具名角色——『快速』『推理』『写作』『编码』——并在运行时依据受管配置（provisioned configuration）把角色解析为具体模型名。调用代码表达的是需要什么（『这里需要一个有推理能力的模型』），而不是哪个模型满足这个需要。配置把角色映射到该能力档位当前最好的模型。当更好的模型可用、或更便宜的等价物覆盖同一角色时，改变的是配置，而不是调用代码。这种分离还支持按环境覆写：开发环境可以把所有角色映射到一个便宜的模型；生产环境可以把每个角色映射到该档位的最优选择。角色是稳定身份。模型是实现。

## 适用场景（When to reach for it）

- 当流水线使用多于一个模型档位——在设计期定义角色，让配置驱动到实际模型的映射。
- 当模型变化频繁（新发布、弃用、定价调整）——基于角色的路由意味着变更是配置更新，不是代码变更。
- 当同一工作流在不同成本约束的环境中运行——按环境把角色映射到不同模型，不碰流水线逻辑。
- 当团队想试验模型替换（A/B 测试、成本基准测试）——改一个角色映射是一次配置编辑，不是代码重构。

## 慎用场景（When NOT to）

- 当任务对某个模型独有的能力有硬性要求、角色内没有其他模型可替代——直接选择模型可能更必要，好让约束显式呈现而不是藏在角色背后。
- 当流水线是简单的单模型工作流，角色配置的开销徒增复杂而无收益。
- 当模型选择必须在请求时依据配置无法预见的输入动态决定——基于角色的路由假设角色在调用点可静态确定。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier-bundle-routing-matrix — 声明式模型路由：智能体声明一个描述自身职能的语义 model_role，外部管理的矩阵（13 个语义角色、8 份精选矩阵）在运行时把每个角色解析为供应商与模型——调用方表达能力需求而非模型名，路由变更不触碰编排代码
- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：把按任务类型选择模型视为智能体流水线的一等设计决策；把选择决策从调用代码中解耦是该建议的自然延伸
- Chen, Zaharia & Zou, "FrugalGPT: How to Use Large Language Models While Reducing Cost and Improving Performance"（arXiv:2305.05176）— https://arxiv.org/abs/2305.05176 — 经典先例：引入跨不同能力档位模型的成本感知路由与级联——稳定能力角色在配置中操作化的经济学依据
- Ong et al., "RouteLLM: Learning to Route LLMs with Preference Data"（arXiv:2406.18665）— https://arxiv.org/abs/2406.18665 — 形式化：在测试时底层模型变化仍能泛化的学习型路由策略，实证验证了本模式主张的稳定角色 / 可替换模型分离

## 相关模式（Related）

- `patterns/match-model-to-stage.md`
- `patterns/delegation-token-economics.md`
- `patterns/start-least-agentic.md`
