# Note — 在 ZCode 上实现并实测"共享循环，而非主管"模式

**日期：** 2026-10-25 · **类型：** 决策（Agent Note） · **上篇：**
`docs/plans/2026-10-25-pattern-extraction-lessons.md`。

## 问题

`shared-loop-not-supervisor` 模式入库后需要回答：这个模式能否直接在
ZCode 上落地？用真实任务（132 个模式、378 个 Exemplar URL 的健康检查）
做一次**最大输出实测**，并把"查看子智能体任务详情的看板"一并建好。

## 决定

1. **共享看板 v2**（`docs/demo/shared-loop-swarm/board.md`）：批次 =
   工作单元，行内携带任务详情（文件数/URL 数）与状态机
   `UNCLAIMED → CLAIMED BY wx → DONE`；协议全文写在看板顶部；
   认领锁 = `claims/<批次ID>` 原子 mkdir；工人只准改自己的批次行。
2. **派生仪表盘**（`dashboard.py` → `dashboard.md`）：工人表、批次表、
   坏链候选汇总，只读、任何人可运行——看板是源，仪表盘是渲染。
3. **工人 = 相同协议 + 不同 ID**：两个 ZCode 后台子智能体（宿主并发
   上限实测 2），自组织认领，无中央分配、无互相通信。

## 结果（数据见 docs/demo/shared-loop-swarm/README.md）

- 群体自发形成 2:3 分工并按各自停止条件干净退出；涌现行为三例
  （竞争让出、中途自纠错重建数据、无死循环）。
- 链接健康三轮验证：**0 确认死链**；12 个 URL 因本机网络条件
  （wikipedia 被墙、反爬、限频）不可验证，均为规范 URL，未改任何模式。
- 成本对照：子智能体 ≈34M token vs 本地脚本分钟级——结论写入模式
  的 When-NOT 语义：协调模式 ≠ 效率模式。

## 考虑过的选项

- **再派 W3–W5 补齐 5 工人** — 否：并发上限 2，且 5 批次已被认领完；
  群体规模按宿主上限设计，看板协议对工人数量不敏感。
- **坏链候选直接当死链修** — 否：403 反爬、429 限频、GFW 不可达都
  不是死链；换条件复验（本地 curl 重试）恢复 54/66，避免误伤。
- **第二轮继续用子智能体复验** — 否：机械批量本地脚本更快更便宜，
  群体留给需要判断的工作。

## 后果

- 模式获得一次端到端实测：看板协议可直接作为 ZCode 群体配方复用
  （board + claims + append-only results + derived dashboard）。
- 演示档案（含原始结果文件与复验 JSON）入库 `docs/demo/shared-loop-swarm/`，
  `swarm-run/` 工作目录入 .gitignore。
- 中文站状态：main 已上线 119 模式版；132 模式版随本 PR 合并自动部署
  （github-pages 环境保护规则限制仅 main 可部署，分支预览部署被拒）。
