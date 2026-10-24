## 这是什么（What it is）

模拟评审小队（simulated review squad）是一个由不同视角组成的评审团——专家用户、新手用户、合规评审、客服运营、高管发起人（executive sponsor）、持怀疑态度的工程师、无障碍评审、安全评审，以及工作所要求的任何领域特定人格（persona）——在工件抵达真实人类之前对它进行审查。目标明确地不是假装这些模拟是它们所替代人类的完美替身；而是比真实评审循环更早、也便宜得多地产出那些人类会提出的异议，让显而易见的问题在工件到达真实用户之前就被抓住。每个人格从自己的关注点阅读工件：新手在专家从未注意的东西上绊倒，合规评审标记制造敞口的步骤，客服运营预测它会产生的工单，怀疑的工程师质疑没人明说的假设。弱版本凭想象发明这些人格；强版本用真实材料构建它们——对话记录、支持工单、销售电话、旁听会话与领域文档——让模拟反应扎根于真实受众的真实行为。这不同于技术性的代码审计：审计者对照规范检查工件，而评审小队上演多利益相关方反应，揭示没有任何规范编码的人类异议。

## 适用场景（When to reach for it）

- 工作即将到达真实用户，而与每个相关方进行完整评审循环会很慢或很贵。
- 工件触及许多利益相关方（合规、客服、无障碍、安全），你希望在上线之前而非之后让他们的异议浮出水面。
- 你有真实材料——记录、工单、电话——让人格扎根于实际行为而非想象。
- 在工作的这个阶段，早而便宜的异议比晚而权威的更有价值。
- 你想在花费真实评审者的注意力之前，抓住显而易见的跨视角失败。

## 慎用场景（When NOT to）

- 决策确实需要真人的权威或问责（法律签署、监管批准）——模拟无法替代。
- 人格将是纯粹虚构、没有扎根材料，产出错误代表真实受众的自信异议。
- 任务是对照规范的技术正确性检查——用审计者（auditor）智能体，而不是利益相关方评审团。
- 把小队通过当作永不与真实用户交谈的替代——它是廉价异议的过滤器，不是发布门。

## 实例（Exemplars）

- Li et al., "CAMEL: Communicative Agents for 'Mind' Exploration of Large Language Model Society"（arXiv:2303.17760）— https://arxiv.org/abs/2303.17760 — NeurIPS 2023；通过角色扮演与 inception 提示在延展合作任务中维持不同 LLM 人格的早期工作；多人格评审的直接技术先例。
- Qian et al., "ChatDev: Communicative Agents for Software Development"（arXiv:2307.07924）— https://arxiv.org/abs/2307.07924 — 在软件生命周期的设计、编码与测试阶段分配专门的智能体角色；在生产工作流语境中展示基于角色的多智能体评审。
- Hong et al., "MetaGPT: Meta Programming for A Multi-Agent Collaborative Framework"（arXiv:2308.00352）— https://arxiv.org/abs/2308.00352 — 把标准作业程序（SOP）编码进一组智能体（产品经理、架构师、工程师、QA），各自生成角色适配的工件；展示把模拟评审者扎根于领域过程知识如何提升输出质量。
- 2389 Research, review-squad — https://github.com/2389-research/review-squad — 第一方：在上线前派出并行评审团——专家审计者（安全、性能、SEO、无障碍）、『横跨熟练度光谱』的首次访问者、验证真实流程的任务型常客，以及吹毛求疵的挑刺者——专家加新手的人格面板被打包为可安装的插件。

## 相关模式（Related）

- `patterns/auditor-agent.md`
- `patterns/adversarial-parallel-review.md`
- `patterns/good-pile-bad-pile.md`
- `patterns/shadow-then-transform.md`
