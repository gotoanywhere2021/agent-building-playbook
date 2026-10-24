## 这是什么（What it is）

计算机使用类智能体继承了像素的全部含糊性：布局漂移、异步加载、遮挡、差之毫厘的点击——这正是『99% 准确率』的浏览器智能体依然在生产里失败的原因；长尾就是工作本身。在伸手戳屏幕之前，先往下一层找：智能体能原生解析的 HTML/DOM、REST/GraphQL API、MCP 服务器、CLI。结构化界面是确定的、验证便宜、不随视觉改版漂移。把你既不拥有也无法内省的界面留给 UI 自动化——而且在那里，给每一步包上验证（断言后置条件、截图比对、退避重试），而不是相信那一下点击。当产品是你自己的，就把结构化界面作为一等公民开放出来。

## 适用场景（When to reach for it）

- 存在任何结构化访问方式的浏览器自动化或计算机使用任务。
- 智能体对接 SaaS 产品——先查有没有 API、MCP 服务器或导出通道。
- 设计自己产品的智能体界面——原生的智能体界面胜过模拟人类操作。
- 一条 UI 自动化流水线总是被外观改版弄坏。

## 慎用场景（When NOT to）

- 真正以视觉为对象的判断（设计评审、视觉 QA）——像素就是主题。
- 封闭 UI 确实是唯一入口——那就用逐步验证加检查点来做自动化，并把脆弱性当作成本科目记账。

## 实例（Exemplars）

- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1fMKv6LE2Y — 《HTML 就是智能体所需的一切》（HeyGen）：LLM 天生精通 HTML/CSS——结构化输出加渲染，胜过像素级生成
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1vHH163Ebv — 《为何 99% 准确率的浏览器智能体仍然失败》：UI 自动化的长尾复利，以及验证如何缩小缺口
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1gAbd6SE7d — 《计算机使用站在统计悬崖边缘》：像素级智能体在哪里断裂，结构化替代方案在哪里赢
- AI Engineer 播客（Mindofuture 中配） — https://www.bilibili.com/video/BV1RMbz63EmJ — 《网页自动化的黑魔法：教智能体像人一样用网站》：只有 UI 可用时的血泪技巧

## 相关（Related）

- `patterns/tools-for-agents.md`
- `patterns/namespace-tools.md`
- `patterns/critic-applications.md`
- `patterns/self-verification.md`
