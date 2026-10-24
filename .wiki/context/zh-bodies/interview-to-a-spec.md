## 这是什么（What it is）

在任何代码被写出之前，意图应先经过一段对话，其职责是把凌乱的人类愿望编译成可执行的规格说明。正确的互动更接近一次辅导或治疗性的对话，而不是命令行：系统不急于给出方案，而是帮助人类发现其自身的意图——先问为什么，再问怎么做；把目标与干系人提出的实现分开；复述自己当前的理解，让误读尽早浮现；索取好结果与坏结果的例子；并指出它发现的未知与矛盾。访谈者（interviewer）在设计上就是怀疑的——它拒绝开始构建，直到能用自己的话干净地复述目标，扮演一个从含糊意图到规格说明的编译器；它用这样的问题探查：*我们在解决什么问题，谁在承受它，什么都不做会怎样，什么会让方案不可接受，哪些例子定义了成功，什么不应被改动，实现应当产出什么证明。*对话产出的不是一份冗长的逐字记录，而是一份工作工件——一份包含验收标准、用户故事、场景、约束和待决问题的精炼规格说明——小到人类能读完并拒绝或批准它。这防住了把第一条提示词当成规格说明的常见失败：第一条提示词是一个冲动，是意图过程的输入，不是最终指令；拿着它直接跑的智能体（agent）跳过了意图真正被确定的那个步骤。

## 适用场景（When to reach for it）

- 一个请求以单行提示词到达、而你正想直接开始构建时——先送它过一遍访谈，把冲动变成规格说明。
- 工作的风险或成本高到构建错东西的代价比对话本身更大时。
- 目标是含糊的、有争议的，或者被表述为一个方案而非一个需求时。
- 你想要一份持久、可检查的工件（规格说明、验收标准、待决问题），让下游的智能体和人类都能据此工作时。
- 智能体持续产出貌似合理却错误的输出，因为没有人赶在执行前钉死成功标准时。

## 慎用场景（When NOT to）

- 任务很小、已被充分理解、重做很便宜时——完整访谈比工作本身还重。
- 人类真的想要探索而不是规格说明时——强加过早的精确性会杀死原型本应提供的发现。
- 访谈变成一场永不终止的审讯时——若它无法收敛，瓶颈是信息缺失，不是问题不够。
- 速度压力让『较差但先交付』的规格优于『完美但太迟』的规格时。

## 实例（Exemplars）

- Harper Reed, "My LLM codegen workflow atm" (2025) — https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/ — 出处：这篇帖子规范地描述了让 LLM『一次只问一个问题』，以在实现开始前形成完整规格说明，产出开发者可以交接的 `spec.md`。
- Gause & Weinberg, *Exploring Requirements: Quality Before Design* (1989) — https://geraldmweinberg.com/Site/Exploring_Requirements.html — 经典先例：引出真实需求而非接受表面表述的奠基之作；强调在没有专业提问的帮助时人们难以表达的部分，去帮他们说出来。
- Rob Fitzpatrick, *The Mom Test* (2013) — https://www.momtestbook.com/ — 经典先例：通过询问客户的真实生活与问题、而非寻求对拟定方案的肯定，来提取诚实需求的实操纪律——与『先问为什么，再问怎么做』直接对应。
- Korn et al., "LLMREI: Automating Requirements Elicitation Interviews with LLMs" (arXiv:2507.02564) — https://arxiv.org/abs/2507.02564 — 形式化：实证研究发现 LLM 聊天机器人的访谈错误率与人类访谈者相当，并在 33 次模拟干系人访谈中通过上下文敏感的迭代提问成功提取需求。

## 相关模式（Related）

- `patterns/document-intent.md`
- `patterns/requirements-are-disguised-solutions.md`
- `patterns/people-edit-better-than-they-author.md`
- `patterns/keep-specs-in-sync.md`
- `patterns/good-pile-bad-pile.md`
