## 这是什么（What it is）

先加能力后修可靠性的直觉几乎总是错的。一个成功率为 70% 的系统不是『七成的解』——它是一个不可靠的系统，产出不可靠的数据、不可靠的用户信任，以及不可靠的进一步改进信号。抖动（flakiness）掩盖其他一切问题：如果基线本就充满噪声，你无法判断一次提示词修改是帮忙还是帮倒忙。一个可靠地失败的系统，远比一个间歇性地成功的系统有用，因为可靠的失败可测量、可诊断、可改进。

## 适用场景（When to reach for it）

- 在添加任何新能力之前，确认现有能力运行干净、可重复。
- 当评估（eval）或工作流在输入不变的情况下跨运行表现出高方差——先修它再前进。
- 当利益相关方在要更多功能而当前系统已经不稳时——关于可靠性的对话必须先行。
- 在任何基础设施变更之后：在之上继续构建前，先验证可靠性没有回退。

## 慎用场景（When NOT to）

- 早期原型阶段，目标是探明什么才是可能的——当你仍在探索问题空间时，一定程度的抖动可以接受。
- 当可靠性所需的基础设施尚不存在、而原型被严格限定时间——但要记录这笔债并计划偿还。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：建议从简单开始，只在较简单系统可靠之后再增加复杂度
- Beyer et al., *Site Reliability Engineering*, "Embracing Risk"（Google/O'Reilly）— https://sre.google/sre-book/embracing-risk/ — 经典先例：错误预算（error budget）把权衡操作化——可靠性预算耗尽时暂停新版本发布直至恢复，把可靠性编码为功能速度的闸门
