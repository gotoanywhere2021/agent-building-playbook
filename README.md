# 智能体构建手册（Agent-Building Playbook · 中文版）

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
欢迎顺手补 `.wiki/context/zh.json`（中文标题/摘要）与
`.wiki/context/zh-bodies/{kebab-title}.md`（中文正文，可后补）。**不要手改
`INDEX.md` 与 `wiki/` 下的 HTML**——它们是生成物。

## 出处（Provenance）

模式内容凝练自三类来源：外部文献、经过实战的会话历史、以及 Amplifier 团队生态。
原始研究素材存于 [`docs/seed-research-dump.md`](./docs/seed-research-dump.md)。
