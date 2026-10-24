## 这是什么（What it is）

检验系统*如何*达成结果的测试，与实现耦合——实现一变，测试就坏，哪怕行为依然正确。检验系统*做了什么*（从外部观察）的测试，与实现解耦——只有行为改变时它才会坏，而那正是它该坏的时候。这个区别并不微妙：『断言该函数以这些参数被调用』是 how 测试（how-test）；『断言调用这个 API 之后，数据库里存在这条记录』是 what 测试（what-test）。what 测试描述产品的可观察契约（contract）；how 测试描述产品当前的内部接线。智能体系统最容易在这条纪律上失守，因为智能体是不透明的——其内部推理不可检视——这诱使开发者去测试智能体调用了哪些工具，而不是它产出了什么结果。测试智能体调用了哪些工具是 how 测试；测试智能体本应产出的产物（artifact）是否存在、是否正确、是否可用，是 what 测试。前者在工具实现或选择逻辑变化时就会坏；后者只在智能体不再履行职责时才坏。

当测试本身由智能体生成时，风险更尖锐。智能体为自己写的代码所写的测试，可能过拟合于它恰好看到的实现，或编码了与产生该代码时一模一样的误解——这种情况下，测试通过、代码错误、而测试为这个 bug 背书。更多的测试解决不了这个问题；它们只会放大共享的盲区。每种测试类型都带有自己版本的这类失败，一个收尾中的系统应把测试类型的选择当作权衡而非默认：单元测试可能过拟合实现细节；集成测试（integration test）往往脆弱；端到端测试（end-to-end test）慢且不稳定（flaky）；变异测试（mutation test）昂贵且嘈杂；性质测试（property test）的好坏取决于它断言的不变量；对抗测试（adversarial test）容易欠规定；视觉测试（visual test）需要良好的基线与容差。因此智能体的机会不只是写更多测试，而是把测试的生成、批判、执行与修订做成工作流图上的节点——由独立的批判者（critic）挑战测试，让套件真正针对真实行为运行，让失败反馈到代码与测试的双重修订中，而不是让单个智能体批改自己的作业。

## 适用场景（When to reach for it）

- 为任何函数、智能体或流水线步骤编写测试时：先确定外部可观察的结果，针对它写断言，然后在添加实现之前验证该测试会失败。
- 当测试频繁因重构而坏、行为却未改变时——这是 how 测试的标志；把它们改写成 what 测试。
- 测试智能体行为时：定义智能体应产出的产物（写出的文件、数据库状态、以正确载荷调用外部系统的 API 调用），而不是内部工具调用的序列。
- 当代码库有测试、开发者却仍然害怕重构时——那些测试几乎肯定是 how 测试。把它们改写为 what 测试，才能恢复它们本应提供的安全感。
- 调试一个测试通过率很高、生产行为却不可靠的系统时——how 测试容易通过，因为它们测的是内部一致性，不是外部正确性。

## 慎用场景（When NOT to）

- 当实现细节本身就是可观察行为时——在性能关键代码中，数据库查询次数就是对外承诺的保证，此时测查询次数是 what 测试，不是 how 测试。
- 当你专门在测集成路径、需要确认某个外部服务被调用过（而非调用的效果发生）时——此时调用本身就是可观察契约，不是实现细节。
- 测试本质上是关于系统*不做什么*的安全属性时——某些调用或状态变更的缺失是合法的 what 测试。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：指出编码智能体的解可通过自动化测试验证——这是输出正确性的评估立场，而非对中间工具序列的检查
- Amplifier — https://github.com/microsoft/amplifier-bundle-superpowers — superpowers 的 verify 模式检查真实的命令输出，而不是智能体是否报告自己运行了正确的命令——『运行命令。读输出。然后再宣称。』
- Kent C. Dodds — https://kentcdodds.com/blog/testing-implementation-details — 出处：命名并论证了测试实现细节的危害；『你的测试越像软件被使用的方式，它们能给你的信心就越多』（2020）
- Freeman & Pryce，*Growing Object-Oriented Software, Guided by Tests*（2009）— https://www.informit.com/store/growing-object-oriented-software-guided-by-tests-9780321503626 — 经典先例：『单元测试行为，而非方法』——由外而内的验收测试是首要的设计驱动，而非内部状态

## 相关模式（Related）

- `patterns/eval-driven-development.md`
- `patterns/evidence-before-assertions.md`
- `patterns/demand-independent-proof.md`
