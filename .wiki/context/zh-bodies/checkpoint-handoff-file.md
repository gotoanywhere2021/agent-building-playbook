## 这是什么（What it is）

长任务会积累上下文：已做的决定、已试过的尝试、已发现的状态、已遇到的错误。随着这段历史增长，两种失败模式出现。其一，模型开始过度倚重早期的框定（framing），即便后来的信息本应更新它的做法。其二，上下文被噪音填满——工具输出、中间推理、失败的分支——它们与真正关乎下一步的信号争夺空间。交接文件（handoff file）是解药：一份在检查点（checkpoint）写下的、刻意结构化的文档，只捕获下一个会话真正需要的东西——当前目标、已完成什么、进行中什么、试过又放弃什么及原因、下一个具体动作是什么、相关工件在哪里。读取交接文件的会话从一个干净的上下文窗口开始，里面恰好是这份策划过的简报，而不是一团被继承下来的历史乱麻。写交接这个动作本身就是一次澄清操作——它迫使你从『仅仅发生了什么』里蒸馏出『什么才是要紧的』。

同一个文件，也是日志条目（journal entry）应当成为的样子。好的日志条目是一份交接包，不是含糊的日记：它记录任务目标、最终状态、已做的决定、失败的尝试及其被放弃的原因、未解决的问题、被改动的文件、跑过的测试、值得重访的假设，以及对下一个会话的建议。坏的日志条目叙述感受与活动；好的那一种把下一个会话冷启动续接所需的一切都交到它手上。对于长寿命的智能体人设（persona），日志做的还不止传递任务状态——它巩固风格、目标与『气质』的连续性，让后来的会话不必重放整段转录就能在角色中重启。

## 适用场景（When to reach for it）

- 任务将跨多个会话、上下文必须无损传递基本状态时。
- 当前上下文窗口已填过三分之二而任务尚未完成——剩余的工作交给一个带着交接文件的新上下文，会比继续塞进一个超载的窗口更好。
- 智能体循环即将被重置（系统重启、上下文上限、定时任务结束）时——在重置之前做检查点，而不是之后。
- 在智能体之间、或人与智能体之间交接工作时——交接文件就是接口。
- 调试发现模型锚定在如今已经过时的早期框定上时——交接文件迫使它基于当前状态重新落锚。

## 慎用场景（When NOT to）

- 单会话内即可完成且还有富余的短任务——为一件在同一上下文里就会结束的事写交接文件，开销不值。
- 完整对话历史确实是连续性所必需的任务——有些多轮交互依赖对话线本身，而不只是状态。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — Effective Context Engineering for AI Agents（2025 年 9 月）：把压缩与结构化笔记列为长时程核心技术——其示例智能体把 NOTES.md 持久化在上下文窗口之外、重置后恢复之，这正是本模式推广的『检查点后干净重启』
- Yichao "Peak" Ji, Manus AI — https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus — Context Engineering for AI Agents: Lessons from Building Manus（2025 年 7 月）：把文件系统当作持久外部记忆、反复把 todo.md 背诵进近期上下文以让目标保持聚焦的生产实践——同一模式从经验中得出的版本
- Packer et al., "MemGPT: Towards LLMs as Operating Systems" (arXiv:2310.08560) — https://arxiv.org/abs/2310.08560 — 以分层记忆与操作系统式分页形式化了虚拟上下文管理；『检查点-重启』作为记忆架构的理论模型

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/persist-environment-facts.md`
- `patterns/long-horizon-memory.md`
- `patterns/hang-up-call-back.md`
