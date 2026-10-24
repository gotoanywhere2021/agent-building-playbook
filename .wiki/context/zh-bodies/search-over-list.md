## 这是什么（What it is）

一个常见的工具设计错误是提供『列出全部』操作，然后期待智能体遍历结果找到所需。智能体调用 `list_files()`，收到 400 个文件路径，把它们装进上下文，然后扫描出它真正关心的两个文件。398 个无关路径消耗 token、挤占工作内容，并迫使模型在大量嘈杂载荷上分配注意力以提取一丁点有用信号。搜索优于列表（search-over-list）用有针对性的接口取代这一模式：不提供 `list_files()`，而是提供 `find_files(pattern=...)` 或 `search_files(query=...)`。智能体说明它在找什么；工具执行过滤；响应只含相关结果。这把工作从模型的上下文移到工具的实现——方向完全正确。在工具层过滤的成本近乎为零；在模型上下文窗口内过滤的成本以 token、延迟与推理质量计。该原则超出文件系统：任何可能返回大集合的工具都受益于搜索或过滤参数。数据库应当暴露查询，而不是整表转储。事件日志应当支持时间范围与类型过滤，而不是完整转储。配置存储应当支持按键查找，而不是序列化整个配置。

## 适用场景（When to reach for it）

- 设计任何自然响应是集合的工具时——至少加一个过滤参数，把结果限制在调用方声明需要的范围。
- 当智能体调用列表工具然后推理哪些条目可用——这就是该列表工具本应是搜索工具的信号。
- 当上下文被智能体只用了一部分的中介集合结果填满时——在工具层用有针对性的搜索取代『列出再扫描』模式。
- 在大结果集上翻页时——翻页往往是工具应暴露更丰富查询参数的信号，让智能体一次调用拿到正确的 N 条，而不是翻页直到找到。

## 慎用场景（When NOT to）

- 当智能体确实需要整个集合来推理——一个列出所有开启的 issue 供智能体分类排优先级的工具合法地需要完整列表；换成搜索会阻止智能体看到全貌。
- 当集合足够小且稳定，返回全部比查询参数的开销更省上下文——一个返回五个配置键的工具不需要过滤接口。
- 当智能体明确要求浏览或探索——智能体还不知道在找什么的探索任务，受益于先较宽枚举再渐进过滤，而非预先的关键词搜索。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/news/contextual-retrieval — Contextual Retrieval：证明高精度检索——只返回相关结果——可将检索失败最多降低 49%；正是本模式应用于工具输出设计的『每 token 高信号』原理
- Anthropic, "Writing effective tools for agents — with agents" — https://www.anthropic.com/engineering/writing-tools-for-agents — 形式化：明确推荐面向搜索的工具而非列出一切，并通过分页与范围选择进行过滤以节省上下文
- Qin et al., "ToolLLM: Facilitating Large Language Models to Master 16000+ Real-world APIs"（arXiv:2307.16789）— https://arxiv.org/abs/2307.16789 — 实证支持：在 16000+ API 的规模上，对工具语料的检索是必要的——引入神经 API 检索器解决规模化的选择问题

## 相关模式（Related）

- `patterns/just-in-time-retrieval.md`
- `patterns/context-is-finite.md`
- `patterns/tools-for-agents.md`
- `patterns/code-execution-tools.md`
