## 这是什么（What it is）

当智能体报告某一步骤已完成时，该报告是关于外部结果的断言——不是它的证据。不可观察的步骤，就实际效果而言等于没运行：如果你唯一的信号是智能体自己对成功的声明，你就没有信号。验证不能委托回做出声明的同一个智能体；它必须来自独立来源——一条日志、一个文件、一个下游系统、一个测试，或一次人工检查。

## 适用场景（When to reach for it）

- 任何完成时不留下可独立检视产物的流水线步骤（未写文件、未记录 API 响应、未捕获测试结果）。
- 当工作流一直返回『成功』、但下游效果缺失或错误时。
- 任何时候你发现自己信任智能体对完成的自报，而不是检查实际输出。
- 设计新的智能体工作流时——从一开始就把验证点建进去。

## 慎用场景（When NOT to）

- 平凡、确定性的操作，其输出在上下文中立即可见（例如 LLM 在同一轮返回一个你能直接读到屏幕上的字符串）。
- 已有端到端集成测试自动捕获静默失败的工作流——额外的验证是冗余的，不是增益。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：建议设置人在环（human-in-the-loop）检查点并对智能体输出做显式验证，而不是信任自报
- Amplifier — https://github.com/microsoft/amplifier-bundle-superpowers — superpowers 的 verify 模式：基于证据的完成验证，要求先运行验证命令并读取其输出，然后才允许做出任何成功声明
- Huang 等，"Large Language Models Cannot Self-Correct Reasoning Yet"（arXiv:2310.01798）— https://arxiv.org/abs/2310.01798 — 实证支持：在没有外部反馈时，LLM 无法可靠地识别并修复自己的推理错误；正确性的自报不应被当作验证
