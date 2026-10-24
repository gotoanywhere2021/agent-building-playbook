## 这是什么（What it is）

一个对着 mock、stub 或缩水的本地仿制品来测试部署的 agent，并不是在测试部署——它在测试 mock。环境是承重结构（load-bearing）。生产系统依赖特定的网络拓扑、真实的服务版本、实际的资源约束、真实的延迟，以及一个已连续运行数月的系统所累积的配置漂移。这些没有一样会出现在模拟中。在恰当环境中执行负载的 agent 会发现任何其他上下文都不可见的问题：低负载下正常、真实并发下崩溃的服务；真实机器上存在而 CI 镜像中不存在的文件路径；某个次要更新中改变了形状、而其测试替身（test double）从未同步的 API 响应。在恰当环境中运行负载不是偏好——它是生成携带着真实系统信息的证据的唯一途径。模拟运行产生信心，不产生知识。

## 适用场景（When to reach for it）

- 验证一个部署真的在服务流量时：让一个真实请求穿过真实技术栈，而不是对『服务已启动』做合成断言。
- 性能特征重要时：在目标环境之外跑的基准测试，测量的是错误的机器、错误的内存总线和错误的争用模式。
- 服务间集成是问题所在时：集成问题在真实网络中显形，而不是在绕过序列化、认证与路由的本地 mock 里。
- 调试生产故障时：在与生产匹配的环境中复现故障。在本地开发环境中诊断生产崩溃是假设生成，不是调试。
- 评估 agent 的工具输出时：如果 agent 的工具运行了一条命令，这条命令应当对着真实目标系统运行——而不是本地近似——其输出才能用于决策。

## 慎用场景（When NOT to）

- 真实环境用于测试具有破坏性时——对着生产数据库、在线金融系统或共享基础设施，一次测试运行会产生真实影响。使用结构上相同但隔离的 staging 环境。
- 早期开发阶段恰当环境不可用、本地近似是唯一选项时——接受早期结果是临时性的并如此标注；不要把它们当作关于真实系统的证据。
- 在真实环境中运行真实负载的成本相对测试价值过高时——比例原则适用。不是每次代码变更都需要完整的生产端到端副本运行。
- 环境本身正处于配置变更之中、运行真实负载会在变更被验证之前破坏状态时。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：强调 agent 应当在每一步从环境获取地面真值（ground truth）——工具调用结果与代码执行输出——以评估真实进度。
- Amplifier — https://github.com/microsoft/amplifier-bundle-digital-twin-universe — Digital Twin Universe bundle 按需拉起完整、隔离的容器环境，『模拟代码将要生活的世界』——代码本身真实运行，外部服务以 sidecar 容器 mock——让 agent 能像真实用户一样 clone、安装、运行并体验一次变更；这是对恰当环境的刻意近似，不是环境本身。
- Adam Wiggins, "The Twelve-Factor App: X. Dev/Prod Parity" — https://12factor.net/dev-prod-parity — 2011 年的经典表述：『让开发、staging 与生产尽可能相似』；本模式应用于 agent 负载环境的软件工程基础原则。
- Cindy Sridharan, "Testing in Production: the hard parts" — https://copyconstruct.medium.com/testing-in-production-the-hard-parts-3f06cefaf592 — 把 dev/prod parity 延伸到分布式系统；论证许多失败模式在真实分布式系统之外不可见，而对在真实地方运行真实负载的正确回应是波及半径管理——不是回避。
- 2389 Research, scenario-testing — https://github.com/2389-research/scenario-testing — 一方实践（first-party）：一个强制执行『在场景通过真实依赖之前，没有任何特性被验证』的插件——对着真实系统的端到端场景位于其真值层级顶端，mock 被直称为虚假信心。
- 2389 Research, ish — https://github.com/2389-research/ish — 一方实践：一个『第三方 API 的数字孪生』（Google、GitHub、Twilio、Discord 等），带持久状态、请求日志与 webhook 模拟——正是为本模式专门划出的例外（真实服务烧配额或对其测试有破坏性）而建的刻意 mock。

## 相关模式（Related）

- `patterns/evidence-before-assertions.md`
- `patterns/self-verification.md`
- `patterns/emit-events.md`
