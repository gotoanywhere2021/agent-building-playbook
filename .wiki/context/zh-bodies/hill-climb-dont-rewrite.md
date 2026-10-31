## 这是什么（What it is）

智能体改进是一个优化问题，不是文章重写。爬山法：跑一遍评估套件，只改一处（一条提示子句、一个工具描述、一个检索参数），再跑一遍，分数涨就保留，不涨就回滚。这套纪律杀死了智能体迭代的两大顽疾——凭感觉的『整体重写』悄悄造成回归，以及改了之后没人说得清哪一步起的效。基于反思的方法（GEPA 一类）证明：模型读自己的失败轨迹，就能自己提出这些增量。复利效应是，每一条被挖掘的失败都变成永久的评估用例——评估套件恰好在系统最弱的地方生长。说到底，改进智能体是一个数据挖掘问题。

## 适用场景（When to reach for it）

- 有一定频率地迭代提示词、技能、工具描述或装置参数。
- 智能体陷入平台期，而团队对『该改什么』众说纷纭。
- 一次『明显更好』的改动之后出现了回归——重建是哪一步增量造成的。
- 搭建自我改进回路：由智能体自己提议变更。

## 慎用场景（When NOT to）

- 装置架构本身错了——多少一行式增量都修不好结构性错配；先重构，再恢复爬山。
- 还没有评估套件——先建套件（`patterns/eval-driven-development.md`），否则是在雾里爬山。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV16GJ26JErf — 《爬山技能：不改模型改进智能体》：以技能为对象的经验式迭代，作为首要改进杠杆
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1Xaaf6MEv7 — 《用反思胜过强化学习：GEPA 与优化一切》：把反思式提示词优化当作有度量的爬山
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV136by6REo9 — 《改进智能体是个数据挖掘问题》：把生产失败挖成评估用例与改进项
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1Mdpu6KE9T — 《从盲点到合并 PR：持续优化智能体表现》：把盲点持续转化为涨分合并的常设回路

## 相关（Related）

- `patterns/eval-driven-development.md`
- `patterns/calibrate-the-judge.md`
- `patterns/harness-before-model.md`
- `patterns/rebuild-often.md`
