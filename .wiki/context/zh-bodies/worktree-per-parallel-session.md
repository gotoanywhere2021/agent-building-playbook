## 这是什么（What it is）

两个智能体共用一个检出目录时，冲突的方式是上下文隔离管不到的：构建互相打断、未跟踪文件互相覆盖、一个会话的半成品状态弄坏另一个的测试。git 原生的解法是工作树（worktree）：一任务、一分支、一工作树（`git worktree add ../repo-task feature/task`），每个会话有自己的工作目录、共享同一个对象库。让这套机制真正成立的还有两步纪律：开工前先在树里验证干净的测试基线（这样『坏了』永远不会是继承来的悬案）；把合并当作唯一刻意的集成点——冲突在这里由人或集成智能体一次性解决，而不是由碰撞持续解决。

## 适用场景（When to reach for it）

- 多个智能体会话（或智能体与人类）并行操作同一个仓库。
- 同一任务的并行尝试或变体比较——每个变体各居一树，胜者再合并（`patterns/parallel-attempts-at-one-task.md`、`patterns/build-five-to-throw-away.md`）。
- 长时后台智能体不能打扰交互会话的工作状态。
- 工具链会写固定路径构建产物的任务——同目录必撞，分树即隔离。

## 慎用场景（When NOT to）

- 单一顺序会话——工作树纯属仪式（`patterns/single-threaded-default.md`）。
- 任务共享 git 之外的可变状态——数据库、已部署服务、外部 API。工作树只隔离文件；要么配数据隔离，要么改串行（`patterns/agents-are-distributed-systems.md`）。
- 有顺序依赖的步骤——B 消费 A 的输出，那是一条流水线，不是两个工作树。

## 实例（Exemplars）

- obra/superpowers — https://github.com/obra/superpowers — `using-git-worktrees` 技能：创建隔离的分支工作区，并在开始任何并行工作前先验证干净的测试基线；出自 30 万星技能框架
- Git 文档 — https://git-scm.com/docs/git-worktree — 原语本身：多个工作树挂接同一仓库，各占一个分支

## 相关（Related）

- `patterns/parallel-independent-tracks.md`
- `patterns/parallel-attempts-at-one-task.md`
- `patterns/build-five-to-throw-away.md`
- `patterns/clean-slate-delegation.md`
