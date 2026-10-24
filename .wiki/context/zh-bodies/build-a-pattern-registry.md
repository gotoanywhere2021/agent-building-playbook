## 这是什么（What it is）

在一个组织里，各团队不断重复发明同样的轮子：同样的智能体循环、同样的校验器、同样的审阅技巧、同样的上下文布局、同样的智能体形状的工具——各自独立发现、各自付出代价、从不共享。模式注册表（pattern registry）是制度层面的回应。它捕获可复用的操作招式——智能体实践的『基因』——而不要求每个团队采用同一个有机体、同一个框架或同一套技术栈。要点是实践的转移，不是统一性的强制。一条有用的注册表条目远不止名字加描述：它记录模式名称、解决的问题、何时使用、何时不使用、它要求的工件、示例提示词或工作流节点、已知失败模式、判断它是否奏效的评估方法、实现参考、出处（provenance），以及为它背书的维护者或支持者。禁忌（contraindication）不是可有可无的客套——它们正是让注册表可信的东西。重型工作流图对许多任务是错的；普适记忆可能毒化上下文；人工审批门可能摧毁自主性；俏皮的智能体人设可能取悦一种文化、疏远另一种。一份只列『何时使用』、从不列『何时避免』的注册表，会沦为货拜物目录（cargo-cult catalog）。做得好，模式注册表会成为智能体实践的包管理器（package manager）：一个共享的、有版本的、可归因的操作招式索引，团队可以从中拉取、改编、再贡献回去。

## 适用场景（When to reach for it）

- 组织内多个团队在独立解决同样的智能体构建问题、而解决方案从不传播时。
- 某个在一支团队里行之有效的实践应当扩散，但你不想强迫每支团队采用创始团队的框架或技术栈时。
- 你不断从转录挖掘中重新发现模式候选、需要一个结构化的归置之处时。
- 新团队或新智能体上手、他们会受益于组织积累的操作招式而不是从零开始时。
- 某个模式被误用的代价高到其禁忌必须随模式一起传播时——注册表条目正是『何时不使用』的居所。

## 慎用场景（When NOT to）

- 没有人维护它时——无主的注册表会腐烂成误导多于帮助的陈旧条目坟场。
- 组织太小或太早、尚谈不上跨团队复用时——过早建注册表是为流程而流程。
- 条目将缺少禁忌与评估方法时——一份没有限定条件的推荐清单比没有注册表更糟。
- 注册表被用来强制统一而非促成转移时——它一旦变成合规清单，就不再捕获基因，而开始克隆有机体。

## 实例（Exemplars）

- Alexander et al., *A Pattern Language* (1977) — https://en.wikipedia.org/wiki/A_Pattern_Language — 经典先声：253 个命名模式的原始注册表，每条都带问题陈述、解法与交叉引用；确立了『命名、带禁忌、交叉引用』的条目模板，正是它让注册表可信而非沦为目录。
- Gamma, Helm, Johnson, Vlissides, *Design Patterns: Elements of Reusable Object-Oriented Software* (1994) — https://en.wikipedia.org/wiki/Design_Patterns — 经典先声：以 23 个命名、分类的模式把软件模式目录形式化，证明了有文档的实践能在从业者之间传播而不强制共享实现。
- Wang et al., "Voyager: An Open-Ended Embodied Agent with Large Language Models" (arXiv:2305.16291) — https://arxiv.org/abs/2305.16291 — 形式化：Voyager 不断生长的技能库是一个面向 LLM 智能体的可查询模式注册表，积累离散的、经过测试的行为，使能力跨会话复利而不要求智能体重新发现它们。
- 2389 Research, skills.2389.ai — https://skills.2389.ai — 一方实践：本 playbook 的姊妹注册表——一个可浏览的 Claude Code 插件与 MCP 服务器市场（『这些是我们每天都在用的工具』），每一条都能用一条命令装进任意智能体；本模式的包管理器隐喻的具象化。
- Voyager — https://github.com/voyager-crew/voyager — 一个浏览器增强套件，其提示词管理器把提示词当作可移植库：一次整理、按名索引、在任意网站上跨 Gemini、Claude、ChatGPT 与 DeepSeek 调用——把注册表与任何单一聊天应用解耦

## 相关模式（Related）

- `patterns/gene-transfer.md`
- `patterns/personal-to-shared-topology.md`
- `patterns/composable-patterns.md`
- `patterns/mine-transcripts.md`
