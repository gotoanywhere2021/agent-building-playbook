## 这是什么（What it is）

注册进智能体工具列表的每一个工具，都会通过名称与描述占据上下文窗口（context window）的空间，并对模型施加推理成本——模型在每次选择前都要评估各个候选工具。一个膨胀到 50 甚至 100 个工具的工具集会带来可观的开销：模型在每个推理步骤都要关注数十条描述，随着工具越来越难区分，选择错误成倍增加，而工具定义吞噬的上下文预算会挤占真正的工作内容。代码执行（code execution）工具——bash、Python REPL、JavaScript 运行时——提供了另一种架构：不为每个操作注册一个专用工具，而是注册一个通用执行器（executor），让智能体把操作写成代码。要列出匹配某个模式的文件？写一个 shell 通配（glob）。要查询数据库？写一条 SQL。要解析 JSON？写一个 jq 表达式或一行 Python。无论智能体需要执行多少种操作，工具定义成本都固定为一条描述；通用性的边界只取决于执行环境允许什么。这并不适用于所有情形——代码执行需要仔细的沙箱化（sandboxing），带来安全影响，且比预定义的工具调用更难审计——但当另一条路是一个超出模型可靠推理能力、不断蔓延的工具目录时，代码执行是更可靠的设计。

## 适用场景（When to reach for it）

- 当工具集超过 20–30 个且选择错误正在增加时——把相关工具归并成一个代码执行端点，让智能体为所需操作写代码。
- 当工具定义正在消耗上下文窗口的显著份额时——度量工具列表的 token 成本；若超过可用上下文的 10–15%，评估通过代码执行来归并。
- 当任务需要单个工具都不支持的操作组合时——与其为每种组合新增一个工具，不如让智能体在代码中组合操作。
- 当智能体所需的操作是数据变换、文件操作或系统查询时——这些天然映射为代码，不需要定制工具逻辑。

## 慎用场景（When NOT to）

- 当执行环境无法安全沙箱化时——不受限的代码执行赋予智能体做出不可逆变更的能力；启用代码执行前务必先划定影响半径（blast radius）。
- 当操作要求的结构化输入输出通过代码比通过类型化工具接口更难强制时——有明确定义模式（schema）的工具提供自由形式的代码执行所不具备的保证。
- 当智能体群体尚不可靠到能写出正确代码时——代码执行同时放大能力与错误面；在高风险环境中，输入受约束的预定义工具更安全。
- 当可审计性是硬性要求时——一条 `bash("rm -rf /tmp/old-build")` 日志比一条带类型化模式的 `delete_build_artifacts(path="/tmp/old-build")` 日志更难审计。

## 实例（Exemplars）

- Anthropic，《Code Execution with MCP》— https://www.anthropic.com/engineering/code-execution-with-mcp — 形式化：智能体把 MCP（Model Context Protocol，模型上下文协议）服务器当作 API 来写代码，与把全部工具定义直接载入上下文相比，token 用量降低 98.7%
- Cloudflare，《Code Mode》— https://blog.cloudflare.com/code-mode/ — 形式化：LLM（大语言模型）更擅长写代码去调用 API，而不是直接做工具调用，因为训练数据中真实代码远多于合成的工具调用示例

## 相关模式（Related）

- `patterns/search-over-list.md`
- `patterns/tools-for-agents.md`
- `patterns/context-is-finite.md`
- `patterns/namespace-tools.md`
