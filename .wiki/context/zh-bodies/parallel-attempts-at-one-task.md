## 这是什么（What it is）

模型的输出是一次掷骰子；如果你需要一个三点而第一把很少掷出来，就多掷几颗骰子。并行尝试（parallel attempts）从共享检查点同时把同一任务运行多次——保存计划并提交，分叉到独立的工作目录（git worktree 或等价物），同时启动多个实现，然后逐一评审，要么挑出最好的，要么把各次尝试中最强的部分拼接起来。这是刻意用便宜的 token 去交换不便宜的人类时间和墙钟时间。它服务两种不同模式。作为*失败缓解*：当方法不确定、任何单次尝试都可能失败时，并行跑三到五次意味着你从成功的那次继续前进，而不是把一连串死路逐个调试。作为*解空间探索*：当质量比速度更重要时，几个可工作的版本让你比较真正不同的方法，并把各自最好的部分嫁接到一起——这对 UI、游戏机制、设计这类开放式工作尤其强大，在那里『正确』是一个区间，多样性本身就是目的。要紧的是区分：这不是把相互独立、*彼此不同*的子任务扇出（fan-out）去省墙钟时间——这里的尝试是刻意冗余的，价值在于选择与重组，而不是分工。

## 适用场景（When to reach for it）

- 当任务很难或正确方法不确定、单次尝试成败各半——并行跑几次，从成功的那次继续。
- 当质量比速度重要且解空间宽广（UI、设计、游戏机制、一切创造性工作）——生成多样性并组合最好的部分。
- 当调试一次失败尝试的成本超过再启动几次新尝试——重掷（reroll）而不是修理。
- 当你能廉价地隔离各次尝试（worktree、分支、独立沙箱），使并行实现互不相撞。

## 慎用场景（When NOT to）

- 任务是确定性或已被充分理解、单次尝试稳定成功时——并行掷骰只是烧 token 而不增加质量。
- 尝试无法被隔离、会互相干扰状态时——先建立隔离，否则不要并行。
- 当评审 N 份结果耗费的注意力超过省下的——best-of-N 只有在挑出赢家的成本低于一次做对的成本时才划算。
- 当你实际拥有的是不同且相互独立的子任务——那是为墙钟而扇出，属于另一个模式；本模式是对*同一*任务的冗余尝试。

## 实例（Exemplars）

- Lada Kesseler (lexler) — https://github.com/lexler/augmented-coding-patterns/blob/main/documents/patterns/parallel-implementations.md — 『Parallel Implementations』，本模式的改编来源；其 Ricochet Robot 示例跑了三次尝试——一次全败、一次平庸、一次移动逻辑可用——最终交付了『可用的移动加上更好的按钮』的组合（视频演示：https://www.youtube.com/watch?v=_LSK2bVf0Lc&t=2671s）。
- 2389 Research, test-kitchen — https://github.com/2389-research/test-kitchen — 一方实践（first-party）：同一套分叉-评判循环封装成插件——『你有一份规范。存在三种可行方案。』——它在并行 git worktree 中把三者全部构建出来，『让你的测试选出赢家』，使选择这一步成为确定性动作而非主观判断。
- 2389 Research, jam — https://github.com/2389-research/jam — 一方实践：以重组为目的的并行变体——3–5 个变体在并行 worktree 中构建，一个评审小组全部评估，综合步骤『拒绝丢弃落败者想通的东西』，把落败变体中最强的想法折入赢家。

## 相关模式（Related）

- `patterns/build-five-to-throw-away.md`
- `patterns/parallel-independent-tracks.md`
- `patterns/single-threaded-default.md`
- `patterns/delegation-token-economics.md`
- `patterns/match-model-to-stage.md`
