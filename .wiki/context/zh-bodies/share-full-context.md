## 这是什么（What it is）

智能体采取的每一个行动都是一次决策。当编排者（orchestrator）只用一段狭窄的任务描述生成一个子智能体（subagent）——『搜索最近的五个提交』——子智能体会做出编排者若在场就会做出不同选择的决策：用什么格式返回结果、是否包含合并提交（merge commit）、是恰好停在五个还是带上上下文、如何处理空结果。这些微决策无声地复合。调用方拿回的结果由它从未审阅过的假设塑形。解法是把每一次委派当作全上下文交接：包括所追求的目标、编排者正在其下工作的约束、任何已做出并约束答案的决策、以及编排者已经消除的任何歧义。子智能体不应需要发明上下文——它应当被给予上下文。这不是把整段对话倒进每一次委派。它意味着认真思考哪些上下文塑造决策，识别子智能体需要哪些上下文才能做出好的而非任意的决策，并精确传递那些。

## 适用场景（When to reach for it）

- 当子智能体的输出将被用于做出下游决策——给出足够上下文，让子智能体把输出塑形为那个决策所需要的样子。
- 当并行工作的不同子智能体可能做出制造不一致的冲突微决策——给每个智能体那些必须在它们全体之间成立的共享约束。
- 当委派给一个没有先前对话历史的新智能体——它无法从未说出的话里推断约束；显式陈述它们。
- 当子智能体任务触及一个编排者已经学到重要东西的领域（先前步骤、已知局限、早前陈述的用户偏好）——把这些学得放进委派里。

## 慎用场景（When NOT to）

- 当子智能体在运行一个完全自包含、没有决策面的操作——纯计算、格式转换、有唯一确定性答案的查询——额外上下文只添成本没有收益。
- 当上下文体量大到会挤掉指令本身——此时蒸馏出与决策相关的子集，而不是全传。
- 当子智能体在其自身已确立的约定下运行，而编排者的上下文会错误地覆盖那些约定。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：指出误差复合是自主多步智能体的关键风险——全上下文委派所缓解的正是这一风险
- Amplifier — https://github.com/microsoft/amplifier — delegate() API 包含显式的 context_depth 与 context_scope 参数，让编排者传递与某次委派相关的上下文而不必总是倒出整份记录（据 Amplifier 团队白皮书；这些参数在当前公开仓库中不可见）
- Walden Yan, "Don't Build Multi-Agents"（Cognition, 2025 年 6 月）— https://cognition.com/blog/dont-build-multi-agents — 把『分享上下文，并分享完整的智能体痕迹，而不只是单条消息』列为两条核心原则之一；本模式提法的直接来源

## 相关模式（Related）

- `patterns/clean-slate-delegation.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/context-over-prompt.md`
