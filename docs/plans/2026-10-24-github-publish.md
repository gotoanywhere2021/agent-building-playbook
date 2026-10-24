# Note — 发布到 GitHub（gotoanywhere2021/agent-building-playbook）

**日期：** 2026-10-24 · **类型：** 决策（Agent Note） · **上篇：**
`docs/plans/2026-10-24-zh-body-translation.md`。

## 问题

把本仓库（此前只是本地目录，无 git 历史）发布到 GitHub，且 README 必须
注明**项目参考 <https://ramparte.github.io/agent-building-playbook/index.html>**
（原项目：`ramparte/agent-building-playbook`）。本机没有 `gh` CLI，需要
不装新软件的发布路径。

## 决定

1. **账号与仓库**：使用本机 git 凭据（Git Credential Manager，账号
   `gotoanywhere2021`），经其 OAuth 令牌调 GitHub API 创建公开仓库
   `gotoanywhere2021/agent-building-playbook`，`git init -b main` 后推送。
2. **README 重写为中文版说明**，顶部"参考（Attribution）"一节明确指向
   ramparte 站点与源仓库，声明模式内容版权归原作者、本仓库只做呈现层
   与语言层再加工、canonical 英文源逐字保留。
3. **生成的 `wiki/` HTML 随仓库提交**（修改 `.gitignore`，与上游"忽略
   构建产物"相反）——这是刻意决策：线上站点直接来自仓库内容，可审计、
   可回滚，不依赖 CI 生成。
4. **Pages 用 Actions 源部署**：经典分支部署只允许 `/` 或 `/docs` 作为
   站点目录，`/wiki` 会被 422 拒绝；故新增
   `.github/workflows/deploy-wiki.yml`（configure-pages →
   upload-pages-artifact(wiki) → deploy-pages），API 设
   `build_type=workflow`。站点地址：
   <https://gotoanywhere2021.github.io/agent-building-playbook/>

## 考虑过的选项

- **安装 gh CLI** — 否：`gh auth login` 仍需交互式授权，装了也绕不开；
  GCM 令牌（repo+workflow 权限）已足够完成建仓/推送/启用 Pages。
- **把站点挪到 `/docs` 用经典分支部署** — 否：`docs/` 已承载设计文档，
  为部署搬动整个目录结构牵连 `publish.sh` 默认值、README、测试，不划算。
- **fork 原仓库再改** — 否：本仓库无 git 历史关联，fork 会带入无关历史；
  独立仓库 + README 署名更符合"参考/再加工"的定位。

## 后果

- 正向：发布完成且可复现——以后更新 = 本地重渲染 → commit → push，
  Actions 自动重部署；INDEX 的 CI（上游遗留的 build-index workflow）
  在首推后即跑绿。
- 代价/注意：
  - GCM 令牌走的是 OAuth 授权，若日后失效需重新 `git credential reject`
    后再授权一次；
  - 首次部署失败过一次（工作流先于 Pages 启用触发），workflow_dispatch
    重触发即恢复——新仓库若重建，记住**先启用 Pages 再看部署结果**；
  - 上游未来若更新，本仓库需手动对照拉取（无 fork 关系）。
- 验证：线上 `index.html` / `explore.html` 均 200；Actions 运行 success。
