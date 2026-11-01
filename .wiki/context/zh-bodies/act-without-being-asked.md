## 这是什么（What it is）

默认的智能体等着被调用，于是所有活在『请求之间』的工作永远不会发生——团队群里讨论到的 Bug、没人重新触发的失败 CI、没人回复的会议邀请。Super-agent 设计把它倒过来：智能体持续监听环境事件（群聊、邮件与日历、代码评审评论、CI 结果）作为一等 **Trigger（触发器）**，经两段式过滤——先程序规则，后大模型语义判断（『这需要行动吗？』）。同一话题或同一 PR 下的触发序列构成一条 **Thread（任务线）**，即任务状态的单位。主动性有两挡：响应式（回应被允许的触发）与投机式（按价值假设推进工作——收到会议邀请就预查日历冲突并起草回复；收到 Bug 报告就尝试复现并找修法）——交付以确认为闸门：投机结果只在确认简单修法存在之后才交出去，绝不当噪声。后台完成的事作为事件重入循环——长工具调用立即返回『已启动』——让智能体保持连续，而不是被请求绑定。

## 适用场景（When to reach for it）

- 共享团队环境（仓库、聊天空间）：有价值的工作可见但无人认领——智能体行动而不占用任何人的注意力预算。
- 值守职责：CI、收件箱、评审队列、等值班信号——今天都在等人发现。
- 权限轨道清晰的个人助理场景——智能体预备，人类确认。
- 省去来回切换：一个连续智能体推进多条任务线，而不是人在 3–5 个活跃会话之间跳来跳去。

## 慎用场景（When NOT to）

- 高噪声、无过滤纪律的环境——两段式过滤是强制项，否则智能体就是警报疲劳制造机。
- 不可逆或高风险动作——主动性只决定『何时开始』，绝不绕过权限闸门（`patterns/autonomy-when-justified.md`、`patterns/zero-standing-credentials.md`）。
- 人类注意力本身就是稀缺交付物时——只在判断真正成为瓶颈时打扰（`patterns/earn-the-interruption.md`）。

## 实例（Exemplars）

- DeepSeek Harness 团队，《Super-agent 设计探索：迈向更自主的 Agent 系统》（官方公众号，2026-10-31；转载镜像） — https://tech.ifeng.com/c/8xg9tbvWnnf — 出处：四特征（连续/高效/主动/持久）、Trigger→Thread 事件模型、两段式过滤、投机执行确认后交付，以及群聊中未被 @ 而修 Bug 提 PR 的实测案例
- deepseek-ai/dsh-superagent-prototype — https://github.com/deepseek-ai/dsh-superagent-prototype — 『尽可能少占人类注意力，尽可能多给价值』：绑定单个仓库的主动编码智能体，监听 GitHub（可选飞书），按请求或团队写下的规则开工作项，且『只在有人必须行动或有人能用上结果时才说话』

## 相关（Related）

- `patterns/workers-execute-router-speaks.md`
- `patterns/earn-the-interruption.md`
- `patterns/autonomy-when-justified.md`
- `patterns/deterministic-rails.md`
- `patterns/production-feedback-loop.md`
