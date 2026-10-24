## 这是什么（What it is）

智能体会执行 shell 命令、写文件、调用网络，而判断力并不完美——网页、代码仓库、工单这类不可信内容更是常驻的提示注入入口。沙箱（容器、MicroVM、devcontainer、一次性云工作区）把『智能体可能搞破坏』从一场灾难，降级为『删掉沙箱重来』的一次事件。隔离不是对模型的不信任：它约束的是错误上下文、被注入的指令、被污染的依赖和普通失误的爆炸半径。工程实践已经收敛出隔离层级（操作系统用户 → 容器 → MicroVM → 一次性云舰队），而无人值守的『YOLO 模式』执行，只有在沙箱之内才被视为可接受。

## 适用场景（When to reach for it）

- 任何执行生成代码或未审代码的智能体：编码智能体、评估装置、批处理流水线。
- 无人值守或定时运行、每步动作没有人类确认的场景。
- 一边读取不可信内容一边执行的智能体——经典的注入链路。
- 你没有亲自编写过的第三方智能体、技能或插件。

## 慎用场景（When NOT to）

- 对非敏感数据做只读分析、且每步都有人类确认的场景。
- 本身就以共享可变状态为目的的长生命周期基础设施——这时应该隔离智能体的工作区并收紧凭证（见 `patterns/zero-standing-credentials.md`），而不是假装整个世界都能被装进沙箱。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1HgJ26DEdc — 《沙箱并非可选》：梳理编码智能体的四种实用隔离方案，主张隔离应当是默认项而非事后补救
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1VYpG6UEmh — 《我如何学会不再担忧并爱上沙箱》：把智能体执行全面搬进沙箱的实践者自述
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1oaH96iEio — 《YOLO 模式的安全：面向任意智能体的 MicroVM 沙箱》（Docker）：用 MicroVM 级隔离让无人值守执行变得安全
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1XoNm6TE5F — 《从 Fork 到舰队：设计一个智能体沙箱云》：把成队的隔离智能体环境做成服务需要什么

## 相关（Related）

- `patterns/zero-standing-credentials.md`
- `patterns/deterministic-rails.md`
- `patterns/autonomy-when-justified.md`
- `patterns/real-environment-execution.md`
