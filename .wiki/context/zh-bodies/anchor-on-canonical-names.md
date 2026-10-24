## 这是什么（What it is）

模型对含糊描述的解读并不一致——『用 mock 写隔离的测试』在不同模型、不同运行、不同上下文下解析出的结果各异；而试图钉死每个方面的长提示词则脆弱、耗 token，且依然有歧义。一个典范名称（canonical name）是更有力的工具。模型在训练中成千上万次遇到过的术语——『TDD, London School』『arc42』『hexagonal architecture』『the Feynman technique』——充当语义锚点（semantic anchor）：说出它的名字，就会激活一簇特定而稳定的关联实践，这是转述够不到的。这里的杠杆是*潜在知识的激活*，而非外部内容的检索——你是深入模型已知的东西，用几个高信号 token 把一整套连贯的方法论拉进上下文。术语越典范（使用广泛、无歧义、在公开资料中有充分文档），锚点就越强、越稳定。收益是更少的 token、更精确更可复现的结果；而它所取代的失败模式，是那种每次运行都要从零重建一套知名方法论的脆弱巨型提示词（mega-prompt）。存在好的名字时就优先用它；而确实没有的时候，这种缺席本身就是信息——模型对你想要的东西可能没有稳定的先验，你需要改为描述或演示。

## 适用场景（When to reach for it）

- 你正要写一段文字、去描述某个已有公认名称的方法论、架构或技术时——直接用名字。
- 同一条指令在不同运行之间结果漂移时——含糊的描述可能每次解析得都不一样，典范术语能把它稳定下来。
- token 预算紧张、完整描述代价高昂时——一个强锚点能把整套方法论压缩成几个词。
- 为一个已有既定行话（term of art）的领域惯例给智能体做上手时——说出名字，让训练去做功。

## 慎用场景（When NOT to）

- 没有典范术语存在，或术语有歧义、有争议时——弱锚点会激活错误的一簇；改为描述它，或先定义术语。
- 你想要的含义与该名字唤起的标准含义刻意不同时——锚点会把模型拉向惯例，而不是你的变体。
- 概念对整个领域确实是全新的时候——没有可激活的先验，必须描述或演示。
- 精确性比强先验的保证更重要时——验证被激活的行为；名字是一个强大的默认值，不是契约。

## 实例（Exemplars）

- Ralf D. Müller (rdmueller) — https://github.com/lexler/augmented-coding-patterns/blob/main/documents/patterns/semantic-anchors.md — 《Semantic Anchors》，本模式改编自的出处；报告了一项系统测试——63 个锚点、193 道多选题、3 个模型得分 96–99%——而在不点名的情况下描述费曼技巧（Feynman Technique）时，三个模型中有两个掉到 0%
- Semantic Anchors Catalog — https://llm-coding.github.io/Semantic-Anchors/ — 源模式所引用锚点术语的配套目录

## 相关模式（Related）

- `patterns/context-over-prompt.md`
- `patterns/context-is-finite.md`
- `patterns/just-in-time-retrieval.md`
- `patterns/state-the-target.md`
- `patterns/embed-guidance-in-tool-output.md`
