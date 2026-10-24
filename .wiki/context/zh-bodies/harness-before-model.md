## 这是什么（What it is）

『智能体没有失败，失败的是你的装置（harness）。』模型负责提出方案；装置负责方案之外的一切：什么进入上下文窗口、工具如何呈现结果、状态与权限如何提交、输出如何打分、失败后发生什么。生产环境里大多数智能体故障都能追到外围缺陷——过期的上下文、含糊的工具契约、坏掉的检索、奖励了错误行为的评审——而不是模型能力不足。换模型成本高且容易回归；修装置则是复利：同一套更好的装置，会让下一代更强的模型也变得更强。

## 适用场景（When to reach for it）

- 智能体失败或停滞，而团队的第一反应是『试试更新的模型』。
- 评估分数噪声很大或看起来不对劲——先怀疑打分装置，再怀疑输出。
- 『本应相同』的环境里行为不一致——上下文组装或工具状态在漂移。
- 你正准备整段重写提示词——先检查是不是装置喂了坏输入。

## 慎用场景（When NOT to）

- 最小复现已经证明模型确实做不到这类任务——装置修不出不存在的能力。
- 监管强制指定模型的部署——装置照样要修，但接受模型设下的天花板。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1e9MR6PEjz — 《智能体并未失败，而是测试框架出了问题》（OpenAI）：大多数智能体故障源自周边系统——模型提议，装置负责状态、权限与行动证明
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1DfMe6uEQZ — 《如果约束机制比模型更重要》：可靠性来自引擎周围的控制体系，而不是引擎马力
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV15rL86DEi8 — 《驾驭 AI 工程：Harness 深度解析》：系统梳理装置必须接管什么——上下文、工具、评估、恢复

## 相关（Related）

- `patterns/invest-the-expensive-model-in-the-harness.md`
- `patterns/fail-loud-harnesses.md`
- `patterns/hill-climb-dont-rewrite.md`
- `patterns/deterministic-rails.md`
