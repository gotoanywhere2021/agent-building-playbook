## 这是什么（What it is）

提示词工程（prompt engineering）关注指令的措辞：任务怎么表述、赋予什么角色设定（persona）、请求什么格式。上下文工程（context engineering）把注意力上移——移到在指令被读到之前就已放入窗口的信息、文档、历史与状态。模型只能对它被给予的内容做推理；再华丽的指令文本也补不上缺失的事实、过时的数据，或一个让信号淹没在噪声里的臃肿上下文。把上下文当作首要设计面——放什么、不放什么、按什么顺序、以什么压缩形式——持续带来比打磨提示词措辞更大的收益。提示词工程是抛光；上下文工程是架构。

## 适用场景（When to reach for it）

- 当模型在精心措辞的提示词下仍产出不一致或错误的输出时——问它看到了什么、没看到什么，而不是如何换个说法。
- 设计 RAG（检索增强生成）系统、智能体记忆或任何注入检索内容的流水线时——检索与压缩策略才是工程问题，最终那条指令不是。
- 调试一个在某些会话『知道』某事、在另一些会话『忘了』的智能体时——这种不一致几乎总是出在上下文构建，而不是提示词措辞。
- 当任务要求模型对现实世界状态（文件内容、API 响应、对话历史）做推理时——把这些状态当作一等工程工件（artifact），在放入上下文前先行甄选。

## 慎用场景（When NOT to）

- 真正简单、自包含的任务：所需信息都在指令本身里、模型在训练中也见过——此时改进提示词措辞是合适的。
- 问题出在模型的拒答或格式遵循上——那些是提示词层面的问题，不是上下文构建的问题。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/news/contextual-retrieval — 《Contextual Retrieval》：证明注入上下文的内容（以及如何预处理）主导检索质量，而不只是查询文本
- Drew Breunig — https://www.dbreunig.com/2025/07/24/why-the-term-context-engineering-matters.html — 『Why Context Engineering Matters』（2025 年 7 月）：为上下文工程作为一门独立于提示词工程的学科辩护的标杆文章；引用 Karpathy 的背书与搜索量的迅速增长，证明这个术语已经站稳
- LangChain — https://www.langchain.com/blog/context-engineering-for-agents — 『Context Engineering for Agents』（2025 年 7 月）：提出写入/选择/压缩/隔离（write/select/compress/isolate）框架；从智能体系统视角对这一模式的并行形式化
- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — 《Effective Context Engineering for AI Agents》（2025 年 9 月）：以跨多轮智能体会话甄选 token 的策略将上下文工程操作化；对该概念最完整的工程论述

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/just-in-time-retrieval.md`
