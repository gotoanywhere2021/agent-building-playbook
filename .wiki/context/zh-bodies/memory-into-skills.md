## 这是什么（What it is）

智能体记忆不断累积会话笔记、修复方案和用户偏好；放任不管，它会膨胀、自相矛盾、毒化上下文（见 `patterns/scope-and-expire-memory.md`）。更有价值的动作是晋升而非堆积：当同一个修复、流程或判断反复出现，就把它蒸馏成一项技能——小而有名有版、触发时才加载的流程文档——然后把原始历史降级为可过期的记忆。自我改进型智能体团队走得更远：让智能体自己从会话历史起草技能草案，晋升前先过评估与评审。记忆记录的是发生过一次的事；技能让它在需要时必然发生。

## 适用场景（When to reach for it）

- 同一个修复或处理方式在多个会话里反复出现，笔记文件持续膨胀。
- 环境知识或上手知识每周都要重新向智能体解释一遍。
- 搭建持续学习回路：失败 → 笔记 → 技能 → 评估 → 默认行为。
- 技能库已经存在但没人敢信——先给晋升加上评估闸门。

## 慎用场景（When NOT to）

- 一次性任务——蒸馏有固定成本，只有反复出现的行为才摊得平。
- 高速变化的领域，技能过期得比收益还快——改用有范围、会过期的记忆。
- 还没有能守住晋升的评估——先建评估，否则技能只是把坏习惯写进宪法。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1Gzpq6DE77 — 《把智能体记忆变成真正可用的技能》：记忆 → 技能晋升流水线的实战
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1jVpB6tEEJ — 《从 36 到 100：自我改进智能体如何编写自己的技能》：智能体起草、测试、采纳自己的技能，得分 36 → 100
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1NBNh6jEX9 — 《交付技能前必须先过评估》：为什么未经评估的技能等于未经检验的行为变更
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1W97L6PEZS — 《把笔记变成记忆》（Hugging Face）：把原始笔记结构化为可检索记忆，是蒸馏的入口
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1exuA6sE5C — 《我们筛了 2000 项 AI 技能才放给开发者》：大规模技能语料的评审闸门能拦下什么

## 相关（Related）

- `patterns/skills-load-on-trigger.md`
- `patterns/scope-and-expire-memory.md`
- `patterns/long-horizon-memory.md`
- `patterns/self-modifying-context-needs-review.md`
