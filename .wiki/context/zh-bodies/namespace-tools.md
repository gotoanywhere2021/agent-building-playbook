## 这是什么（What it is）

当 agent 可以使用很多工具时，工具选择就成了一项推理任务：模型必须读取每个工具的名称和描述，判断哪一个适用于当前情形。含糊的名称与含糊的描述让这种推理不可靠。一个叫 `read` 的工具和另一个叫 `fetch` 的工具会产生不一致的选择行为，因为模型必须从上下文推断哪个用于文件、哪个用于 URL。一个被描述为『获取关于某资源的信息』的工具几乎能匹配任何检索操作，被选中的时机不可预测。命名空间（namespacing）与精确描述从源头消除这种歧义。命名空间把相关工具归到共同前缀之下——`file_read`、`file_write`、`file_list`，而不是 `read`、`write`、`list`——让模型在阅读描述之前就能把命名空间当作第一道分类器。精确描述更进一步：它们点名这个工具处理的具体情形，明确指出它不适用于哪些相邻工具，并描述输出长什么样。一份好的工具描述读起来像一份契约：『当你需要按路径读取本地文件的内容时调用此工具。不要用它获取远程 URL——那请用 `http_get`。以字符串形式返回文件内容。』这种程度的明确性不是过度工程；它是模型在多样化工具集中可靠选择所需的最低规格。

## 适用场景（When to reach for it）

- 向一个已有名称或用途重叠工具的集合添加新工具时——加上清晰的命名空间前缀，并写一份把它与最相似现有工具区分开的描述。
- 当 agent 在某情形下调用了错误的工具——把自己代入模型去读描述，问问它是否毫不含糊地指向这个工具、并指向远离相邻工具的方向。
- 构建超过五六个工具的集合时——在这个规模上，命名空间前缀带来回报：它在模型阅读具体描述之前就提供一个层级分类结构。
- 当某工具的名字在不同上下文中可能意味着不同的事（`search`、`get`、`update`、`delete`）——用命名空间重命名它，或在描述中加入明确的排除语言。

## 慎用场景（When NOT to）

- 工具集非常小（两三个工具）且用途真正不同——没有混淆风险时，命名空间只增加视觉噪音而不带来清晰度。
- 工具动态注册、命名空间前缀会随调用而变化时——此时投资于描述的精确性，而不是命名结构。
- 需要遵循模型训练过的既有工具命名约定时——改写 `bash` 或 `read_file` 这类模型有强先验的知名名称，引入的混乱可能多于解决的。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：指出工具定义值得获得与系统提示词同等的提示工程重视，工具之间要有清晰边界。
- Anthropic, "Writing effective tools for agents — with agents" — https://www.anthropic.com/engineering/writing-tools-for-agents — 形式化：建议把相关工具归到共同前缀之下，并使用毫无歧义的参数命名以减少选择混乱。

## 相关模式（Related）

- `patterns/tools-for-agents.md`
- `patterns/agents-optimize-tools.md`
- `patterns/code-execution-tools.md`
