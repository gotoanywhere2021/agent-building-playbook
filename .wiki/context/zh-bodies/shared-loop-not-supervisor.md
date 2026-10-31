## 这是什么（What it is）

层级式编排的扩展极限出现在主管身上：它要负责分解、指派、追踪与整合一切，协调预算早在工人饱和之前就被榨干。扁平替代方案把协调编码为协议而不是老板。微软 Agensh 实验让最多 1,024 个同模型智能体在无中央编排者下工作：每个智能体执行相同的异步循环——收集上下文、在看板认领子任务、执行并分享发现、验证、合并——共享基础设施是一套 git 工作区、一条消息频道、一块带类型的上下文看板（观察、事实、失败、声明、补丁摘要）。认领重叠由智能体之间自行协商；冲突以合并问题而非调度决策的形式浮出。实测：从零复现 pandoc，隐藏测试通过率 33.89%（1 个）→ 50.94%（128 个）→ 55.06%（1,024 个）；ProgramBench 最难五任务 19.31% → 28.78%（1 → 128）；大团队也更快命中里程碑（128 个约 30 分钟到 30%，32 个约 90 分钟，1 个从未达到）。角色——接口协商者、同行评审者、集成者——从循环中涌现，而非被指派。

## 适用场景（When to reach for it）

- 大规模、可分解的构建/重建工作，且验收可机械验证（隐藏测试、构建门禁）——认领与合并都能由工件裁决的领域。
- 已测量出瓶颈是主管吞吐量而非工人能力。
- 把组织规模当作能力变量来探索：同一模型在 1 → 128 → 1024 的团队规模下表现像不同的系统。
- 想要涌现式分工——评审者与集成者自我选择——而不是手工设计的角色树。

## 慎用场景（When NOT to）

- 默认仍然从简：多数工作用最不智能体的单线程方案就是对的——扇出需要有具体、可测量的理由（`patterns/single-threaded-default.md`）。
- 紧耦合、共享不变量或需要连续全局推理——冲突的隐含决策会把事情变糟而不是变好。
- 回报递减很快：实验里 128 → 1,024 个只换来 +4.12 个百分点——给边际智能体算清账再扩（`patterns/delegation-token-economics.md`）。
- 问责与成本要紧：无主管群体回答不了『这个结果谁负责』，且每一点提升的资源成本未被追踪——监管与生产共享态系统不该凭演示证据采用。
- 自组织仍然踩在预设条件上：循环、认领协议、验证要求、工具都是给定的。宪法仍由你设计，智能体只填组织架构图。

## 实例（Exemplars）

- Zhan et al.《Agensh: Scaling Organizational Intelligence to 1,024 Agents》（Microsoft Research, arXiv:2609.26781） — https://arxiv.org/html/2609.26781v1 — 一手出处：无中央编排者、每智能体一个五步循环、共享工作区/频道/上下文看板，角色在 n=8/32/128/1024 逐级涌现
- Datawhale / 数据派THU 中文解析 — https://mp.weixin.qq.com/s/vlthjY1ftpBd-HaaKkxf6w — 实验设计、扩展数据与注意事项（递减回报、成本未计、问责缺口）的中文梳理

## 相关（Related）

- `patterns/single-threaded-default.md`
- `patterns/match-topology-to-the-work.md`
- `patterns/agents-are-distributed-systems.md`
- `patterns/supervise-many-agents.md`
- `patterns/delegation-token-economics.md`
