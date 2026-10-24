## 这是什么（What it is）

每一次 agent 运行都从一个一无所知的上下文窗口开始。上一个会话发现的事实——仓库结构、已安装的工具版本、API 端点、集群拓扑（topology）、哪些端口开放、配置放在哪里——每次都必须重新发现或重新陈述，除非它们已被写下来。持久化环境事实（persisting environment facts）就是把这类发现工作捕获进结构化文件的做法，任何会话都可以把它作为自己的第一个动作来读取：一份描述目录布局与约定的 `WORKSPACE.md`，一份捕获工具版本与集群状态的 `env.yaml`，一份带有端点地址的 `.env` 或密钥文件。这些文件是 agent 对其所处世界的记忆。没有它们，每个会话都在重新发现上个会话已知的东西，为跨运行稳定的信息支付 token 与延迟。有了它们，agent 从一个有根据、准确的环境模型起步，而不是一块白板。

## 适用场景（When to reach for it）

- 搭建一个 agent 将跨多个会话工作的新项目时——把环境事实文件作为项目初始化的一部分写好，而不是事后补。
- 当 agent 发现了关于环境的非显而易见之事（不寻常的目录布局、被钉住的版本、已部署服务的怪癖）——在上下文重置之前立即写下来。
- 调试一个不断对环境做出同样错误假设的 agent——修复手段是持久化的文档，而不是更好的提示词。
- 把项目移交给新 agent 或新操作者时——环境事实文件就是入职文档。
- 环境发生变化（新机器、新配置、新拓扑）时——把更新持久化事实作为变更后的第一步。

## 慎用场景（When NOT to）

- 快速变化的环境，持久化的事实读到时已经过时——易变状态属于实时的工具读取，不属于陈旧的文件。
- 短命的单会话任务，环境已在提示词中完整定义且不会再被访问——写事实文件的开销不划算。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents — 形式化：把结构化笔记写入外部记忆，作为活跃上下文窗口重置时保存环境事实的主要机制。
- Chatlatanagulchai et al., "Agent READMEs: An Empirical Study of Context Files for Agentic Coding" (arXiv:2511.12884) — https://arxiv.org/abs/2511.12884 — 实证支持：对 1,925 个仓库中 2,303 份 agent 上下文文件的研究，显示实践者使用 README 风格的上下文文件来持久化项目级环境事实——实现细节（69.9%）、架构（67.7%）和构建命令（62.3%）是最常见的内容。

## 相关模式（Related）

- `patterns/checkpoint-handoff-file.md`
- `patterns/write-select-compress-isolate.md`
- `patterns/long-horizon-memory.md`
