## 这是什么（What it is）

部署不是收尾的终点；它是最有价值的反馈开始涌入的地方，而 agent 系统可以被接上线路去消费这些反馈。信号早已存在——支持消息、Slack 线程、生产事故、用户报告、指标异常——通常它们排着队等一个人去注意到、分诊、复现、修复并发布。生产反馈回路（production feedback loop）把这段距离闭合：把信号直接接入 agent 工作流——用户报告、支持消息、事故或指标异常出现；一个 agent 对照已知问题与近期变更做分诊；agent 判定它是否可行动；若风险低，agent 开分支并提出修复；一个验证工作流对该修复运行；人依据评估的风险批准或驳回；修复在功能旗标（feature flag）或灰度发布之后上线；系统观察原始反馈是否真的消失；经验被写回知识库，让同类问题下次被更快识别。它的力量在于压缩了用户之痛与产品变更之间的环路；它的安全在于环路从不跳过控制——验证、按风险设门的人类批准、分阶段曝光，以及对信号是否清除的观察。这是丰田式生产系统的 agent 版本：在源头观察缺陷，缩小批量让修复持续流动而非堆积成大型高风险发布，闭合反馈回路让问题训练系统，并改进流程本身而不是只打补丁。

## 适用场景（When to reach for it）

- 当真实的用户侧信号（支持、Slack、事故、错误率、指标异常）的积累速度快于人类分诊速度——把它接入一个提出经过分诊、已验证修复的 agent 回路。
- 当你想缩短报告缺陷与修复上线之间的距离，又不移除高风险变更的人类批准闸门。
- 当同类问题反复出现——把回路接线，让每次处置都写回知识库，使识别与分诊随时间改进。
- 当你能把修复绑定到其来源信号并观察信号是否消失——闭环确认修复真的生效，而不只是被合并。
- 当你要的是持续的小修正而非大批量发布——这个回路偏好小的、可逆的、被观察的变更。

## 慎用场景（When NOT to）

- 当修复无法安全地在旗标或灰度发布之后上线、也没有回滚——没有曝光控制，自动化修复回路就是自动化事故回路。
- 当反馈信号太嘈杂或含糊、无法可靠分诊——对误读信号采取行动的回路只会制造无谓的反复（churn）并侵蚀信任。
- 对高风险变更——每个修复无论如何都需要深度人类判断；回路的价值在于压缩低风险、被充分理解的修复，而不是绕过对危险变更的判断。
- 当没有遥测来确认来源信号是否清除——没有闭合的观察，你得到的是一个盲发修复的开环。

## 实例（Exemplars）

- Toyota Production System — https://en.wikipedia.org/wiki/Toyota_Production_System — 本模式所改编的精益纪律：在源头观察缺陷、缩小批量、见信号即停线（stop-the-line）、改进流程而非症状。
- DORA, "Working in small batches" — https://dora.dev/capabilities/working-in-small-batches/ — 实证支持：把小批量命名为一切反馈回路重要之处的必备条件——缩短获得变更反馈的时间，让问题更易分诊与修复。
- Xia et al., "Evaluation-Driven Development and Operations of LLM Agents: A Process Model and Reference Architecture" (arXiv:2411.13768) — https://arxiv.org/abs/2411.13768 — 形式化：把生产反馈形式化为持续的治理回路（EDDOps）：离线评估、在线监控与迭代再开发构成闭环，而非部署前的终点检查站。

## 相关模式（Related）

- `patterns/separate-merge-from-exposure.md`
- `patterns/mine-transcripts.md`
- `patterns/fix-the-root-cause.md`
- `patterns/finishing-is-the-bottleneck.md`
