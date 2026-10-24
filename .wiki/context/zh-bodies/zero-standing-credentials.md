## 这是什么（What it is）

持有常驻 API key、数据库密码或 OAuth 令牌的智能体，距离一次提示注入或上下文投毒引发的大规模数据外泄只隔一个事件。正确做法是把信任模型倒过来：智能体手里一个秘密都没有。每一个敏感动作都通过代理层——代理网关、审批服务——完成：代理层认证工作负载、为这一次操作签发最小范围的授权、盖上可审计的回执，然后立即过期。人类保留最高权限，智能体携带的只是可委托、可撤销、按次发放的凭证证明。『你的智能体该有几个凭证？』在生产环境里已经有了答案：零个。

## 适用场景（When to reach for it）

- 任何触达数据库、云账号、支付系统或第三方 API 的智能体。
- 在多租户环境中运行他人智能体的平台。
- 代表终端用户操作用户级资源的智能体。
- 一边读取不可信内容、一边持有任何形式访问权的智能体——注入会把『读』变成『做』。

## 慎用场景（When NOT to）

- 用你自己的开发环境跑一次性本地原型——威胁模型更小，但仍然优先做范围收敛。
- 完全离线、无外部触达、只用合成数据的评估。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV179p76zEMD — 《你的 AI 智能体应该拥有多少凭证？零个》：论证每个特权动作都应该走代理发放，而不是直接把秘密交给智能体
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1MBJ26aEAq — 《AI 代理如何泄露秘密，以及如何阻止》：过度授权智能体的具体外泄路径与缓解措施
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1dzg66PE6m — 《更优的代理认证》：为智能体而设计的身份与委托模式，而不是复用人类登录流程

## 相关（Related）

- `patterns/sandbox-by-default.md`
- `patterns/guardrails-and-escalation.md`
- `patterns/governance-is-infrastructure.md`
- `patterns/proposer-authority-separation.md`
