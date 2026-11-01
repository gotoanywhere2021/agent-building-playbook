# Note — 模式可读性门槛：中文正文是重写，不是翻译

**日期：** 2026-11-02 · **类型：** 教训（Agent Note） · **上篇：**
`docs/plans/2026-10-25-pattern-extraction-lessons.md`。

## 问题

用户反馈：部分新收模式"有点看不懂"。按"评审者 ≠ 作者"规则，派只读
评审 agent 审读了本次会话新增的 20 个模式（英文正文 + 中文正文）。
诊断出两类真实问题（另有 3 条"结构性损坏"报告经源文件核实为评审员
误报——Exemplars 粘连/截断在源文件中不存在，记录在案以校准后续评审）：

1. **语言层硬伤**：生造词『破相点』（tells 的怪译，共 3 处）、未译词
   `slop`、断词 `juggl ing`、错句『冻成教条的年代』。
2. **中文正文裸用英文术语**：Trigger/Thread/Router/Worker/CoW/LWW/
   FUSE/slop/YOLO mode/simulation-maxxing 首现无中文解释——中文读者
   被要求预先掌握英文社区黑话。

根因：zh-bodies 是从高密度英文"珍珠"逐句翻译过来的，翻译保住了信息
密度，却没重设读者的起点。

## 决定

1. **中文正文的门槛 = 重写而非翻译**：术语首现必带一句中文解释或直接
   用中文说法；禁止生造词；一个句子只装一个论点。
2. **英文源维持高密度**（它是 INDEX.md 的喂料，面向 agent），但缩写
   首现补半句注释（如 content-addressed → "stored once, addressed by
   hash"）。
3. **流程固定**：外部内容提炼入册后，跑一轮只读评审 agent；其语言层
   发现须到源文件核实后再改（本次 3/7 的"硬伤"报告为误报）。
4. 本次落地的修复：`compile-taste-into-detectors` 与
   `every-step-a-checkpoint` 中文全文重写；`act-without-being-asked`、
   `workers-execute-router-speaks`、`split-by-context-not-org-chart`、
   `sandbox-by-default`、`worktree-per-parallel-session`、
   `traces-into-simulations` 术语补注。

## 考虑过的选项

- **只修被用户点名的那几篇** — 否：用户没点名；同批文件存在同类病灶，
  按病灶类别全量排查一次的成本远低于逐篇返工。
- **英文源也全部降密度** — 否：英文正文同时喂 INDEX.md（agent 视图，
  密度即价值）；可读性问题的真正界面是中文 wiki。
- **立一条新 pattern 记录写法** — 否：这是本仓库自身的编辑纪律，不是
  智能体构建的复用知识；Note 是它的正确容器。

## 后果

- 后续所有 zh-bodies 按"重写而非翻译"执行；评审 agent 成为入册流程
  的常设闸门（便宜、只读、与作者独立）。
- 本次修复未改动任何 frontmatter / dimensions / Exemplars 结构，三视图
  重生成后无漂移；同类问题在余下 119 个旧模式中可能存在，留待
  渐进修订（不阻塞本 PR）。
