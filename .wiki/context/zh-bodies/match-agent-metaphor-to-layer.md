## 这是什么（What it is）

一个 agent 应当被当作人、工具还是一次性的进程，并不是一个有唯一答案的哲学问题——它是一个应当按层做出的设计决策，因为恰当的隐喻（metaphor）会改变你如何构建、命名、监控和信任这个东西。两种失败模式界定了整个空间：把每个 agent 都当人，会制造混乱，在不存在连续性、记忆和问责的地方强加它们；把每个 agent 都当无状态工具，则会丢失某些层真实拥有的有用连续性。纪律在于：选择与该 agent 在其层上实际是什么相匹配的框架。短命的实现者是一次性进程：一个任务、紧凑的上下文、无人格，用完即弃——你不会给它起名字，也不指望它记得什么。评审者或批评者（critic）是独立的评估者：其价值来自对抗性的立场和与被评判工作分离的视角，因此要把它构建成反对者，而不是协作者。协调者（orchestrator）是类管理者的系统：持久的状态、全局的感知、协调他人的职责，因此给它常驻的身份和记忆是合理的。私人助理或数字孪生是长寿命的协作者：人格连续性、被保留的偏好、持续的关系——在这里，拟人隐喻才名副其实。组织级 agent 是受政策约束的行动者：它代表团队规范和机构知识，受治理约束而非个人偏好，因此它应被框架化为一个职位，而不是一个个性。让隐喻匹配层级，能让心智模型保持诚实——在连续性真实存在的地方授予它，在只会造成误导的地方收回它。

## 适用场景（When to reach for it）

- 设计多层 agent 系统、决定每层应携带多少身份、记忆和人格时——让该层真实的寿命和角色来决定。
- 当一个一次性工作者累积了名字、个性和它并不具备的记忆期待——在虚假连续性造成错误之前，把它剥回一个进程。
- 当评审者或批评者被构建得过于随和——该层需要的是一个独立的对抗式评估者，隐喻应当强制这一点。
- 当一个长寿命助手被当作无状态对待、不断丢失有用的偏好与关系连续性——该层值得一个持久协作者的框架。
- 当 agent 代表团队或组织行事、需要受政策而非某个人偏好约束时——把它框架化为受政策约束的行动者。

## 慎用场景（When NOT to）

- 系统是做单一任务的单个 agent 时——没有可供匹配隐喻的层，这个问题无从谈起。
- 为魅力而添加人格、而非因为该层真的有连续性时——那是装饰，日后会误导操作者对该 agent 真实能力的判断。
- 隐喻会授予实现无法兑现的记忆、权威或问责时——框架不得超出 agent 实际能力去承诺。
- 当选择隐喻变成逃避把 agent 的范围、上下文和护栏做对的替代品时——隐喻描述层，但不实现层。

## 实例（Exemplars）

- Daniel Dennett, *The Intentional Stance* (1987) — https://en.wikipedia.org/wiki/Intentional_stance — 经典先例：把一个系统当作拥有信念与欲望的理性 agent，是一种在有利时才采用的预测策略，而不是关于系统的事实——这是按层选择人、工具或进程框架、而不争论 agent 『本质上』是什么的哲学基础。
- Reeves & Nass, *The Media Equation* (1996) — https://en.wikipedia.org/wiki/The_Media_Equation — 实证支持：人们像对待人一样对待计算机——自动地、不可避免地，且嘴上否认——这正是拟人框架会在任何 agent 上自发累积的原因，必须刻意从实现无法兑现它的层上收回。
- Anthropic Engineering, "How we built our multi-agent research system" — https://www.anthropic.com/engineering/multi-agent-research-system — 实证支持：该生产系统正是按层这样框架化的——协调者-工作者（orchestrator-worker）模式中，主 agent 负责规划、『为每个子 agent 定义角色』、『并行拉起 3-5 个子 agent』，它们在『各自的上下文窗口』中工作，并在结束前把发现压缩回传。

## 相关模式（Related）

- `patterns/clean-slate-delegation.md`
- `patterns/subagents-as-context-sinks.md`
- `patterns/design-for-emotional-ownership.md`
- `patterns/governance-is-infrastructure.md`
