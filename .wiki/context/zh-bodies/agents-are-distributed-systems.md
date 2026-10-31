## 这是什么（What it is）

一旦智能体开始调用工具、走网络、变更外部状态，它就继承了分布式系统的全部失效模式：工具调用超时但其实已经提交、重试导致重复扣款、运行在第 9 步死掉、记忆与权威数据源漂移。把它当作它本来的样子来对待。每次工具调用都是一次可能失败的远程调用——给它幂等键和请求 ID。围绕模型判断的控制流保持确定性。权限最小化、可撤销。每一步都持久化，让运行可恢复而不是从头再来。熔断器、预算与限流拦住重试风暴。记忆是带权威数据源的缓存。这些都不新鲜——是工程界早已学到的纪律，用在一个新的调用方身上。

## 适用场景（When to reach for it）

- 任何做副作用的智能体：写入、采购、部署、外部 API 调用。
- 多智能体拓扑，一个智能体的输出是另一个的输入。
- 必须能在中断后恢复的长时程流水线。
- 事后复盘时，『智能体行为怪异』需要精确机制，而不是耸肩。

## 慎用场景（When NOT to）

- 一次精心打磨的 LLM 调用、无外部状态——这套纪律在那里纯属开销（`patterns/start-least-agentic.md`）。
- 纯本地文件上的纯计算，所有状态都在进程内、重做成本极低。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1i3tU6TEeb — 《AI 智能体现如今不过是分布式系统》：幂等键、最小权限、补偿操作、熔断器，以及『记忆 = 带权威数据源的缓存』
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1o3tU6TEbE — 《智能体所处阶段，如同 2015 年的微服务》：智能体将经历的运维成熟度曲线，以及现在就该抄的作业
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV178gS6AEke — 《我们为何终止了多智能体管道项目》：一份复盘——压垮项目的不是模型质量，而是缺失的分布式系统纪律

## 相关（Related）

- `patterns/three-primitives.md`
- `patterns/deterministic-rails.md`
- `patterns/make-runs-replayable.md`
- `patterns/workflows-vs-agents.md`
