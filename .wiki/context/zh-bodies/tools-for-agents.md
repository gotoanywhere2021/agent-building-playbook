## 这是什么（What it is）

为人类使用而构建的工具以可读性为先：它们分页、用『...』省略号截断长输出、按终端宽度排版、返回假定调用者能追问下一句的友好错误信息。当智能体使用同样的工具时，每一项人类便利特性（human affordance）都成了故障模式。截断的输出意味着智能体基于不完整的图景行动。分页意味着智能体必须知道去取下一页——而且可能意识不到自己没看到全貌。友好错误信息是含糊的字符串，必须解析才能提取真正的失败码。『为智能体设计工具，而不是为人』意味着在『机器需要什么』的层面重新思考契约（contract）：完整、结构化、确定性的输出。智能体工具应尽可能在单次调用中返回全部相关数据，除非数据确实过大。错误情形应以结构化字段表达——一个错误码、一个原因、一个可恢复标志——而不是散文。成功情形应包含智能体判断下一步所需的元数据，而不只是主载荷。调用者不是一个能扫一眼输出就领会上下文的人；它是一个上下文窗口固定、会把收到的任何东西当作完整真理的模型。

## 适用场景（When to reach for it）

- 设计将注册进智能体工具列表的工具时——每个设计决策都应假定调用者是模型，不是在终端里阅读输出的人。
- 把既有 CLI 工具或 API 改造为智能体可用时——找出所有人类便利特性（截断、分页、友好错误信息），替换为机器可读的等价物。
- 当智能体因基于部分或含糊的工具输出而做出错误决策时——根因通常是工具的输出契约，而非智能体的推理。
- 编写工具描述时：描述不是人类悬停在按钮上的提示（tooltip），它是模型用来决定何时以及如何调用该工具的唯一规范。

## 慎用场景（When NOT to）

- 工具确实双用途时——同时被终端里的人与循环中的智能体消费。此时加一个机器可读的输出模式（`--format json`、`--output structured`），而不是替换人类可读的默认值。
- 工具包装了你无法控制的外部 API 时——你无法重新设计契约，把精力放在把外部响应翻译成智能体友好结构的包装层上。
- 当某项『人类便利特性』实际上对智能体有用时——长响应顶部的摘要区可以帮助智能体不必逐条关注所有细节就能推理；不要因为它原本为人设计就删掉有助推理的结构。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：强调工具定义值得投入与整体提示词同等的提示工程（prompt engineering）精力，规范要清晰到工具的用法不留任何歧义
- Anthropic，"Writing effective tools for agents — with agents" — https://www.anthropic.com/engineering/writing-tools-for-agents — 正式化：面向智能体设计工具契约的实用指南——建议用人类可读、语义化的字段名替代晦涩标识符，描述无歧义，响应格式恰好给智能体所需的上下文
- Schick 等，"Toolformer: Language Models Can Teach Themselves to Use Tools"（arXiv:2302.04761）— https://arxiv.org/abs/2302.04761 — 经典先例：确立了模型通过简单 API 使用外部工具的范式，催生了面向智能体的精心设计工具接口的需求

## 相关模式（Related）

- `patterns/namespace-tools.md`
- `patterns/search-over-list.md`
- `patterns/agents-optimize-tools.md`
