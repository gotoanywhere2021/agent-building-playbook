# Note — 从 Mindofuture（AI Engineer 中配）近 9 个月内容提炼 12 个模式，并新增 `security` 维度

**日期：** 2026-10-24 · **类型：** 决策（Agent Note） · **上篇：**
`docs/plans/2026-10-24-pattern-diagrams.md`。

## 问题

任务要求：从 B 站 UP 主
[Mindofuture](https://space.bilibili.com/1122798707/upload/video) 近 9 个月
的视频标题与简介出发，找出适合收录进本手册的内容。该频道（2026 年初开更）
系统翻译 AI Engineer 播客及一线工程讲座，窗口期内共 1290 个视频（全频道
2123 个）。两道约束：

1. **B 站风控**：`/x/space/wbi/arc/search` 全量列表接口对非浏览器指纹一律
   -352/-412（curl、urllib、WebFetch、浏览器直连 API 均被拦）；但
   `seasons_series` / `seasons_archives_list`（合集）与
   `web-interface/view`（单视频简介）不设防。最终取数路径 = 全量抓 20 个
   合计 → 合集内 100/页翻页 → 63 个候选视频补简介 → 12 个模式。
2. **去重**：现有 118 个模式已覆盖评估装置、验证独立、技能按需加载等；
   新模式必须是与现有条目不重叠的增量论点，而非同义复述。

## 决定

1. **收录 12 个新 patterns**（每条以具体视频为 Exemplar，附 B 站链接）：
   `sandbox-by-default`、`zero-standing-credentials`、`harness-before-model`、
   `lexical-first-retrieval`、`memory-into-skills`、`calibrate-the-judge`、
   `hill-climb-dont-rewrite`、`traces-into-simulations`、
   `agents-are-distributed-systems`、`structured-surface-over-screen`、
   `declare-outcomes-not-procedures`、`human-async-api`。
2. **新增 `security` 维度**（SUBMISSIONS.md 规定的"在 PR 中声明"路径）：
   `sandbox-by-default` 与 `zero-standing-credentials` 的核心关切是爆炸半径
   与凭证边界，归入 reliability/tool-design 都是错位。挂入 Trust 家族
   （`build-wheel.py` FAMILIES），zh 名「安全」。
3. **翻译层同步**：12 条 zh.json 文案 + 12 篇 zh-bodies + 12 张
   Mermaid 图解（沿用 2026-10-24-pattern-diagrams 的作图语法子集与三色
   classDef）。INDEX.md / wheel/taxonomy.yaml / wiki/ 全部由源重生成，
   未手改。
4. **既有模式充实**：`self-verification` 增补 1 条 Exemplar
   （Teach Your Agent to Prove Its Done）。

## 考虑过的选项

- **只沿用现有 13 个维度** — 否：安全类模式硬塞进 reliability 会稀释
  该维度"反作弊"语义；PR 内声明新维度正是规范预留的生长通道。
- **按 UP 主更新频率全量翻页抓列表** — 否：1290 视频约 43 页 DOM 翻页
  会触发软风控（实测列表被置空），且标题信息密度不如合集主题分组；
  合集接口一次拿全、天然按主题聚类。
- **再收录 "Teach Your Agent to Prove Its Done" 等为独立模式** — 否：
  与既有 `self-verification`/`demand-independent-proof` 重叠，改为给
  既有模式补 Exemplar。
- **抓简介全部重试到位** — 否：`web-interface/view` 对本机 IP 阶段性
  限流（63 条仅 21 条直取成功），其余以浏览器读取关键 3 条 +
  标题语义（每条标题自带论点）补足；12 条模式论点均有一手出处。

## 后果

- 维度数 13 → 14，Trust 家族 3 → 4 维；INDEX.md、taxonomy、wiki/ 随源
  重生成（CI on merge 会再跑一次 build-index 校验）。
- 13/13 测试脚本通过（含 663 条模式形态断言与 wiki 发布冒烟）；新维度
  已被 `build-wheel.py` 家族校验覆盖。
- 后续同类外部来源（播客/频道 → 模式）可复用本次取数路径：
  合集接口 → 候选 → 简介补全 → 与 INDEX 去重 → PR。
