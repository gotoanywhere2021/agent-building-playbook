## 这是什么（What it is）

当智能体之间交接工作时，诱惑是把内容内联——传整个文件、完整文档、全部工具输出——好让接收方智能体『拥有它可能需要的一切』。结果是上下文污染（context poisoning）：接收方智能体的窗口塞满它未必需要的内容，难以分辨相关与无关，还要为把完整载荷带过随后的每一步推理付出 token 成本。薄指针（thin pointer）用引用替代内容：一个文件路径、一个文档 ID、一个章节标题、一个工具调用模式、一份关于内容在哪里以及如何只取所需部分的结构化描述。接收方智能体读取指针，在需要时恰好取回需要的切片，从不加载其余部分。薄指针把即时检索（just-in-time retrieval）原则应用于智能体间通信：传地址，不传对象。零污染（zero poisoning）是目标——任何智能体的上下文里，都不应出现它自己没有选择加载的内容。

## 适用场景（When to reach for it）

- 在智能体之间传递大型产物（文件、文档、数据集、代码）时——传路径与相关段落标记，不传内容。
- 当编排者（orchestrator）的上下文中积累了先前步骤的工具输出、而它们不再被直接需要时——用指向其落盘文件的指针替换它们，然后继续。
- 在多智能体流水线中设计智能体间协议时——把交换格式规定为结构化引用，而非内嵌载荷。
- 当子智能体返回大结果、而编排者只需要摘要时——接收摘要加上指向磁盘上完整结果的指针；由编排者决定是否解引用（dereference）。

## 慎用场景（When NOT to）

- 被引用内容小到内联不产生有意义的 token 成本、往返检索开销不值得时——薄指针有协调成本；不要对单行值应用它们。
- 当接收方智能体可以预见会立即需要完整内容、而检索徒增延迟又不省 token 时——当你确定完整内容必被消费时就内联。
- 当内容无法写到稳定位置（无持久化机制的临时内存结果）时——薄指针需要一个可解引用的地址。

## 实例（Exemplars）

- Amplifier — https://github.com/microsoft/amplifier — delegate() 模式默认返回摘要，完整结果写入产物（artifact），编排者可按引用按需读取（据 Amplifier 团队白皮书；在当前公开仓库中不可见）
- Curme 与 Daugherty（LangChain）— https://www.langchain.com/blog/context-management-for-deepagents — 正式化：Deep Agents 把超过 2 万 token 的工具响应替换为一个文件系统路径加 10 行预览，并在上下文占用达到 85% 时截断更早的写入——这是薄指针在跨步骤上下文管理上的直接实现
- Breunig，"How to Fix Your Context" — https://www.dbreunig.com/2025/06/26/how-to-fix-your-context.html — 正式化：把『上下文卸载（Context Offloading）』（借助外部工具把数据存到 LLM 上下文之外）列为一级技术——即薄指针动作应用于智能体到存储的传输

## 相关模式（Related）

- `patterns/subagents-as-context-sinks.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/context-is-finite.md`
