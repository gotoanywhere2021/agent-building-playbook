## 这是什么（What it is）

评估驱动开发（eval-driven development，EDD）把测试驱动开发（test-driven development）的纪律应用到智能体与基于 LLM 的系统上：先定义评估（eval）标准，再构建按这些标准进行度量的评估装置（eval harness），然后实现该能力直至通过。评估就是可执行的规格说明。没有评估，能力开发只能靠直觉和非正式检查——开发者运行系统，看看输出，然后判定『看起来是对的』。这在演示时可行，规模化时失效，因为『看起来是对的』既无法自动化，也无法可复现地度量，更无法在模型变更、提示词变更或数据分布漂移之下持续跟踪。评估让改进变得可辨：你可以说『这次改动把测试集上的成功率从 71% 提到了 84%』，而且是当真的。评估也让回归可见：破坏了此前已通过评估的改动会立刻显形，而不是等到生产环境才被发现。先写评估迫使开发者具体地定义成功——这与先写测试迫使接口设计具体化是同一种纪律。如果写不出评估，说明你还不知道这个能力究竟要做什么。

## 适用场景（When to reach for it）

- 在构建任何将由人类判断来衡量的能力之前——先把那个判断转化为自动化评估，再写能力。若无法自动化，至少为人类评估者定义一个结构化评分细则（rubric）。
- 当要做一个本应提升质量的提示词改动时——在改动之前、而非之后，写好能检测到该提升的评估。否则你无法区分真实改进与换个方向的退步。
- 升级到新模型版本之前——先让现有的评估跑一遍新模型。不要假设升级就是改进；去度量它。
- 当某个在开发环境正常的能力在生产环境失效时——先构建一个能复现该失败的评估，再尝试修复。没有复现评估的修复，可能修的是错误的对象。
- 当团队对某个改动是否算改进存在分歧时——评估用证据解决分歧。

## 慎用场景（When NOT to）

- 对一次性产出、以后不会再生成的东西——为只用一次的能力构建评估装置，投资回报很差。
- 当能力尚在探索阶段、成功标准确实还无法定义时——先做探索，观察好与坏各是什么样子，然后在产品化之前定义评估。
- 当唯一可信的评估者是对真正主观产出的人类判断时（例如面向特定受众的创意写作）——这些情况下，构建结构化的人工评估协议，而不是强推无法捕捉真实质量信号的自动化。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：建议从简单提示词起步，在加入智能体复杂度之前『以全面评估进行优化』——度量先于架构生长——并收录了评估者-优化者（evaluator-optimizer）工作流：一个 LLM 负责生成，另一个在循环中提供评估与反馈
- Xia et al., "Evaluation-Driven Development and Operations of LLM Agents" (arXiv:2411.13768) — https://arxiv.org/abs/2411.13768 — 形式化：提出 EDDOps，把评估嵌入为持续的治理函数而非终点检查点，将离线与在线评估统一进一个同时驱动运行时适配与受控再开发的反馈回路
- Hamel Husain, "Your AI Product Needs Evals" — https://hamel.dev/blog/posts/evals/ — 形式化：论证失败的 AI 产品有共同根因——未能建立稳健的评估系统；而评估基础设施是支撑快速迭代的首要生产力倍增器
- Grace et al., "Demystifying evals for AI agents" (Anthropic Engineering) — https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents — 实证支持：给出一个覆盖各智能体类别、结合基于代码、基于模型与人类评分者的综合框架，把评估当作与单元测试同级的核心开发实践

## 相关模式（Related）

- `patterns/standing-eval-capability.md`
- `patterns/test-what-not-how.md`
- `patterns/prove-on-small-sample.md`
