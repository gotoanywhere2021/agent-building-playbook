## 这是什么（What it is）

系统长过单个循环之后，第一个问题是『在哪里切』。大型组织的默认是沿组织架构切——每个团队、每条产品线、每类问题一个子智能体——结果可以预言：看不见彼此上下文的智能体在玩传话游戏，保真度随每次交接衰减；子智能体蔓延堆积出成百个重叠的『专家』却无人负责；每个团队把自己的规则拴到自己那一片上，直到提示词互相冲突（『弗兰肯提示词』）；而每一跳都是一个嵌套模型循环，延迟层层复利。Anthropic 在企业部署中反复发现：**按上下文边界切，而不是按问题类型切**的替代方案表现更好——把紧耦合的专家（输出互相衔接、碰同一份数据、经常被一起调用）合并进同一个循环，只有在隔离本身划算的地方保留子智能体：需要新鲜可丢弃窗口的并行任务、可测量的上下文膨胀、冲突的工具需求、以及必须直接面向用户说话的智能体。各团队的流程知识由技能带入共享循环，于是所有权从『拥有一个智能体』转移到『拥有一个技能』——由一个中心小团队持有系统提示词与端到端评估。

## 适用场景（When to reach for it）

- 从零设计多智能体系统——在有人提议『每个部门一个子智能体』之前，先按上下文边界画切线。
- 接手一个过度结构化的系统：几十个专家子智能体、口吻不一致、延迟上升、交接 bug 不断。
- 有人提议『给每个团队自己的智能体』——那是组织架构在说话，不是上下文。
- 为既有子智能体做留与折的裁决：只有隔离确实划算（上述四种情形）才保留；否则折入主循环，让技能承载知识。

## 慎用场景（When NOT to）

- 真正的上下文隔离收益：需要新鲜可丢弃窗口的并行扇出、会实测撑爆主循环的任务、相互冲突的工具集、面向用户的交接——子智能体就该在那里（`patterns/subagents-as-context-sinks.md`、`patterns/parallel-independent-tracks.md`）。
- 单循环装得下的小系统——根本别切（`patterns/single-threaded-default.md`、`patterns/start-least-agentic.md`）。
- 法规强制隔离的场景——边界是外部真实存在的，把它编码出来，而不是论证掉。

## 实例（Exemplars）

- Diane Sarkis《Building Agents: When to Fold Subagents Into Your Main Agent Loop》（Anthropic, 2026-10） — https://claude.com/resources/articles/building-agents-when-to-fold-subagents-into-your-main-agent-loop — 出处：组织架构镜像、传话游戏保真度衰减、『成百个重叠子智能体』、弗兰肯提示词、折入后约 2 倍运行时提速、保留侧四判据，以及带评估闸门的迁移序列（工具包：github.com/anthropics/single-agent-loop-kit）
- Melvin Conway《How Do Committees Invent?》（1968） — http://www.melconway.com/Home/Committees_Paper.html — 定律原文：系统设计镜像组织的沟通结构；本模式是它在智能体时代的重述与逃逸
- Cemri et al.《Why Do Multi-Agent LLM Systems Fail?》（arXiv:2503.13657） — https://arxiv.org/abs/2503.13657 — 独立证据：智能体间失调与系统设计类失效占多智能体 14 类失效的主导

## 相关（Related）

- `patterns/single-threaded-default.md`
- `patterns/match-topology-to-the-work.md`
- `patterns/subagents-as-context-sinks.md`
- `patterns/self-ablating-harness.md`
- `patterns/skills-load-on-trigger.md`
- `patterns/share-full-context.md`
