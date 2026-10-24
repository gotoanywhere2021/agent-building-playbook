## 这是什么（What it is）

测试不是对可用代码的注解——它们是关于代码应该做什么的可执行规范（specification）。当 API 变更时，测试表达的是新契约（contract）。先更新测试——在动实现之前——迫使你为『变更后的 API 应该做什么』做出具体决定，暴露会被破坏的调用方（因为测试更新会把它们显形），并产出一套失败的测试来引导实现。相反的顺序——先改实现、再把测试改成匹配——会让实现定义规范，而不是规范定义实现。这是测试积累『测试漂移（test drift）』的主要途径：测试描述的是代码*做什么*而不是它*应该做什么*，且永远抓不到这个差别。在 API 变更时先更新测试，与 TDD 中『先写测试再写代码』是同一条纪律，应用于修改场景：测试即规范，规范先于构建。它还产生一个清晰的提交边界（commit boundary）——『更新测试以反映新 API 形态』是一个可评审的产物，先说明变更是什么；『更新实现以匹配新规范』再说明变更如何实现。

## 适用场景（When to reach for it）

- 任何 API 签名变更时（参数增删、重命名或改类型）——先更新调用方的测试期望，再更新实现，然后验证尚未更新的调用方会被新失败的测试捕获。
- 重构接口时：先针对重构后的目标接口写测试，验证它们对当前实现失败，然后执行重构直至测试通过。
- 修复由错误行为引起的 bug 时：先写一个证明当前行为错误的测试（它失败），再修复实现直至测试通过。不要先修复、再事后补回归测试。
- 评审他人的 API 变更时：问一句测试是否先于实现被更新。若不是，测试描述的是被建出来的东西，而非打算建的东西。
- 当测试套件陈旧、未在 CI 中运行时：第一任务是让它跑起来，而不是跳过测试。跑不起来的测试不是测试——它们是注释。

## 慎用场景（When NOT to）

- 被变更的 API 还没有测试时——先为当前行为写测试，再按目标新行为更新它们，然后实现。不要直接跳到实现。
- 变更是纯粹内部重构、无可观察行为变化时——测试不应变化，并应全程通过。重构期间测试若变了，说明重构也在改变行为。
- 被变更的 API 没有测试、且不投入大量基础设施工作就无法测试时——优先建设基础设施以便纪律可被应用，而不是制造一个不讲原则的例外。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：建议构建评估（eval）并对照其迭代实现；在动系统之前先更新评估以编码目标行为，正是这一立场应用于 API 变更
- Amplifier — https://github.com/microsoft/amplifier-bundle-superpowers — superpowers 的实现者智能体在严格 TDD 下工作，配有建立在红-绿-重构（red-green-refactor）循环之上的 test-driven-development 技能；应用到修改场景，该纪律变为：先把测试更新为新契约，再更新代码使其通过
- Kent Beck，*Test-Driven Development: By Example*（2002）— https://www.informit.com/store/test-driven-development-by-example-9780321146533 — 经典先例：确立了红-绿-重构循环，失败的测试先写、即规范；在实现之前更新测试，正是这条纪律应用于修改场景

## 相关模式（Related）

- `patterns/eval-driven-development.md`
- `patterns/test-what-not-how.md`
- `patterns/keep-specs-in-sync.md`
