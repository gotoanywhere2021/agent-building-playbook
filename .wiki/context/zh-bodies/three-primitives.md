## 这是什么（What it is）

智能体系统——无论看起来多复杂——都归结为三种核心操作：LLM 调用（把上下文发给模型、接收生成文本）、工具调用（执行一个函数并返回结果）、循环（基于某个条件重复上述某种组合）。其余一切都是组合：工作流是 LLM 调用与工具调用的序列；智能体循环是在循环内由 LLM 调用选择工具调用；多智能体系统是多个智能体循环，其中某些工具调用会触发其他 LLM 调用；检索增强流水线（retrieval-augmented pipeline）是一次 LLM 调用，其输入由一次执行搜索的工具调用填充。深刻理解这三种原语（primitive）会改变你设计系统的方式。当一个工作流不奏效时，你可以在原语层面推理：哪一次 LLM 调用产出了错误输出？哪一次工具调用返回了意外结果？循环条件在哪里失效？你不需要理解抽象层——可以剥掉它，直接看原语。这对调试、性能分析以及设计正确的抽象层级都至关重要。建立在命名清晰、显式的原语之上的系统是透明的；把这些原语藏在层层抽象之后的系统，一旦出问题就是不透明的。

## 适用场景（When to reach for it）

- 从零设计新的智能体系统时——从三种原语出发向上组合，而不是采用一个框架、从它的抽象向下工作。
- 当工作流失败且原因不明时——把它化约为原语操作，逐一单独检视，找出哪个原语在产生错误行为。
- 评估框架或编排库时——弄清它暴露哪些原语、隐藏哪些；优先选择在需要时允许直接触及原语行为的框架。
- 为智能体构建工具时——工具调用是三种原语之一；工具设计是一等关注点，不是配置细节。

## 慎用场景（When NOT to）

- 当系统复杂到直接管理原语易出错、且更高层抽象已被充分验证时——规模化之后，对每个操作都停留在原语层面并不高效；例行编排用抽象，调试或优化时再降回原语。
- 当构建系统的团队需要框架抽象提供的护栏（guardrail）时——并非每个团队都有时间或上下文为每种交互模式直接管理原语。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：把『增强了检索、工具与记忆等扩展的 LLM』视为智能体系统的基本构件，并警示框架抽象层『可能遮蔽底层的提示与响应，使其更难调试』——这正是保持原语可见的理由
- Amplifier — https://github.com/microsoft/amplifier — 内核暴露三种核心机制：模型调用、工具分发与 recipe 循环；框架中所有更高层的行为都由这三种原语组合而成（据 Amplifier 团队白皮书；当前公开内核的自我描述不同——会话生命周期、模块加载、事件与协调）
- OpenAI，"A practical guide to building agents" — https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/ — 把每个智能体分解为三个结构组件：模型、工具与指令；这是来自另一条轴线（配置 vs. 执行）的类似原语分解框架

## 相关模式（Related）

- `patterns/composable-patterns.md`
- `patterns/tools-for-agents.md`
- `patterns/workflows-vs-agents.md`
- `patterns/start-least-agentic.md`
