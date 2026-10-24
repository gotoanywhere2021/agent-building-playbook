## 这是什么（What it is）

在 agent 系统中，提出行动的 agent——『这是计划』『这是代码』『这是要运行的命令』——在结构上偏向于获得批准。它已经朝提案方向完成了推理，其上下文锚定在提案上，任何自我评审都在生成提案的同一套假设下进行。把提案者（proposer）与权威（authority）分离，意味着拥有批准与执行权力的实体在提案中没有利益攸关：它可以是一个第二 agent、一个确定性校验器、一个人，或一个设闸的流水线阶段。权威的职责是评估提案是否安全、正确、与意图对齐——并且它必须能够说不。绕回提案者手中审批的提案不是提案；它们是加了若干步骤的执行。

## 适用场景（When to reach for it）

- 任何不可逆动作之前（文件删除、部署、外部 API 调用、消息发送）——提案者起草，权威批准。
- 当一个 agent 在同一回合内既设计又实现——拆分角色：一个 agent 设计，一个独立的 agent 在前者构建之前评审。
- 调试一条批准自己工作、持续产出错误输出的流水线时——缺失的分离就是结构性根因。
- 实现人在回路（human-in-the-loop）工作流时：人是权威，agent 是提案者。在编排设计中把这一点显式化。
- 当合规或问责要求适用时：成文的提案者-权威分离就是审计轨迹。

## 慎用场景（When NOT to）

- 平凡可逆、低风险的动作，批准步骤的成本超过动作出错时的恢复成本——不是每次文件写入都需要一个独立审批者。
- 拥有健壮回滚与撤销机制的完全自动化流水线，分离不现实而恢复可靠——按比例适用。
- 探索性、草稿性或短命的工作，直到后面某个设闸步骤之前都没有不可逆的事发生——把分离推迟到闸门处，而不是每个中间步骤。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：主张在决策点引入人在回路控制，显式把建议行动的生成与其授权和执行分开。
- Amplifier — https://github.com/microsoft/amplifier-bundle-recipes — recipe 步骤可以声明 requires_approval: true，在执行继续前暂停工作流等待显式批准——提案步骤与批准权威在编排格式本身中分离。
- Saltzer & Schroeder, "The Protection of Information in Computer Systems" (1975) — https://www.cs.virginia.edu/~evans/cs551/saltzer/ — 经典先例：『特权分离（separation of privilege）』设计原则主张，要求两个独立方才能解锁一个动作的保护机制，比只需要单一密钥的更稳健；如此一来，没有任何单一事故、欺骗或信任破坏能危及受保护资源。
