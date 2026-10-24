## 这是什么（What it is）

每条多阶段 AI 流水线都混合着不同任务类型：有些阶段需要深度推理、细腻判断或创造性综合；另一些是机械性的——解析、分类、格式化、抽取、路由决策。把所有阶段一视同仁、全部跑在最强大（也最昂贵）的模型上，并不是保守的选择——而是浪费：它通常不会让机械阶段的产出变得更好，却让成本随任务数线性膨胀。本模式是把每个阶段的认知需求映射到合适的模型档位。高风险的推理阶段——评估含糊的需求、综合相互冲突的证据、做架构决策——值得用最强的模型。机械阶段——从格式良好的输入中抽取结构化字段、重排输出格式、把请求归入已知分类——可以交给一个快速、便宜的模型而不损失质量。对每个阶段的校准问题不是『我们手里有哪个模型？』，而是『在这里能产出可接受结果的最低能力档位是什么？』在每个阶段运行恰好够用的模型不是妥协，而是正确的工程决策。

按阶段路由模型常被框定为省钱手段，它确实省钱——但更深层的理由是：分配给某个角色的模型塑造了该角色的行为方式，这让路由成为一个关于工作流本身的设计决策。典型角色图中的每个角色需要不同类型的模型：

| 角色 | 模型选择模式 |
|---|---|
| **规划者（Planner）** | 当跨整个任务的全局连贯性重要时，用更强、更贵的模型。 |
| **执行者（Executor）** | 结构已定、范围清晰时，用更便宜或更快的模型做实现。 |
| **评审者（Reviewer）** | 选与实现者*不同*的模型家族，以减少共享盲区。 |
| **批评者（Critic）** | 对抗性框架、全新上下文或多个模型——独立性才是目的。 |
| **摘要者（Summarizer）** | 输出有界且结果在下游被校验时，用更便宜的模型。 |
| **研究者（Researcher）** | 具备检索、浏览或大上下文窗口的模型或工具。 |

最容易出错的是评审者与批评者两行：把它们路由给做这项工作的*同一个*模型，省不下什么有意义的东西，还会悄悄毁掉让评审值得进行的独立性。在那里选择不同的家族，是一个披着成本路由外衣的工作流决策。

## 适用场景（When to reach for it）

- 设计包含不同任务类型的多步流水线时——在设计期识别哪些阶段是推理密集型、哪些是机械型，然后相应分配模型档位。
- 当流水线的推理成本令人担忧时——先审计每个阶段的模型分配，再优化代码；模型档位错配是不必要成本最常见的来源。
- 当一条高成本流水线的产出并不比低成本等价物更好时——这往往说明昂贵模型被用在了吃不到额外能力的阶段。
- 在少量模型档位（如快速、标准、推理）之间依据轻量分类器路由时——分类器本身跑在便宜模型上，其路由决策决定后续阶段的模型档位。

## 慎用场景（When NOT to）

- 阶段边界不清或任务类型在阶段内不可预测地变化时——切换模型的开销与路由复杂度可能超过省下的成本。
- 工作流偶尔才运行、推理成本与预算无关时——分层路由的工程复杂度撑不起绝对值很小的节省。
- 当机械阶段上的模型能力差异会产生重要的正确性差异时——有些『机械』任务对能力比看起来更敏感；降级前先验证。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：建议把简单或常见的问题路由给更小、更省的模型，把困难或罕见的问题交给更强的模型——按任务类型选择，而非一个全局选择。
- Amplifier — https://github.com/microsoft/amplifier-bundle-routing-matrix — agent 声明一个语义化的 model_role，把路由意图（『这里需要推理能力』）与被指派的具体模型解耦；routing-matrix bundle（13 个语义角色、8 套精选矩阵）通过外部配置把每个角色解析为某个提供商与模型，实现逐阶段路由而不硬编码模型名。
- Chen, Zaharia & Zou, "FrugalGPT: How to Use Large Language Models While Reducing Cost and Improving Performance" (arXiv:2305.05176) — https://arxiv.org/abs/2305.05176 — 经典先例：提出 LLM 级联（cascade）这一把不同类型查询路由到合适尺寸模型的经典表述；演示了成本降低 98% 同时匹配 GPT-4 性能，确立了按阶段选模的经济学论证。
- Ong et al., "RouteLLM: Learning to Route LLMs with Preference Data" (arXiv:2406.18665) — https://arxiv.org/abs/2406.18665 — 形式化：训练在推理时动态在强弱 LLM 之间选择的路由器；路由器可跨模型替换泛化，验证了路由策略可以与具体模型身份解耦。
- Anthropic Engineering, "How we built our multi-agent research system" — https://www.anthropic.com/engineering/multi-agent-research-system — 实证支持：生产部署按阶段路由——Opus 4 做协调者，Sonnet 4 做子 agent——把编排交给最强档位，把并行执行交给更便宜的一档。
- 2389 Research, thrifty — https://github.com/2389-research/thrifty — 一方实践（first-party）：『把每一轮工作（sprint）下放给能正确完成它的最弱模型』规则下的分层委派——一个规划模型把规范写成自包含的 sprint，一个便宜模型执行并对每个 gate 自我验证，公开基准显示以约低 64% 的成本达到与强模型相同的 gate 质量。

## 相关模式（Related）

- `patterns/role-based-routing.md`
- `patterns/delegation-token-economics.md`
- `patterns/start-least-agentic.md`
- `patterns/invest-the-expensive-model-in-the-harness.md`
- `patterns/adversarial-parallel-review.md`
