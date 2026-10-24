## 这是什么（What it is）

面对上下文管理问题时，恰好有四个动作可用。写出（Write）：把易逝的推理或中间结果转化为持久产物（文件、笔记、检查点），使其能穿越上下文重置并被精确读回。选择（Select）：从大量可用材料中，只挑与当前步骤相关的部分——检索、过滤、切片、摘录。压缩（Compress）：把冗长内容（长文档、完整对话史、详细计划）缩减为保留信号的稠密摘要，甩掉 token 成本。隔离（Isolate）：把细节繁重的子任务委托给一个全新的智能体，让工作发生在主上下文窗口之外，只有结果返回。这四个动作并非任意——它们穷尽地映射了上下文可被塑造的方式。一条工程良好的上下文流水线，可以完全用『对什么内容、以什么顺序、应用了哪些动作』来描述。

## 适用场景（When to reach for it）

- 诊断上下文管理问题时：找出缺的是哪个动作。上下文持续增长？需要压缩或隔离。跨会话丢状态？需要写出。检索到的内容太多？需要选择。
- 设计多智能体流水线时：在把内容传给下一阶段之前，规定哪个智能体应用哪个动作。
- 编写系统提示词（system prompt）或注入内容时：问每一块内容是原始产物（写出）、最相关切片（选择）、摘要（压缩），还是应当被整体卸载（隔离）。
- 当长时运行的智能体输出退化时：四动作框架就是诊断工具——找出哪个动作缺失或被误用。

## 慎用场景（When NOT to）

- 简单的单轮任务，输入自然装得进上下文、四个动作都用不上时——把框架套在琐碎任务上徒增开销。
- 模型需要完整逐字内容的任务（法律文本、合同、受审代码中每一行都重要）——压缩会摧毁必要信号；选择会留下缺口；此处的动作就是『原样包含』。

## 实例（Exemplars）

- LangChain Team — https://www.langchain.com/blog/context-engineering-for-agents — 出处：提出精确的四桶分类法（write、select、compress、isolate）；转述 Cognition 的说法——上下文工程是『构建 AI 智能体的工程师的头号工作』
- Breunig，"How Long Contexts Fail" — https://www.dbreunig.com/2025/06/22/how-contexts-fail-and-how-to-fix-them.html — 实证支持：记录了四个失败模式（污染、分心、混淆、冲突），四个动作正是为防止它们而设计
- Breunig，"How to Fix Your Context" — https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html — 正式化：编目了六种实用修复（RAG、工具装载、隔离区、修剪、摘要、卸载），分别对应选择、隔离、压缩与写出四个动作

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/context-over-prompt.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/subagents-as-context-sinks.md`
- `patterns/checkpoint-handoff-file.md`
