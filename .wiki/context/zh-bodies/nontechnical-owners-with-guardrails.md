## 这是什么（What it is）

agent 软件降低了『理解问题』与『实现方案』之间的门槛，这意味着从未受过工程师训练的人——领域专家、运营人员、分析师、产品经理（PM）——现在可以交付过去必须有开发者参与的应用和内部工具。这具有战略意义：最理解问题的人可以直接驱动工作，而不是经由需求积压列表转译。但非技术者担纲（ownership）在无监督状态下并不成立。它只有在被供应了担纲者所缺判断力的结构包围时才成立：让工作走在轨道上的清晰脚手架（scaffold）、捕捉貌似合理实则错误输出的评审循环、约束波及半径（blast radius）的生产护栏、证明系统确实做到其宣称之事的验收证据、失效时的回滚路径、把安全动作编码进去的领域专属工具、来自有经验者的辅导（coaching），以及关于谁对什么负责的组织规范。目标不是假装人人一夜之间成了资深工程师，也不是把生产环境钥匙交给任何会写提示词的人。目标是让拥有清晰意图和真实领域知识的人承担更多工作，同时把他们嵌入一个足够强的验证与导师体系，使这种担纲是安全的。

## 适用场景（When to reach for it）

- 当最理解问题的人不是工程师，而经由传统开发团队的转译开销才是真正的瓶颈。
- 当你希望领域专家构建并拥有内部工具，但工作以需要护栏的方式触及数据、用户或生产环境。
- 为非技术构建者设计入职流程时：在授予权限之前，把脚手架、评审循环、验收证据和一位指名教练与之配对。
- 决定非技术担纲者哪些可以无监督交付、哪些需要评审时，划线依据是波及半径与可逆性，而不是头衔。
- 当 agent 工具正扩散到工程之外时，在第一起事故之前就把回滚路径和问责规范建好，跑在前面。

## 慎用场景（When NOT to）

- 不要在没有周围脚手架的情况下授予非技术担纲——在工作可能损害数据、用户或生产环境的地方，意图加一个能干的 agent 并不够。
- 不要用它假装验证工作是免费的；评审循环、证据要求和辅导是必须配置人手的真实成本。
- 对高风险、低可逆性的系统避免此模式，那里貌似合理实则错误的输出造成的后果超出护栏能约束的范围。
- 这不是工程判断离场的替代品——如果没有人能真正评估输出，担纲就被移交进了真空。

## 实例（Exemplars）

- Gartner IT Glossary, "Citizen Developer" — https://www.gartner.com/en/information-technology/glossary/citizen-developer — 经典先例：命名了公民开发者（citizen developer）这一形象——使用 IT 或业务部门未明确禁止的工具、为自己或他人创建应用能力的员工——本模式正是为这类非技术构建者配上显式护栏。
- Microsoft Inside Track, "Empowerment with good governance: How our citizen developers get the most out of the Microsoft Power Platform" — https://www.microsoft.com/insidetrack/blog/empowerment-with-good-governance-how-our-citizen-developers-get-the-most-out-of-the-microsoft-power-platform/ — 实证支持：记录了微软自己的『保护、度量、执行』治理模型，覆盖超过 100 万件 Power Platform 资产（含 17 万个 Power Apps），在生产访问前按风险评级做分级权限评审。

## 相关模式（Related）

- `patterns/coaches-and-players.md`
- `patterns/the-new-literacy-is-operating.md`
- `patterns/deterministic-rails.md`
- `patterns/shape-work-as-an-attractor.md`
- `patterns/agents-amplify-experience.md`
