## 这是什么（What it is）

智能体构建就是瀑布，但是飞快的瀑布——一旦一次完整的设计-构建循环的成本从一个季度降到一下午，在理解需求之前就一头撞进某个设计，便成了理性行为。Brooks 告诉我们要『计划扔掉一个』；当智能体并行运行时，扔五个与扔一个耗费同样的墙钟时间。

造五个的意义不在冗余——在比较。一次探路构建（spike）教会你关于问题的事；五个并排的变体教会你关于你自己偏好的事。在看到变体们在何处一致、在何处分歧之前，你不知道一个设计的哪些性质是本质的、哪些是偶发的；而常常直到你同时看到『有它』与『没它』的两个版本，你才说得出自己在乎什么。

生成变体有三种方式。你可以提示（hint）想探索的维度，给每次构建一个刻意的立场——MVP 优先、性能优先、UX 优先。你可以让模型自己挑选多样的路数。或者，你可以给每个变体一模一样的提示词，玩老虎机，让采样方差替你探索。

变体之后的去向是灵活的：有时五个全死、只有提炼出的规格活下来；有时其中一个真的对了、毕业进入真正的构建；有时你从其中几个采掘出最好的部件，熔成一个全新的综合。承诺是愿意把五个全部扔掉。有保证的产出是学到的东西，而不是任何工件。

## 适用场景（When to reach for it）

- 你还说不出『好』长什么样——需求正是你要去发现的东西。
- 设计空间很宽、单次尝试的选择会流于武断——样本量为 1 时，你分不清本质与偶发。
- 利益相关方『看到就知道了』却写不出规格——变体给了他们可以具体回应的东西。

## 慎用场景（When NOT to）

- 需求其实已经理解——直接建；当已没有可发现的东西时，并行变体是纯浪费。
- 单次探路构建就能回答问题。如果未知的是问题本身而不是你的偏好，一次抛弃式构建就够——那是 `implement-to-learn`。
- 变体会产生持久副作用时（生产写入、开通的基础设施、已发送的消息）——当构建留下残余物时，抛弃假设就不成立了。
- 算力预算是约束而不是墙钟时间时——五个构建一起完成，但 token 成本约是五倍。

## 实例（Exemplars）

- Fred Brooks — *The Mythical Man-Month* — 『计划扔掉一个；反正你总会扔的。』本模式是同一洞见在智能体经济学下的版本：当构建廉价且并行，计划扔掉五个。
- Fred Brooks, *The Mythical Man-Month*, Anniversary Edition (1995) — https://en.wikipedia.org/wiki/The_Mythical_Man-Month — 20 周年纪念版在『Don't Build One to Throw Away—The Waterfall Model Is Wrong!』的标题下重访了 1975 年的建议——Brooks 自己朝迭代开发的部分撤回（该标题见于纪念版正文；链接的 Wikipedia 概览覆盖该版本但不含其内容清单）；本模式是同一条演化路线的第三步，由智能体经济学使之成为可能
- Drew Breunig, "10 Lessons for Agentic Coding" — https://www.dbreunig.com/2026/05/04/10-lessons-for-agentic-coding.html — 第 2 课『Rebuild often』：廉价的代码意味着你可以分叉并重写思想实验，以从未有过的方式侦察与重新发明——正是本模式从『扔一个』推向『扔五个』的同一经济学
- 2389 Research, test-kitchen — https://github.com/2389-research/test-kitchen — 一方实践：『你有一份规格。存在三种有效路数。』——它不去猜该建哪个，而是在并行的 git worktree 里把三个全建出来、让测试选出赢家，构建前有设计探索门（omakase-off），设计与实现的过渡处有实现竞赛（cookoff）
- 2389 Research, jam — https://github.com/2389-research/jam — 一方实践：多元视角小组提出路数，三到五个变体在并行 worktree 中构建，评审小组评估全部——其前提是：单个智能体生成『多种路数』仍是一个头脑在想象不同的人会怎么想，而该流程应拒绝『扔掉败者们弄明白的东西』

## 相关模式（Related）

- `patterns/implement-to-learn.md`
- `patterns/parallel-attempts-at-one-task.md`
- `patterns/parallel-independent-tracks.md`
- `patterns/develop-your-taste.md`
- `patterns/hang-up-call-back.md`
