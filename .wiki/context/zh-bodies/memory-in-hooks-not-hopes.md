## 这是什么（What it is）

靠纪律的记忆（『结束时把笔记写了』）恰在关键时刻失效：会话戛然而止、上下文压缩吃掉中段、崩溃丢掉尾巴。稳健的设计让捕获成为基础设施的副作用：在生命周期边界挂钩子——会话开始、提交提示词、工具调用、会话结束——无需任何智能体或人选择『保存』，观察就写进持久存储。检索是另一半：会话开始时自动重注入相关上下文，并暴露按词元计价的分层搜索——紧凑索引（每条约 50–100 token）、时间线、然后只为选中的 ID 取全文——先过滤后取详能省一个数量级的上下文。隐私通道从第一天就要有：一个排除标记（`<private>` 标签）让敏感内容根本进不了存储，因为没有排除设计的自动捕获就是留存负债。

## 适用场景（When to reach for it）

- 跨会话、跨工具的智能体工作：重启、压缩、工具边界之间的连续性要紧。
- 事故考古：你需要智能体实际做过什么，而不是它记得自己做过什么（`patterns/session-archaeology.md`）。
- 喂蒸馏流水线：钩子捕获的观察是 `patterns/memory-into-skills.md` 晋升为技能的原料。

## 慎用场景（When NOT to）

- 没有未来读者的一次性会话——捕获基础设施纯属开销。
- 无排除设计的受监管或隐私敏感场景——在 `<private>` 式通道就位之前，自动捕获就是留存负债。
- 替代蒸馏——不断堆高的观察堆是存储不是知识；钩子喂流水线，技能才是产品（`patterns/mine-transcripts.md`）。

## 实例（Exemplars）

- thedotmack/claude-mem — https://github.com/thedotmack/claude-mem — 在 SessionStart/UserPromptSubmit/PreToolUse/PostToolUse/Stop/SessionEnd 挂钩，把观察写入 SQLite + 向量库；分层检索（搜索约 50–100 token/条 → 时间线 → 全文约 500–1,000 token）宣称『先过滤后取详省约 10 倍 token』；`<private>` 标签把敏感内容挡在存储之外
- Anthropic《Effective Context Engineering for AI Agents》 — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — 本模式所自动化的压缩与笔记框架：边界事件后保留什么，是设计决策而非习惯

## 相关（Related）

- `patterns/long-horizon-memory.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/memory-into-skills.md`
- `patterns/mine-transcripts.md`
- `patterns/scope-and-expire-memory.md`
