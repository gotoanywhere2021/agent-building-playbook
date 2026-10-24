# Note — 人类视图改版：Palantir 文档站式 + 全中文

**日期：** 2026-10-24 · **类型：** 决策（Agent Note）

## 问题

人类浏览视图（`wiki/`）此前以"可缩放旭日轮盘"（explore.html sunburst +
wheel.svg）作为主要探索入口。轮盘的径向隐喻适合品鉴场景，但作为 113 个
模式的常驻导航有三个问题：信息密度受限（外环标签只能斜排塞下）、扫读效率低
（找模式要转圈）、移动端不可用。用户要求把圆圈式呈现替换为 Palantir 文档站
风格（参考 palantir-docs：foundry/gotham/apollo 的信息架构），且界面全中文、
关键词括注英文。

## 决定

1. **人类视图改为 Palantir 文档站式三栏**：吸顶工具栏（品牌 + 搜索 + 导航）
   · 左侧常驻 家族（Family）› 维度（Dimension）› 模式（Pattern）树 ·
   面包屑 · 右侧"本页内容（On this page）"锚点栏。`wiki/explore.html`
   从旭日轮盘改为对象目录浏览器（中英双语即输即筛）。
2. **导航树数据源 = `wheel/taxonomy.yaml`**（`scripts/build-wheel.py` 生成）。
   `publish.sh` 校验 taxonomy 与 `patterns/` 的一致性，漂移即大声失败——
   轮盘生成器保留，只是它产出的树不再画成圆，而是画成侧栏树。
3. **全中文化走"人工文案层"**：新增 `.wiki/context/zh.json`（families /
   dimensions / patterns{title,one_liner}），`publish.sh` 渲染时套用，
   缺失条目逐条回退英文。UI 字符串直接内置中文，关键词括注英文
   （如 模式（pattern）、家族（Family））。搜索同时索引中英文。
4. **不翻译模式正文（pearl body）**：正文仍是 canonical 英文源；详情页
   标题/一句话摘要用中文，英文原题作为副题保留。

## 考虑过的选项

- **只换轮盘配色/布局，保留旭日** — 否：径向隐喻本身就是问题，且中文标签
  在外环斜排更放不下。
- **把中文翻译写进 patterns frontmatter（如 title_zh 字段）** — 否：改动了
   SUBMISSIONS.md 的作者契约，抬高贡献门槛；文案层与内容源解耦更轻。
- **机器翻译生成 zh.json** — 否：zh.json 是人工策展物（本版由 AI 一次性
  翻译后入库审校），生成式产物不可复现，违背"源→生成"方向。
- **正文也全量翻译** — 暂缓：113 篇正文翻译是独立的大工程，需要单独的
  翻译质量流程；先交付导航/摘要层中文。

## 后果

- 正向：站点扫读效率与移动端可用性大幅提升；taxonomy 成为唯一导航事实源，
  agent 视图（INDEX.md）与人类视图共享同一棵树；中英文搜索都可用。
- 代价：新增一条维护义务——**新增/改名模式时，必须同时补
  `zh.json` 的 title/one_liner**（缺失只是回退英文，不算失败）；发布前须先跑
  `scripts/build-wheel.py` 再 `/wiki-publish`。
- 测试：`tests/test_wiki_publish.sh` 锁定 zh 渲染、双语回退、taxonomy 漂移
  失败、坏 zh.json 失败四类行为。
- 相关旧 Note：`docs/plans/2026-06-28-agent-building-playbook-design.md`
  （原始设计，本 Note 不改写它，仅接续）。
