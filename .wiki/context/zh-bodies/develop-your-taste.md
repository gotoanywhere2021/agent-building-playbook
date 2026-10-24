## 这是什么（What it is）

品味（taste）是辨认『好』与『够好』之间、『正确』与『对』之间的差别的能力。它不同于技能（skill）：技能是执行的能力；品味是评估（eval）的能力。在传统软件工程中，品味在多年接触生产环境真实系统的过程中养成——看见什么会坏、什么老化得难看、什么保持可维护、什么不能。在 AI 辅助开发中，周期更快，但反馈更嘈杂。产出量急剧增加；评估产出的纪律必须同比例增加，否则品味萎缩。培养品味需要有意识地同时接触好例子与坏例子、练习解释为什么某个东西更好，以及养成对『仅仅合格』的产出保持不满的习惯。它还要求对自己诚实：品味不是偏好，也不是习惯，而是经过校准的判断（calibrated judgment）。一个总是告诉你它产出的东西很好的智能体，不是在培养你的品味——是在把它抹平。在智能体（agentic）环境中给品味命名的一个精确说法是加速之下的稳定判断（consistent judgment under acceleration）：当智能体一次生成许多选项时，能做出好选择的人变得更值钱，而这种判断横跨许多维度——产品品味、架构判断、安全偏执（security paranoia）、领域直觉、组织敏感度、叫停坏路径的意愿、看出某个东西接近正确但尚未完成的眼睛，以及按赌注大小选择恰当流程强度的能力。当生成变得廉价，编辑成为稀缺功能：人的角色转向甄选（curation）与挑选，在系统层面行使编辑判断——决定什么进入产品、拒绝看似合理实则错误的工作、在大量生成工件（artifact）之间保持连贯，以及确保产出服务战略而非局部最优。去找那些范例，研究那些失败，构建那个在你还说不出确切理由之前就告诉你『哪里不对』的内部模型。

## 适用场景（When to reach for it）

- 评审自己智能体运行的产出时：不要只验证它们正确——问它们好不好，并为这个差别建立词汇。
- 设计系统时：不只问一个设计能不能行，还要问它是不是对的设计，并练习解释为什么。
- 评估工具、模式与方法时：把每一次比较当作打磨内部模型的机会，而不只是做一次选择。
- 某个东西感觉不对但说不出为什么时：那种不对的感觉正是品味的早期形态——放慢，说出在困扰你的是什么，精炼判断。
- 阅读他人的代码、文字或设计时：把与优秀作品的每一次相遇当作校准机会。

## 慎用场景（When NOT to）

- 品味不是完美主义：不要拿追求质量当作不发布的理由。品味应当加速判断，而不是诱发瘫痪。
- 当速度确实压倒质量时：有些场景里『合格』就是正确的目标，施加品味级的审视与赌注不成比例。
- 当品味伪装成审美偏好时：区分『对什么有效』的成熟判断与『对自己习惯之物』的个人偏好。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — 《Building Effective Agents》：把智能体工作流的经典模式（提示词链（prompt chaining）、路由（routing）、并行化（parallelization）、编排者-工作者（orchestrator-workers）、评估器-优化器（evaluator-optimizer））整理为可组合构建块——一套用于辨认哪种设计适配哪类问题的共享词汇
- Amplifier — https://github.com/microsoft/amplifier-foundation — foundation 仓库的 context/ 目录随附哲学文档（LANGUAGE_PHILOSOPHY.md、IMPLEMENTATION_PHILOSOPHY.md、KERNEL_PHILOSOPHY.md）；第一篇自称『决策框架，而非处方』——把工程品味写成经过校准的判断，而不是死规矩
- Drew Breunig，《10 Lessons for Agentic Coding》— https://www.dbreunig.com/2026/05/04/10-lessons-for-agentic-coding.html — 第 8 课：当智能体的产出量超过外部反馈的速度，品味成为首要的质量门禁（gate）；本模式提炼得最直接的那篇文章

## 相关模式（Related）

- `patterns/find-the-hard-stuff.md`
- `patterns/agents-amplify-experience.md`
- `patterns/eval-driven-development.md`
- `patterns/leverage-over-efficiency.md`
- `patterns/coaches-and-players.md`
- `patterns/build-five-to-throw-away.md`
