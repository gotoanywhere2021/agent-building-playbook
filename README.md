# 智能体构建手册（Agent-Building Playbook · 中文版）

<p align="center"><b>简体中文</b> · <a href="./README.en.md">English</a></p>

> 📖 **在线阅读：** <https://gotoanywhere2021.github.io/agent-building-playbook/>
> （仓库内入口：[`wiki/index.html`](./wiki/index.html)，或直接双击本地文件浏览）

一个持续生长的模式（pattern）合集，关于如何在智能体（agentic）时代把事情做得更好
——*《编程珠玑》式的可操作短文，写给认知架构（cognitive-architecture）时代。*

主题是**如何构建得更好**，而不只是"如何构建智能体"。覆盖认知架构、智能体工作流
设计、上下文工程、编排、工具设计与 AI 协作的日常手艺。

## 参考（Attribution）

**本项目参考 [Agent-Building Playbook](https://ramparte.github.io/agent-building-playbook/index.html)**
——在线站点：<https://ramparte.github.io/agent-building-playbook/index.html> ·
源仓库：<https://github.com/ramparte/agent-building-playbook>。

- 模式（patterns）内容与原始观点来自上述原项目，版权归原作者与原贡献者所有；
  本仓库在其基础上做了**呈现层与语言层的再加工**，未改动 canonical 英文源
  （`patterns/*.md` 逐字保留）。
- 在原项目之上的增量：
  - Palantir 文档站式中文界面（三栏布局：吸顶搜索 · 家族›维度›模式 目录树 ·
    面包屑 · 右侧"本页内容"锚点）；
  - 全站中文（关键词括注英文）：中文文案层 `.wiki/context/zh.json`
    （标题/摘要）+ 中文正文层 `.wiki/context/zh-bodies/{slug}.md`
    （详情页中文为主，英文原文折叠保留）；
  - 每个模式配一张产品经理风格图解（架构图/流程图，Mermaid 手写层
    `.wiki/context/diagrams/{slug}.mmd`，自托管渲染库、整站离线可用）；
  - `wiki/explore.html` 从原版的旭日轮盘改为目录浏览器（中英双语即输即筛）；
  - 发布器校验导航树与 `patterns/` 的一致性，漂移即失败。

## 一个源，两种视图

| 视图 | 入口 | 说明 |
|---|---|---|
| 人类视图 | [`wiki/`](./wiki/index.html) | 静态站点（中文），由 `.wiki/scripts/publish.sh` 渲染，**产物随仓库提交**以便 GitHub Pages 直接托管 |
| 智能体视图 | [`INDEX.md`](./INDEX.md) | 紧凑、省 token 的英文索引，由 `scripts/build-index.sh` 生成 |

事实源只有一份：`patterns/*.md`（每个模式一篇 markdown：扁平 frontmatter +
"珍珠"短文正文）。`INDEX.md` 与 `wiki/` 都是它的渲染产物，**不要手改**。

## 仓库结构

| 路径 | 说明 |
|---|---|
| `patterns/` | 事实源：每个模式一篇 markdown（英文原文，canonical） |
| `.wiki/scripts/publish.sh` | 渲染 `wiki/`（Palantir 式中文站点，校验 taxonomy） |
| `.wiki/context/zh.json` | 中文文案层（家族/维度译名 + 标题/摘要） |
| `.wiki/context/zh-bodies/` | 中文正文层（每模式一篇 `{slug}.md`，可选） |
| `.wiki/context/diagrams/` | 图解层（每模式一张 Mermaid 流程/结构图，可选） |
| `wheel/` | 家族›维度›模式 分类树（`taxonomy.yaml` 等由 `build-wheel.py` 生成） |
| `scripts/` | `build-index.sh`（INDEX.md）、`build-wheel.py`（分类树） |
| `tests/` | 生成器测试（bash） |
| `docs/` | 设计文档与决策记录（`docs/plans/`） |

## 重新生成

```sh
python scripts/build-wheel.py      # 1. 刷新导航树 wheel/taxonomy.yaml
bash .wiki/scripts/publish.sh      # 2. 渲染 wiki/（含中文文案层与正文层）
bash scripts/build-index.sh        # 3. （如改了模式）刷新 INDEX.md
bash tests/test_wiki_publish.sh    # 4. 测试（或跑全部 tests/*.sh）
```

## 贡献

见 [`SUBMISSIONS.md`](./SUBMISSIONS.md)：新增 `patterns/{kebab-title}.md` 开 PR；
欢迎顺手补 `.wiki/context/zh.json`（中文标题/摘要）、
`.wiki/context/zh-bodies/{kebab-title}.md`（中文正文）与
`.wiki/context/diagrams/{kebab-title}.mmd`（图解），均可后补。**不要手改
`INDEX.md` 与 `wiki/` 下的 HTML**——它们是生成物。

---

## 思想源流：Sam Schillace（Inspirations）

本手册的 113 个模式凝练自更广的实践共同体，而其中最值得展开的思想源流，是
**Sam Schillace**——Google Docs（其前身 Writely 是他创办的创业公司被 Google
收购后改名而来）的联合发明者，现任 Microsoft 副首席技术官（Deputy CTO），
六次创业者，在硅谷深耕三十余年。他写了一本关于"为什么乐观是一种工程姿态"的
书，也持续写着一封封写给从业者（以及年轻时的自己）的信：

- 📕 **《No Prize for Pessimism》**（2024，8080 Books / Microsoft 旗下出版品牌）
  ——[豆瓣书页](https://book.douban.com/subject/37129755/)：关于在构建与设计
  产品时，乐观主义、实验精神与拥抱"创造的混乱"为何重要；
- ✉️ **Sunday Letters**（[sundaylettersfromsam.substack.com](https://sundaylettersfromsam.substack.com/)）
  ——他的通讯："像程序员一样思考、写给年轻自己的信、系统思维"；
- 🗂️ **Lessons from Sam Schillace**（[Antoine Buteau 的经验总结](https://www.antoinebuteau.com/lessons-from-sam-schillace/)）
  ——把他在 Google / Box / Microsoft 三十年生涯中的框架（Writely 起源、
  Schillace 定律、品味与判断、领导力）整理成的八部分精读笔记。

为什么值得在此详细阐述？因为本手册的相当一部分模式，可以看作 Schillace 这些
思想的"操作化落地"——他把理念讲成原则，我们把原则拆成可执行的动作。以下按
主题逐一对照。

### 1. 乐观主义是一种工程姿态（"悲观没有奖品"）

书名即论点：**预测失败没有奖励**。Schillace 反复强调，创新的姿态不是罗列当下
的约束（"这为什么会失败"），而是追问 **"What if?"——如果这是真的呢？如果它
成立呢？** 他形容悲观叙事会把人困住、扼杀实验；创新者必须主动回到"可能性与
惊奇之地"（the land of possibility and wonder），并**把实验变得便宜**、在想法
成为共识之前就愿意去试那些"让人不舒服"的东西。

这直接呼应本手册"心智（Mindset）"家族的一组模式：

- **把实验变便宜** → [先造五个，扔掉四个](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/build-five-to-throw-away.html)（不懂需求时并行造多个变体，比较它们会揭示你真正在乎什么）与
  [用实现来学习](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/implement-to-learn.html)（理解问题最快的办法是做个小型抛弃版）；
- **拥抱创造的混乱** → [找到真正难的部分](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/find-the-hard-stuff.html)（真正的工作几乎从不在它看起来该在的地方——乐观不等于轻敌，恰恰是敢于直奔难处）；
- **"What if" 而非 "why not"** → [智能体放大经验](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/agents-amplify-experience.html)：乐观者手中的放大器放大的是探索半径，悲观者手中的放大器放大的是防御成本。

### 2. Schillace 定律：语义工程的分工边界

他最广为流传的技术框架是 **Schillace Laws（语义工程定律）**，其中几条与本手册
的工程模式几乎一一对应：

| Schillace 定律 | 本手册的落地模式 |
|---|---|
| **"代码负责语法与过程；模型负责语义与意图"**（Code is for syntax and process; models are for semantics and intent） | [给模型判断装上确定性护栏](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/deterministic-rails.html)：模型步与确定性步交替，两层都不必完美——模型把意图翻译成可校验状态，脚本、测试、校验器兜住漂移 |
| **"模型能做到的就不要写代码——模型会变好，代码不会"**（Don't write code if the model can do it） | [随模型进步给护架做减法](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/self-ablating-harness.html)：定期让更强的模型检视工作流、删掉不再需要的步骤——昨天的脚手架就是今天的税 |
| **"系统与其最脆弱的部分一样脆"**（The system is as brittle as its most brittle part） | [先修可靠性再谈功能](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/reliability-before-features.html) 与 [大声失败优于静默兜底](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/fail-loud-over-fallbacks.html)：掩盖失败的兜底既不教系统任何东西，成本又与失败相同 |
| **"不确定性就是一次异常抛出"**（Uncertainty is an exception throw） | [独立验证——智能体会假装"做完了"](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/verify-independently.html) 与 [证据先于断言](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/evidence-before-assertions.html)：模型"觉得对了"不是完成，是待验证的假设 |
| **"对你难的对模型也难"**（Hard for you is hard for the model） | [找到真正难的部分](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/find-the-hard-stuff.html)：难点不会因为交给模型就消失，只会被推迟 |
| **"文本是通用线缆协议"**（Text is the universal wire protocol） | [薄指针，零污染](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/thin-pointers.html) 与 [四个动作：写出、选取、压缩、隔离](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/write-select-compress-isolate.html)：智能体之间传什么、怎么传，决定了系统的信噪比 |
| **"别把模型当人"（警惕"意识的空想性错视"）** | [让智能体隐喻匹配所在层](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/match-agent-metaphor-to-layer.html)：把每个智能体都当人会造成混乱，都当无状态工具又丢掉连续性——按层选择 |

### 3. 品味与判断：执行免费之后的新稀缺

Buteau 总结的第五部分也许是与本手册精神最贴近的：**"我三十年前那些稀有而值钱
的编码技能，现在或多或少免费了。"** 当执行的成本趋近于零——
"在任何人都能做'任何事'的世界里，更重要的东西叫品味（taste）与判断
（judgment）"；**"难的部分不再是把活干了，而是选择干什么活——瓶颈从执行
移到了决策"**；甚至消费信息也需要品味，否则吃进去的都是"空热量
（empty mental calories）"。他的结论是：**"品味是模型唯一无法复制的资产，
因为它依赖活过的人生语境与主观偏好。"**

这正是本手册"品味（taste）"维度的出发点，以及贯穿全书的几条主线：

- [刻意培养品味](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/develop-your-taste.html)：识别质量、察觉不对劲的能力必须刻意修炼，不会从堆砌产出中自然长出；
- [注意力才是稀缺资源](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/attention-is-the-scarce-resource.html)：当智能体把产出成本降到零，人类注意力成为新的预算单位——这正对应 Schillace 说的"瓶颈从执行移到选择"；
- [人更擅长编辑而不是从零写](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/people-edit-better-than-they-author.html)：给人一个可反应的工件，比让人凭空写需求更接近"品味"的实际运作方式；
- [瓶颈在收尾，不在起跑](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/finishing-is-the-bottleneck.html)：模型让"说得过去的 80%"变得廉价，于是最后 20%——判断它是否真的好——成了全部的价值所在。

### 4. AI 范式转移：重新设计工作，而不是填补空位

Schillace 对当下范式转移的判断是：**"AI 不是你产品的一个功能；你的产品是 AI
的一个功能。"** 他把生成式 AI 类比为他亲历过的 Web/Cloud 转折——当年 Writely
证明了浏览器可以成为应用平台，如今他判断软件与业务将围绕新范式被重建。他还
提醒：**"这个时刻去担心那些以后能修的问题，是绝对致命的错误"**——速度的权重
比以往任何时候都高；以及"模型擅长思考、不擅长规划，所以规划放在代码里做"。

对应到本手册：

- [重新设计工作，而不是填充人形空位](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/redesign-work-dont-fill-slots.html)：把每个角色换成等价智能体只会保留旧低效——与"你的产品是 AI 的功能"同构；
- [杠杆优于效率](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/leverage-over-efficiency.html)：问"同样的人如何更大规模地构建"，而不是"同样的事如何用更少的人"；
- [区分工作流与智能体](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/workflows-vs-agents.html) 与 [从三个原语构建](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/three-primitives.html)：规划放代码里的具体做法；
- [按阶段匹配模型 / 把贵模型投资在护架上](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/match-model-to-stage.html)：速度与成本的正确权衡姿势。

### 5. 工程的朴素与偏执（老派手艺没有过时）

值得注意的是，Schillace 并非"AI 万能论者"。他延续了老派工程戒律：
**"要偏执——除非严格验证，永远不要相信系统在线、bug 已修、代码能跑"**；
**"修掉 bug 产生的可能性，而不是这个 bug"**；**"从零重写在软件工程里是
大忌"**；**"简单方案——哪怕稍欠完整——通常胜过复杂而完美的方案"**。这些戒律
在本手册里的投影：

- [证据先于断言](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/evidence-before-assertions.html) = "要偏执"；
- [修根因，要诊断](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/fix-the-root-cause.html) = "修掉 bug 的可能性"；
- [棕地才是真正的考验](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/brownfield-is-the-real-test.html) = "重写是大忌"；
- [从最不"智能体"的方案开始](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/start-least-agentic.html) = "简单方案胜出"。

### 6. 领导力：谦逊、委托，以及"教练与球员"

书的另一条主线是领导力：他警告 **"女主角死亡螺旋（prima donna death
spiral）"**——不愿授权的领导者会把团队拖入低效，有效领导植根于谦逊与信任；
规模化意味着"从首要解题者转变为解题文化的建筑师"。关于个人职业，他的建议
则带着硅谷式的野性：**"找到那件让你觉得'拿这份钱有点愧疚'的事，然后拼命去
做"**；**"走到某个领域的边缘，然后去瞎折腾（get to the edge and fuck
around）——这就是策略"**。

对应本手册"人（People）"家族：

- [教练与球员](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/coaches-and-players.html)：杠杆来自把资深判断注入大量智能体工作流，而不是资深的人亲自做资深的事——正是"从解题者到文化建筑师"的智能体时代版本；
- [把提议方与批准方分开](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/proposer-authority-separation.html)：对"女主角螺旋"的制度化防御；
- [新素养是"操作"，不是提示词](https://gotoanywhere2021.github.io/agent-building-playbook/patterns/the-new-literacy-is-operating.html)：当执行免费，"那件让你愧疚的事"正在从写代码移向操舵与判断。

### 小结

如果说本手册是一本"招式谱"，Schillace 的书与信就是其中相当一部分招式背后的
"心法"：**以乐观定方向，以定律划边界，以品味定取舍，以谦逊带团队，以偏执保
质量。** 建议的阅读顺序：先浏览本手册的[家族首页](https://gotoanywhere2021.github.io/agent-building-playbook/)建立地图，再读
《No Prize for Pessimism》补心法，最后用 Sunday Letters 与 Buteau 的总结做
持续校准。

---

## 出处（Provenance）

模式内容凝练自三类来源：外部文献、经过实战的会话历史、以及 Amplifier 团队生态。
原始研究素材存于 [`docs/seed-research-dump.md`](./docs/seed-research-dump.md)。
