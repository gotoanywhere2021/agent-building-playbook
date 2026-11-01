## 这是什么（What it is）

工作长过单个循环之后，通信拓扑决定系统是否还保持一致。路由/工人的答案是：**Router** 独占人类交互、维护全局上下文并分派任务；**Worker** 在相互隔离的会话中执行具体工作，把状态与结果回报给 Router——从不直接回复用户。任务单位是 **Thread**：一个 IM 话题或一个 PR 下的触发序列；负载高时 Worker 可直接订阅自己的 Thread，让相关事件绕过路由。长工具调用异步化——start/stop、立即返回『已启动』——结果作为事件重入，路由器在工作运行时保持响应。压力下该设计摊薄良好：触发负载从每分钟约 1 提到 40，平均批量 1.0→2.8、单请求延迟 2.5s→3.9s，而单次决策推理成本**下降** 6.4s→1.6s——批处理积压反而提升吞吐。动机是人的不是机器的：一个人只能同时跟进 3–5 个活跃会话，一个持久智能体推进多条 Thread，胜过人在并行聊天之间来回切换。

## 适用场景（When to reach for it）

- 助理型系统：人类是听众，且需要一个一致的口吻——各说各话的专家提示词正是要避免的失败。
- 混合事件流（issue、PR、群聊、CI）的多工人仓库或团队——否则就是 N 个要人盯的并行会话。
- 实测瓶颈是会话切换而非模型能力时。

## 慎用场景（When NOT to）

- 验收可机械裁决的无主管群体——认领与合并自洽时，路由器是瓶颈不是助力（`patterns/shared-loop-not-supervisor.md`）。
- 单循环装得下的工作——为一个智能体的活建两层是过度设计（`patterns/start-least-agentic.md`）。
- 某个工人必须直接面对用户的场景——这是唯一值得完整交接的情形（`patterns/split-by-context-not-org-chart.md`）。

## 实例（Exemplars）

- DeepSeek Harness 团队，《Super-agent 设计探索：迈向更自主的 Agent 系统》（官方公众号，2026-10-31；转载镜像） — https://tech.ifeng.com/c/8xg9tbvWnnf — 出处：Router 承接人类交互并分派，Worker 在隔离会话中并发执行且不直接回复用户；Thread = 一个 IM 话题或一个 PR 的触发序列；压测数据（批处理摊薄单次推理 6.4s→1.6s）
- deepseek-ai/dsh-superagent-prototype — https://github.com/deepseek-ai/dsh-superagent-prototype — 原型形态：网页面板『显示什么需要人』，智能体『在原对话中回复』（例如附上 PR）——路由器持有的界面，每条 Thread 一个声音

## 相关（Related）

- `patterns/act-without-being-asked.md`
- `patterns/split-by-context-not-org-chart.md`
- `patterns/shared-loop-not-supervisor.md`
- `patterns/supervise-many-agents.md`
- `patterns/match-agent-metaphor-to-layer.md`
