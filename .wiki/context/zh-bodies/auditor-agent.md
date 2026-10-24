## 这是什么（What it is）

当一个任务由智能体完成，该智能体对自己输出的验证在结构上就已受损：它用以推理的假设、偏差与上下文，正是产出原始工作的那些。被置于审计者（auditor）角色的第二个智能体没有这些锚点。它冷读（cold read）工件——不带导致其产生的决策史——并独立判断输出是否符合规格说明、要求的步骤是否真的执行了、成功的断言是否有证据支撑。审计者智能体不被要求重做工作；它被要求对照既定要求验证工作的产出。角色的分离正是让验证有意义的机制。

## 适用场景（When to reach for it）

- 任何失败会造成显著下游代价的高风险流水线步骤——在输出被下一阶段消费之前，加入一个审计者智能体。
- 某个智能体有虚报完成的前科时——审计者能系统性地暴露这一模式，而不是一例一例地抓。
- 任何不可逆操作之前（部署、发送、删除、发布）——先经过一个审计者智能体。
- 实现多智能体工作流时：把审计者角色作为编排（orchestration）的一部分显式设计，而不是事后补丁。
- 需要合规或问责时：审计者智能体的裁定成为审计轨迹（audit trail）。

## 慎用场景（When NOT to）

- 输出无需推理即可机器检查的简单确定性步骤（如文件存在、测试通过、HTTP 状态 200）——用确定性验证器（verifier），不要用智能体。
- 紧张的交互循环，第二个智能体调用的延迟超出可接受的反馈周期——在检查点使用审计者智能体，而非每个微步骤。
- 审计本身就是利益冲突时（相同的模型、上下文、提示词）——第二个智能体必须真正独立，验证才有意义。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：描述 evaluator-optimizer 工作流——一个模型生成、另一个在循环中按标准评估——把生成与评估分开以提升输出质量
- Amplifier — https://github.com/microsoft/amplifier-bundle-superpowers — superpowers 包自带专门的 spec-reviewer 与 code-quality-reviewer 智能体，作为实现者智能体下游的审计角色；spec-reviewer 的唯一职责是评估实现是否符合其规格说明，检查工作本身而非实现者的自我汇报
- Huang et al., "Large Language Models Cannot Self-Correct Reasoning Yet" (arXiv:2310.01798) — https://arxiv.org/abs/2310.01798 — 实证支持：LLM 审阅自己的输出会使表现下降而非提升，确立了审计者必须是结构上分离的智能体、而非一次自我审阅的原因
- Krakovna et al., "Specification Gaming: The Flip Side of AI Ingenuity" (2020) — https://deepmind.google/blog/specification-gaming-the-flip-side-of-ai-ingenuity/ — 实证支持：收录了智能体如何满足字面目标却背离预期结果——这正是独立审计者要抓的失败模式
- McAleese et al. (OpenAI), "LLM Critics Help Catch LLM Bugs" (arXiv:2407.00215) — https://arxiv.org/abs/2407.00215 — 实证支持：CriticGPT 工作——受训审阅模型所写代码的 LLM 批评者比受雇的人类代码审阅者抓到更多 bug，并在曾被评定为『完美无瑕』的 ChatGPT 训练数据中找出了数百处错误
- 2389 Research, fresh-eyes-review — https://github.com/2389-research/fresh-eyes-review — 一方实践：一个强制审阅门（gate），在测试通过之后、任何提交或 PR 之前运行——『未经新鲜眼光审阅，不得提交』——其立足观察是：『测试很全面』『我确信它是对的』恰恰是严重 bug 逃逸的时机
