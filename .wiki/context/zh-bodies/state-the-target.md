## 这是什么（What it is）

否定式（negation）在 Transformer 中是一个弱信号。当你写下『不要提月球』时，模型对内容词『月球』高度关注，而对修饰它的否定只轻微关注——你本想压制的概念被激活，并与压制它的指令相互竞争，于是你经常恰好得到你想避免的东西。这一点已有充分记录：模型对『月球是行星』与『月球不是行星』的内部表征惊人地相似；而且这不只是文本现象——被要求『一个没有大象的房间』的视觉模型，往往以同一机制画出大象。补救办法是指向目标：把请求改写为你想要行为的正面描述，让不想要的概念根本不进入上下文。『不要使用全局变量』变成『使用局部变量和参数传递』；『不要深层嵌套路由』变成『使用扁平的路由结构』。这与『要具体』不同——给否定式指令增加具体性，通常意味着增加*更多*否定、过度约束解空间，反而激活更多你想避免的东西；而指向目标改变的是*你激活了哪些概念*，细节程度不变。当某条禁令确实不容妥协——被禁用的 API、被禁止的路径——不要用更响亮或重复的否定去对抗机制；用一个确定性的检查让输出失败，把提示词的篇幅花在描述目标上。

## 适用场景（When to reach for it）

- 每当你在指令里写下『不要』『永远不要』或『避免』时——试着把它改写为你想要的正面行为。
- 当模型反复产出你明令禁止的东西时——禁令多半激活了那个概念；把它翻转成目标。
- 当提示词里累积了一串『别做 X』条款时——每一条都在播种一个概念；用对期望形态的描述替换它们。
- 当同一种抑制需要在多次运行间都成立时——把正面目标编码一次，而不是重复升级的否定。

## 慎用场景（When NOT to）

- 当禁令关乎安全或政策、必须在任何措辞下都成立时——陈述目标*并*用确定性闸门（gate）强制执行；永远不要只依赖措辞。
- 当确实没有正面方式表达该约束时——有些排除没有自然的目标形态，用检查而非强调去限定它们。
- 当否定式是人类读者需要的关键上下文时——这里讨论的是给模型的指令，不是为人写的文档。

## 实例（Exemplars）

- Juan Michelini（juanmichelini）— https://github.com/lexler/augmented-coding-patterns/blob/main/documents/patterns/point-the-target.md — "Point the Target"，本模式改写自它
- Juan Michelini（juanmichelini）— https://github.com/lexler/augmented-coding-patterns/blob/main/documents/obstacles/negative-bleedthrough.md — "Negative Bleedthrough"，配套的障碍（obstacle）文章，描述底层机制
- Kassner & Schütze（2020）— https://aclanthology.org/2020.acl-main.698/ — "Negated and Misprimed Probes for Pretrained Language Models: Birds Can Talk, But Cannot Fly"，ACL 2020 研究（源文所引），表明预训练语言模型对否定的处理很差

## 相关模式（Related）

- `patterns/context-over-prompt.md`
- `patterns/anchor-on-canonical-names.md`
- `patterns/tools-for-agents.md`
- `patterns/guardrails-and-escalation.md`
