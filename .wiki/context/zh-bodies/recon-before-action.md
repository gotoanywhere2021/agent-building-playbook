## 这是什么（What it is）

在真实环境中运作的智能体经常采取不可逆或难以逆转的行动：写文件、调用外部 API、创建数据库记录、发送消息、修改配置。天真的做法是立刻行动：任务是发邮件，就调用邮件 API；任务是更新文件，就写文件。问题在于这跳过了一个问题：该行动在当前上下文中是否正确。文件已经处于正确版本了吗？邮件已经发过了吗？API 端点的形态是否与智能体假设的一致？目标目录存在吗？行动前侦察（recon-before-action）是在任何修改状态的操作之前，先运行一次轻量只读调查阶段的实践。侦察收集地面真值（ground truth）：现在存在什么、不变量是什么、从当前状态看行动空间实际长什么样。智能体随后基于已知的地面行动，而不是假设的地面。代价是增加一个步骤——通常很便宜，往往只是一次 API 调用或文件读取。回报是错误行动、以及从错误中恢复所需工作的大幅减少。行动前侦察还产生天然的审计痕迹：侦察输出就是智能体在行动前所知内容的记录，这让事后调试简单得多。

## 适用场景（When to reach for it）

- 在智能体本会话尚未直接观察过的环境中进行任何写操作之前——先验证目标存在且结构符合预期，再覆盖它。
- 在用数据调用外部 API 之前——做一个轻量检查（GET 请求、schema 探测、能力查询）确认端点、认证与形态，再提交带载荷（payload）的调用。
- 当智能体在与其他进程或智能体共享的环境中运作时——状态自上次观察后可能已经变化；行动前先侦察。
- 调试一个失败的工作流时——加一个侦察步骤，捕获智能体在采取失败行动之前看到的状态。

## 慎用场景（When NOT to）

- 当操作是幂等（idempotent）的，且多余侦察步骤的成本超过侦察所能捕获的任何错误——例如把一份已知安全的配置文件写到一条理解透彻的路径。
- 当侦察步骤本身有副作用或速率限制，使其与行动本身一样昂贵——此时侦察没有优势。
- 在完全沙箱化、所有操作皆可逆的环境中——侦察是对不可逆性的防御；若可逆性有保证，防御就不必要。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：强调在智能体采取有现实后果的行动之前先做规划与验证步骤，尤其是在错误难以逆转的智能体化（agentic）场景
- Amplifier — https://github.com/microsoft/amplifier-foundation — foundation:explorer 智能体是专职侦察角色：对代码与文档做广度优先探索、产出可直接引用的摘要，在调度修改型智能体之前为编排者收集地面真值
- Anthropic — https://code.claude.com/docs/en/best-practices — Claude Code 最佳实践：定义了显式的四阶段 Explore → Plan → Implement → Commit 工作流，第一阶段严格只读；该指南把这一点称为防止解决错误问题的首要防线
- Xia et al., "Agentless: Demystifying LLM-based Software Engineering Agents"（arXiv:2407.01489）— https://arxiv.org/abs/2407.01489 — 实证支持：凭借『定位、修复、补丁验证这一简单三阶段流程，不让 LLM 决定后续行动』在 SWE-bench Lite 上取得开源方法中的顶级成绩——定位先于任何补丁生成，侦察在结构上先于行动
- Hou et al., "World Model for Robot Learning: A Comprehensive Survey" (arXiv:2605.00080) — https://arxiv.org/abs/2605.00080 — 本模式的具身形态：世界模型是『环境在动作下如何演化』的预测性表示，用于在真实执行之前（或代替真实执行）做规划、评测与数据生成

## 相关模式（Related）

- `patterns/verify-independently.md`
- `patterns/auditable-artifacts.md`
- `patterns/fail-loud-harnesses.md`
- `patterns/prove-on-small-sample.md`
