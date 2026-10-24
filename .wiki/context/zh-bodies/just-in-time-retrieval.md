## 这是什么（What it is）

预加载（pre-loading）是工作开始前就把所有可能相关的文档、工具、历史和参考资料塞进上下文的冲动。成本会复合：庞大的预加载上下文挤占工作记忆，迫使模型在无关内容上分配注意力，并花掉本可用来容纳后期结果的 token。即时检索（just-in-time retrieval）反转了这个模式——开头保持上下文最小，只在需要它的那一步拉取具体内容。代码评审智能体（agent）不需要从第一轮起就把完整 API 文档放进上下文；它在遇到相关函数时才需要相关章节。规划智能体不需要每一次历史对话；它需要上一次决策的摘要。即时检索把信息当作一种应在使用那一刻加载的依赖，而不是在程序顶部预先声明。

在『记忆（memory）』被明确定义之前，这个词是错的。那个宏大比喻——给智能体一个记忆——会招来预加载，并掩盖真正的设计决策。实际的提问要窄得多：此刻这个智能体应当知道什么，才能改善这个结果？这个问题把问题重新表述为上下文治理（context governance），而不是泛泛的记忆，而即时检索正是逐步回答这个问题。这也是为什么把一个 RAG 管道叫作『记忆』然后止步于此是一种反模式：检索确实有用，但它只是记忆的一个组件。真正的记忆还需要选择（决定拉取什么）、衰减（让陈旧材料过期）、修正（改正错误）和评估（检查检索到的上下文是否真的有帮助）。一个这些都没有的检索器只是查询，不是记忆——把它当成完整方案，难的那部分治理工作就没做。

## 适用场景（When to reach for it）

- 设计智能体工具使用时：每次工具调用应检索恰好是当前步骤所需的内容，而不是『可能有用』的超集。
- 构建 RAG 管道时：在推理时按查询检索，而不是预先把所有超过阈值的已索引块填满上下文。
- 当智能体跨许多步骤运行、早期步骤的上下文对后期步骤变得无关时——把后期步骤材料的检索推迟到抵达那一步。
- 当检索的延迟或成本相对低、而携带未用 token 跨越多次推理调用的成本相对高时——对文件读取、向量搜索和数据库查找而言，这几乎总是成立。

## 慎用场景（When NOT to）

- 需要整个语料同时可见才能正确推理的任务——文档比较任务中，模型生成时必须同时把两份文档放在心里，无法推迟检索而不破坏任务结构。
- 当检索系统本身很慢或昂贵、且同一内容每一步都会需要时——一次预加载可能比反复检索同一材料更便宜。
- 探索性或创造性任务中，模型受益于宽泛上下文以生成跨越检索材料的联想——选择性的即时检索会人为收窄空间。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/news/contextual-retrieval — Contextual Retrieval：实证支持：一种索引时技术——在嵌入与 BM25 索引之前为每个块前置其专属的说明性上下文——提升了按查询检索的准确率，而检索质量正是即时加载所依赖的
- Lewis et al., "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks" (arXiv:2005.11401) — https://arxiv.org/abs/2005.11401 — 经典先例：RAG 原始论文（NeurIPS 2020）确立了『推理时检索（retrieve-at-inference-time）』作为按需注入外部知识而非烘焙进权重的基础范式
- Liu et al., "Lost in the Middle: How Language Models Use Long Contexts" (arXiv:2307.03172) — https://arxiv.org/abs/2307.03172 — 实证支持：当相关信息被埋在预加载的长上下文中时，性能会下降；支持选择性的逐步检索胜过前置加载
- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — Effective Context Engineering for AI Agents（2025 年 9 月）：形式化：把维护轻量标识符（文件路径、URL、已存查询）并在运行时加载内容，描述为 JIT（即时检索）的规范实现

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/context-over-prompt.md`
- `patterns/write-select-compress-isolate.md`
