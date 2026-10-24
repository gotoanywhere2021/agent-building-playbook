# wiki/ — 人类可浏览的中文站点（生成物）

本目录存放 Agent-Building Playbook 的**人类浏览视图**：静态 HTML，
Palantir 文档站式布局（吸顶搜索 + 左侧目录树 + 面包屑 + 右侧本页内容），
界面全中文、关键词括注英文。

- **事实源：** `../patterns/`（每个模式一篇 markdown）。只改那里，从不在
  本目录手改 HTML。
- **导航树：** `../wheel/taxonomy.yaml`（由 `scripts/build-wheel.py` 生成）。
- **中文文案层：** `../.wiki/context/zh.json`（人工维护：家族/维度译名 +
  每个模式的中文标题与一句话摘要；缺失条目渲染时回退英文）。
- **中文正文层：** `../.wiki/context/zh-bodies/{slug}.md`（可选：每个模式
  一篇译文正文；有则中文为主、英文原文折叠在页面底部）。
- **图解层：** `../.wiki/context/diagrams/{slug}.mmd`（可选：每模式一张
  Mermaid 流程/结构图，渲染在详情页顶部『模式图解』卡片；渲染库自托管于
  `.wiki/assets/mermaid.min.js`，发布时复制到本目录 `assets/`）。
- **Agent 视图：** `../INDEX.md`（另一个独立生成物）。
- **生成内容：** `index.html`（家族卡片首页）、`explore.html`（目录浏览器，
  替代旧版轮盘）、`families/{family}.html`、`patterns/{kebab}.html`。

## 重新生成

模式有增删改时，先重建分类树，再发布：

```sh
python scripts/build-wheel.py     # 1. 刷新 wheel/taxonomy.yaml
bash .wiki/scripts/publish.sh     # 2. 渲染 wiki/（或在 agent 会话里 /wiki-publish）
```

发布器会校验 taxonomy 与 patterns 的一致性，漂移会大声失败。
然后用浏览器打开 `wiki/index.html`，或把 `wiki/` 部署到 GitHub Pages。

> HTML 构建产物**随仓库提交**（`.gitignore` 已注明这是刻意为之）：
> GitHub Pages 通过 Actions（`.github/workflows/deploy-wiki.yml`）把本目录
> 直接发布到线上，无需本地构建。改了 `patterns/` 后重跑上面两步并提交即可。
