## 这是什么（What it is）

团队默认伸手就要向量数据库；但在代码和结构化语料上，词法检索对智能体常常出奇地有效。真实的智能体查询充满精确标识符、符号、报错字符串和生僻词——正是 grep 和 BM25 的完美射程。词法检索还可调试：读一遍查询就知道文档为什么命中，这在排查『上下文组装出错』时至关重要。与此同时，2022 年式的定长分块悄悄摧毁了文档结构——按标题和语义单元分块，并把元数据一并索引。当评估证明存在真正的转述型或跨语言召回缺口时，再引入向量——而且是以混合检索（词法 + 向量 + 重排）的身份加入，不是替代。

## 适用场景（When to reach for it）

- 面向代码库、文档、工单或任何标识符密集语料的智能体检索。
- 设计 RAG 层、决定复杂度预算花在哪里的时刻。
- 排查『智能体找不到它』类故障——词法基线给你一个可控的参照系。
- 有人提议用微调来解决检索问题——检索的病要用检索的药。

## 慎用场景（When NOT to）

- 从第一天起就充满转述、跨语言或 OCR 噪声的语料——直接上混合检索，但保留词法臂。
- 完全装得进上下文窗口的小语料——检索是用错的工具，直接加载即可。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1xyet61EZ9 — 《BM25 在智能体搜索中的不可思议有效性》：为什么词法打分在智能体流水线里持续赢
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1ZgpB6bEGP — 《Grep 还是嵌入？我们跑了评估》：用测量而非流行度决定公司文档智能体检索的方案
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1LGeh6NE8P — 《别再像 2022 年那样做分块了》：结构感知的分块与索引胜过定长字符窗口
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV13Dpu6zEmd — 《停止用微调修复检索问题》：检索失败是检索的 bug，不是模型的能力缺口
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV15sJ263Ex9 — 《向量检索并不够：混合搜索与检索》：语义检索在哪里真正挣钱，以及如何组合各路臂力

## 相关（Related）

- `patterns/search-over-list.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/eval-driven-development.md`
- `patterns/context-is-finite.md`
