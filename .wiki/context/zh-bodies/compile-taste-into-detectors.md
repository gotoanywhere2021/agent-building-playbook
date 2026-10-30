## 这是什么（What it is）

让模型『做得好看点』，你得到的是每个模型都会产出的那一种米色页面、默认字体栈和渐变卡片——因为靠判断力执行的品味会回归分布，而品味的**失效模式**恰恰是完全可以检查的。这个动作把『破相点』编译成确定性规则——不掺 LLM：linter、规则引擎、钩子脚本，扫描智能体碰过的每个工件，发现未清就不许宣布完成。检测器拥有否定面（六十来种可命名的俗套、局促的留白、对比度失败）；模型判断保留肯定面（构图、概念、规则建议不出来的大胆一击）。关键在于检测器挂在编辑现场的钩子上自动运行，而不是某个评审环节——slop 检查在智能体说『做完了』之前就已开火。

## 适用场景（When to reach for it）

- 产出质量会退化成可识别俗套的领域（UI、文案口吻、幻灯片、提交信息），而且评审总在抓同样的毛病。
- 你已经能精确说出破相点——每条规则是一个有名有阈值的失效模式。
- 评审是瓶颈：把品味评审中重复的那一半推进闸门，人的注意力留给判断。

## 慎用场景（When NOT to）

- 还说不成规则的品味——先写评分细则、攒样例（`patterns/good-pile-bad-pile.md`）；含糊的检测器比没有更糟。
- 会把风格冻成教条的年代——必带 allow/ignore 通道并定期修订；检测器编码的是昨天的品味，要易于修改。
- 更适合评分判断的性质——检测器抓二元破相点；排序与微妙之处仍归评审（`patterns/calibrate-the-judge.md`）。

## 实例（Exemplars）

- pbakaus/impeccable — https://github.com/pbakaus/impeccable — 62 条确定性规则标记 AI slop 破相点（『万物 Inter』、紫蓝渐变、卡片套卡片），三种运行方式：完成前扫描每个 UI 文件的智能体钩子、CLI、浏览器浮层；脱胎于 Anthropic 的 frontend-design 技能
- Simon Willison 谈 linting 即品味 — https://simonwillison.net/2020/Feb/11/codespell/ — 通用形态：把反复出现的人工评审发现编码成自动检查，让检查活得比评审者的注意力更久

## 相关（Related）

- `patterns/critic-applications.md`
- `patterns/self-verification.md`
- `patterns/fail-loud-harnesses.md`
- `patterns/develop-your-taste.md`
- `patterns/good-pile-bad-pile.md`
