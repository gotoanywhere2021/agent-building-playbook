## 这是什么（What it is）

LLM 当评审（LLM-as-judge）把人类式打分规模化，而且它会自信地说谎：偏袒自家模型家族的风格、对『看起来像样』的输出谄媚、偏爱更长的答案、评分标准随版本漂移。把评审分数当作一台带偏差仪器的读数，使用前必须校准。确定性验证器——测试、解析器、schema 检查、仿真——永远优先，因为它们没法被好话哄住；LLM 评审只填机械检查够不到的空间。一台校准过的评审应该有：固定的评分细则、一组公认好坏样例构成的校准集（且能证明它能分开）、随时间跟踪的一致性，以及对争议判决的多评审交叉。

## 适用场景（When to reach for it）

- 在评估套件或 CI 质量门里自动给智能体输出打分。
- 用模型分数作为自我改进或优化回路的奖励信号——未校准的评审会把系统优化向它自己的偏见。
- 比较候选提示词、技能或模型——小幅差异必须是真的才作数。

## 慎用场景（When NOT to）

- 确定性检查已经完全覆盖你关心的性质——能断言的就别打分。
- 数量少到人能逐条读完——把力气花在给人用的评分细则上。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1j9p76zEUr — 《你的 LLM 评审是个自信的骗子：构建更好的验证器》：未校准 LLM 评审的失效模式与更强的验证器设计
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1ftKs6QEpW — 《在智能体的国度里，验证器为王》：验证质量是智能体系统的绑定约束
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1pXKr66Eg7 — 《构建真正要紧的评估》：让评估设计扎根于真实价值，而不是榜单表演
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1win26oEyU — 《用 Phoenix 与 Claude 评估高风险 AI 智能体》：评审行为可观测的追踪与打分流水线

## 相关（Related）

- `patterns/eval-driven-development.md`
- `patterns/standing-eval-capability.md`
- `patterns/adversarial-parallel-review.md`
- `patterns/critic-applications.md`
