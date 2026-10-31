## 这是什么（What it is）

智能体不会主动跑 `git commit`——于是可恢复状态的单位，就成了智能体碰巧留下的东西。把分层倒过来：给每个智能体一个挂在已提交历史之上的写时复制工作区，每次工具调用之后自动把增量提交进只增、内容寻址的存储。三个性质随之而来。回滚免费——每一步都是可返回的检查点，无需智能体配合。分叉便宜——第二个智能体从任意提交分叉而不复制基底；同文件冲突会被**拒绝**而不是被悄悄解决，除非显式的 last-write-wins 策略另行规定。审计变成结构性事实——存储只增长、已存对象永不重写，『智能体到底对这些文件做了什么』是一次 diff，不是一场调查。去重让它实用：编辑只花增量的大小，不花文件的大小，真实项目几百个检查点压缩后只有几 MB。

## 适用场景（When to reach for it）

- 长时自主运行：『回到第 N 步』必须成立，且不能依赖智能体提交过。
- 多智能体并行操作同一棵树——便宜分叉、刻意合并、拒绝静默覆盖（会话级变体见 `patterns/worktree-per-parallel-session.md`）。
- 对文件状态的审计与事故考古：证明每一步改了什么，而不是只证明合并时改了什么。
- 重跑代价高昂的环境——『大不了重来』是最贵的答案时。

## 慎用场景（When NOT to）

- 没有未来读者的一次性沙箱——普通草稿目录更便宜。
- 顺序写或超大二进制负载——写时复制开销盖过收益。
- 在存储缺乏崩溃耐久性时充当不可恢复数据的唯一副本——有些实现明确只保证『活过会话』而非『活过断电』；真正的备份放在外面。

## 实例（Exemplars）

- Ephemeral-AI-Lab/layerfs — https://github.com/Ephemeral-AI-Lab/layerfs — 该模式的基础设施化：单文件 SQLite 存储之上的 FUSE 工作区；按工具调用提交；内容分块让 4.94 GB 项目树的 157 个快照只占约 100 MB（比 Btrfs + zstd 小 19.9 倍）；同文件冲突拒绝 + 可选 `.lww`；诚实的限制文档（disposable 档无崩溃耐久、不支持 FIFO/套接字/设备节点）
- tobi/try — https://github.com/tobi/try — 同一思想的 shell 尺度版：对快照视图跑任意命令，事后提交或丢弃；『工作区是视图、历史才是产品』的先例

## 相关（Related）

- `patterns/worktree-per-parallel-session.md`
- `patterns/make-runs-replayable.md`
- `patterns/sandbox-by-default.md`
- `patterns/checkpoint-handoff-file.md`
- `patterns/agents-are-distributed-systems.md`
