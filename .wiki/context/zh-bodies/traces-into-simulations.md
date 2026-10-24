## 这是什么（What it is）

每一次生产运行都是一次录下来的实验，而且不必付第二次钱。把轨迹变成三样东西：可回放的回归场景（同样的输入，断言行为不劣化）、对抗变体（扰动输入、注入工具故障、偏移分布）、以及替身生产环境的仿真——真实接口、真实工具、经验证器检验的结果。重度押注仿真的团队（『simulation-maxxing』）发布更快，因为每个候选方案都在生产形环境里被打分，而不是对着公开基准；高风险变更的迭代也不必触碰生产。仿真负责加速，不负责替代——现实永远握有最终裁决权。

## 适用场景（When to reach for it）

- 智能体已上生产，每次变更都需要回归保护。
- 想复现的成败案例罕见、昂贵或不宜在生产里重演。
- 公开基准覆盖不了你的领域——用自家流量搭私有基准。
- 需要测试故障处理（工具宕机、畸形响应），而不能故意在生产里触发。

## 慎用场景（When NOT to）

- 冷启动、没有轨迹——先埋点记录（`patterns/emit-events.md`、`patterns/make-runs-replayable.md`）。
- 仿真变成唯一的闸门——分布偏移会让仿真保证悄悄失效（`patterns/safety-guarantees-dont-transfer.md`、`patterns/real-environment-execution.md`）。

## 实例（Exemplars）

- Snorkel AI @ AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1L23T65EDw — 《从智能体轨迹到智能体仿真》：用真实接口与业务流程构建私有基准，配验证器与专家评审回路
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1KMMd69Eeb — 《Simulation-Maxxing：Nubank 如何加速发布智能体》：一家大行的仿真优先发布流水线
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1oTgq6bEDx — 《VendingBench：长时程智能体评估》：长时程基准环境能暴露短评估看不到的东西

## 相关（Related）

- `patterns/make-runs-replayable.md`
- `patterns/standing-eval-capability.md`
- `patterns/real-environment-execution.md`
- `patterns/session-archaeology.md`
