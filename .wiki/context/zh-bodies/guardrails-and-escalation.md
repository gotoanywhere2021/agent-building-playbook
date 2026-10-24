## 这是什么（What it is）

没有护栏（guardrail）运行的自主智能体（agent）不是可靠的系统——它是一笔等着复利的负债。护栏是约束和检查的集合，用来界定智能体行为、在其变成事故之前拦截错误。它们分层工作，每一层接住上一层漏掉的。输入护栏在智能体行动之前验证交给它的事是否落在预期参数之内。行动护栏约束智能体被允许做什么——能调用哪些工具、能修改哪些资源、能触达哪些范围——让一次判断错误不致变成一次灾难规模的错误。输出护栏在产出传给下游或展示给用户之前检查智能体生成了什么——检查格式、有效性、安全性和完整性。而人工升级路径（escalation path）确保当智能体到达护栏之内无法解决的决策点时，它把问题抛给人类，而不是靠猜或硬着头皮继续。这些层次并不独立。它们是纵深防御（defense in depth）：任何单层都可能被设计者未预见的案例绕过，但多层叠加更有可能接住漏网之鱼。设计原则是：智能体的失败应落在尽可能小的影响面上，人工升级路径负责接住其余一切。

## 适用场景（When to reach for it）

- 当在生产环境部署一个错误会产生现实后果的智能体时——生产环境要求显式的护栏设计，而不是假定模型会自觉待在安全行为之内。
- 当智能体的动作空间包含不可逆操作时——无法撤销的动作需要在执行前有一条确认意图或限制范围的护栏。
- 当智能体将在较长周期内自主运行时——长期运行的智能体会累积小错误；定期的输出验证检查点能在其复合之前接住它们。
- 当智能体是新的、或运行在其可靠性尚未经实证验证的任务类型上时——可靠性建立期用更严格的护栏，待业绩记录（track record）确立后再放宽。

## 慎用场景（When NOT to）

- 当智能体运行在完全沙箱化、没有任何修改外部状态的路径的环境中时——为不存在的风险加护栏只增加开销、毫无收益。
- 当每个动作在执行前都已由人类显式批准时——如果人类已经在每个动作的回路里，额外的自动护栏可能只增加延迟、不增加安全。
- 当护栏实现复杂到会引入自身失败模式时——一个误触发或阻挡合法动作的劣质护栏，比没有护栏更糟。

两个细化让这些层次的部署更锐利。第一，人工升级是一条边（edge），不是一种模式（mode）：按风险与必要性路由，而不是在每个检查点都触发，让每一次打断都是挣来的（见 `earn-the-interruption.md`）。第二，护栏应作为基础设施嵌入工作流——嵌入工具、提示词、验证器、日志和审批边——而不是事后检查，那时违规早已是事故（见 `governance-is-infrastructure.md`）。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：建议沙箱测试、护栏与人工监督检查点——包括当智能体遇到阻塞或模糊情形时暂停以获取人类反馈
- Amplifier — https://github.com/microsoft/amplifier — 配方（recipe）系统的分阶段执行模型提供了结构化的护栏点：每个阶段可以要求在下个阶段继续之前获得显式的人类批准，为高风险工作流形成天然的升级架构
- OpenAI — https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/ — A Practical Guide to Building Agents：用一整章讲护栏作为分层防御（相关性与安全分类器、审核、基于规则的保护、输出验证），并建议对敏感、不可逆或高风险动作以及超出失败阈值的智能体引入人工干预
- Rebedea et al., "NeMo Guardrails: A Toolkit for Controllable and Safe LLM Applications with Programmable Rails" (arXiv:2310.10501) — https://arxiv.org/abs/2310.10501 — 形式化：可编程护栏（programmable rails）是『用户定义的、独立于底层 LLM 的、可解释的』——控制有害话题、预定义对话路径和语言风格——是在模型外围绕其添加的护栏层，而非训练进模型
- nanoMuse — https://github.com/nano-muse/nanoMuse — 一个受『凡是不可撤销的事，先问再做』治理的个人智能体：删除、发送、支付之前暂停等待确认，把登录与验证码交还给人类，并把审批路由回你正拿着的那台设备

## 相关模式（Related）

- `patterns/autonomy-when-justified.md`
- `patterns/gate-the-phases.md`
- `patterns/reliability-before-features.md`
- `patterns/fail-loud-over-fallbacks.md`
- `patterns/mark-skipped-steps.md`
- `patterns/earn-the-interruption.md`
- `patterns/governance-is-infrastructure.md`
