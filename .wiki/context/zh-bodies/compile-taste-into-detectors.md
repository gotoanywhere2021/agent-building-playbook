## 这是什么（What it is）

让模型『做得好看点』，得到的是每个模型都会产出的同一种页面：米色底、默认字体、渐变卡片。原因很简单——靠模型自己的判断力去把握品味，它就会退回到训练数据里最常见的平均值；但品味**出错的那些固定套路**（一眼假的那种）恰恰是可以逐条检查的。这个模式的做法是：把已知的套路写成一条条确定性规则（就是普通 linter、规则引擎、钩子脚本，**完全不经过大模型**），由它们扫描智能体改过的每个文件，有问题就不许宣布『做完了』。分工是：检测器管否定面——那些能叫得出名字的俗套（『万物用 Inter 字体』『紫蓝渐变』『卡片里再套卡片』『留白挤成一团』『对比度不达标』）；模型判断管肯定面——构图、概念、那些规则永远想不到的大胆一击。还有一个关键：检测器挂在编辑钩子上自动运行，而不是等谁想起来去评审——『AI 味检查』在智能体说『做完了』之前就已经执行过了。

## 适用场景（When to reach for it）

- 某类产出会退化成固定俗套的领域（界面、文案口吻、幻灯片、提交信息），而且评审总在重复抓同样的毛病。
- 你已经能把套路说清楚——每条规则就是一个有名字、有判断阈值的失效模式。
- 评审环节是瓶颈：把品味评审里重复的那一半交给自动检查，人的注意力留给真正的判断。

## 慎用场景（When NOT to）

- 还说不成规则的品味——先写评分细则、攒好坏样例（`patterns/good-pile-bad-pile.md`）；含糊的检测器比没有更糟。
- 担心规则把风格冻成教条——所以必须带 allow/ignore 白名单通道并定期修订；检测器编码的是昨天的品味，要一直容易修改。
- 更适合打分评判的性质——检测器只能抓『是/否』级的套路；排序与微妙差别仍归评审（`patterns/calibrate-the-judge.md`）。

## 实例（Exemplars）

- pbakaus/impeccable — https://github.com/pbakaus/impeccable — 62 条确定性规则，专抓 AI 生成界面的固定套路（『万物用 Inter 字体』『紫蓝渐变』『卡片里套卡片』），三种运行方式：完成前扫描每个 UI 文件的智能体钩子、命令行工具、浏览器浮层；脱胎于 Anthropic 的 frontend-design 技能
- Simon Willison 谈 linting 即品味 — https://simonwillison.net/2020/Feb/11/codespell/ — 通用形态：把反复出现的人工评审发现编码成自动检查，让检查活得比评审者的注意力更久

## 相关（Related）

- `patterns/critic-applications.md`
- `patterns/self-verification.md`
- `patterns/fail-loud-harnesses.md`
- `patterns/develop-your-taste.md`
- `patterns/good-pile-bad-pile.md`
