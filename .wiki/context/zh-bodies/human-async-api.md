## 这是什么（What it is）

需要人类输入的智能体通常停下来等——把整条流水线阻塞在某个人的日程表上。异步 API 反转把人类当作又一个有延迟、有可用性上限的服务：工作流提交一个持久化请求（一个问题、一个审批、一次纠正），记录自身状态，继续做别的工作，等答复作为信号到达时再恢复。用等待条件，而不是模态弹窗。升级的紧迫程度按出错的代价定价——警报疲劳是真实的失效模式，所以大多数人机触点应该是批量排队式的评审工作，而不是实时打断。

## 适用场景（When to reach for it）

- 长流程中途嵌入审批、纠正或领域问答的工作流。
- 人类可用性远低于流水线可用性（夜间、周末、一个评审对多个运行）。
- 多个运行需要同一位稀缺人类判断的多智能体系统。
- 恢复能力重要：人类答复未决时，工作流必须能挺过重启。

## 慎用场景（When NOT to）

- 真正的同步协作——结对编程、实时引导——对话本身就是产品。
- 答案可预期的琐碎确认——去问评估，别去问人。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1aDpu6zEoP — 《人类是一个异步 API》：基于 Temporal 的配送智能体，人类通过等待条件与信号介入——不阻塞、断线可恢复、升级按出错代价定价
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1v2uB6ZEQF — 《常驻智能体运维生产，无需承担待命负担》：常驻智能体的人机触点是异步队列，不是传呼机

## 相关（Related）

- `patterns/earn-the-interruption.md`
- `patterns/supervise-many-agents.md`
- `patterns/agents-are-distributed-systems.md`
- `patterns/attention-is-the-scarce-resource.md`
