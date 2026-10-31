## 这是什么（What it is）

别再告诉智能体怎么做。过程式指令——『第一步跑 X，第二步改 Y，第三步调 Z』——编码的是穿过问题的一条路线，而且是按过去某个模型的能力水平写的。够强的模型能规划出比你脚本更好的路线；过程式脚本消耗上下文预算去复述模型早已知道的东西；并且随着模型进步悄悄腐烂。声明式替代方案把结果写成契约：必须成立的结果、约束它的边界、以及证明它的验证方式。怎么做由智能体决定。声明式规格还可审计——契约是可检验的，而流程只能被『跟随』。

## 适用场景（When to reach for it）

- 驱动足够强的前沿模型，而你会忍不住一步步微操的任务。
- 可重复、可审计的工作流，且契约可以被机械验证。
- 每次模型或环境一变就要打补丁的指令。
- 把团队流程编码给智能体——声明验收条件，而不是编排舞步。

## 慎用场景（When NOT to）

- 精确流程本身就是需求——合规、财务操作、不可逆的生产变更。把它们编码成确定性护栏（`patterns/deterministic-rails.md`），而不是散文。
- 你的脚手架对较弱模型曾是承重墙——增量迁移，随能力上升逐步拆除（`patterns/self-ablating-harness.md`）。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1Nvn26tETp — 《别再告诉智能体怎么做》（OpenProse）：一种 Markdown 原生、事件驱动的智能体编程语言，核心理念是声明式契约——你声明结果，智能体决定怎么做
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1cpa66aEnR — 《不要挡在模型前进的路上》：过度指令是对够强模型征收的税
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1L2uB6ZEkQ — 《指导，验证，解决》：可行的中间地带——松散引导、机械验证、失败时介入

## 相关（Related）

- `patterns/context-over-prompt.md`
- `patterns/state-the-target.md`
- `patterns/self-ablating-harness.md`
- `patterns/deterministic-rails.md`
