## 这是什么（What it is）

上下文工程的各种建议——压缩、选择、隔离、即时检索（just-in-time）——都是有处方没诊断。诊断得先看到病人：窗口里有多大比例是系统提示词、工具定义（schema）、检索来的文档、工具结果、模型自己早先的输出；每个组成部分随会话推进如何增长；哪个组件先越过了预算，把有用的材料挤了出去。大多数团队凭直觉调上下文——这里删一句提示词、那里加一条记忆——却说不出改动有没有移动真正要紧的那个数字。装上仪表让窗口变得可测量：一张上下文仪表盘，报告构成（按来源的 token 分布）、拆分（哪个文件、哪条工具定义、哪条消息）、演变（比例如何随会话漂移，尤其是压缩（compaction）事件前后）。反直觉的发现正是价值所在：工具定义经常霸占预算大头；单次粘贴的一个文件能压过整个系统提示词；压缩之后的上下文丢掉了没人注意的材料——直到仪表盘显示出那个断崖。dsh-context——一个给智能体 harness 提供上下文仪表盘、浏览器和统计的插件——之所以存在，就是因为连运营 harness 的工程师对自己上下文里到底装了什么也是两眼一抹黑。

## 适用场景（When to reach for it）

- 当上下文成本高或会话早夭时：在买更大的窗口或写更聪明的压缩器之前，先弄清预算到底花在了哪里。
- 当智能体质量在长会话中劣化时：劣化通常是上下文构成问题——陈旧的工具结果、不断膨胀的转录、丢失的指令——仪表盘能指出是哪一个。
- 当设计或挑选工具时：schema 大小是一种选择；在添加下一个工具之前，先量一量它在常驻预算里的份额。
- 当调优压缩或记忆策略时：需要改动前后的构成对比，才能知道策略是否保住了要紧的东西。

## 慎用场景（When NOT to）

- 当会话短、提示词简单时：十轮对话配两个工具，肉眼即可看全；没有谜题就没有必要上仪表。
- 当仪表本身会把数据写回上下文时：往它所测量的同一个窗口里报告的仪表盘，改变的是它要测量的对象；请带外（out-of-band）报告。
- 当你已经知道答案和修法时：如果测量只会确认『转录太长，加压缩』，那就先做，再做测量。

## 实例（Exemplars）

- dsh-context — https://github.com/bowenliang123/dsh-context — 一方实例：一个 DeepSeek Harness 插件，提供上下文仪表盘、侧边栏与浏览器，给出上下文统计、构成、拆分与演变细节——为了在优化之前回答『上下文是由什么组成的』
- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — Effective Context Engineering for AI Agents：把上下文当作需要打理的有限预算资源；测量窗口里装了什么，是其全部建议成立的前提
- Langfuse — https://langfuse.com/docs — LLM 可观测性平台逐调用渲染提示词构成与 token 记账；即本模式所述仪表盘的托管版

## 相关模式（Related）

- `patterns/context-is-finite.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/awareness-layer.md`
