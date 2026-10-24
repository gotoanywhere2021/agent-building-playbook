## 这是什么（What it is）

没有验证能力的智能体是一个单遍系统：它产出输出然后停止，在交付之前无从察觉输出是错的。具备自我验证能力的智能体在报告完成之前，把输出过一个验证步骤——把结果对照规范检查、运行一次测试、读回它写的文件，或调用一个不共享智能体假设的二次检查。自我验证不要求单独的智能体或人在回路，虽然两者都可以加上。最低限度，它意味着智能体的工作流在『我执行了操作』与『我报告成功』之间包含一个显式的验证步骤。验证步骤必须能接触到地面真值（ground truth）或独立检查——让同一个模型确认自己的推理不是验证，是重复。能抓到错误的验证需要不同的信息源：磁盘上的实际输出工件、运行代码的测试套件、消费输出的下游系统，或与已知正确参照的比对。

## 适用场景（When to reach for it）

- 任何写文件、改状态或调用外部 API 的智能体——操作之后，读回工件或检查状态，确认操作产生了预期效果，再报告成功。
- 任何生成结构化输出（代码、JSON、配置）的智能体——交付之前把输出过一遍解析器、linter 或校验器，抓出智能体在自己文本里看不见的格式错误。
- 任何后续步骤依赖先前结果的多步智能体——在下一步消费之前验证每一步的输出。累积性错误远比被抓住的错误昂贵。
- 当错误输出的下游代价很高——按失败的后果校准验证强度。不可逆操作需要比可逆操作更强的验证。
- 从零设计新智能体时——把验证步骤与操作步骤同时设计。事后补验证更难，且往往暴露操作步骤根本没产出可验证的工件。

## 慎用场景（When NOT to）

- 当输出在同一轮就立刻呈现给用户、且用户会先审查再行动——此时用户就是验证者。
- 当验证步骤的成本超过事后抓错改错的成本——按比例行事；不是每次文本生成都需要正式验证。
- 当唯一可用的验证是换个措辞问同一个模型同一个问题——这不是验证，是加了延迟的重复。如果没有独立检查可用，标注这个局限，而不是上演验证表演。

## 实例（Exemplars）

- Anthropic — https://www.anthropic.com/research/building-effective-agents — Building Effective Agents：评估者（evaluator）模式是一等公民的智能体原语——一个检查生成器输出并在结果被接受之前提供反馈的 LLM 或程序化检查
- Amplifier — https://github.com/microsoft/amplifier-bundle-superpowers — superpowers 的 verify 模式：要求在任何完成声明之前运行验证命令并阅读其输出——『“应该”不是证据』；智能体自我验证，而不是基于『执行过操作』就声称成功
- Huang et al., "Large Language Models Cannot Self-Correct Reasoning Yet"（arXiv:2310.01798）— https://arxiv.org/abs/2310.01798 — 局限：证明内在自我修正（同一模型被重新提示）会让推理精度不升反降——验证必须使用独立信息源，而不是换措辞问同一个模型同一个问题
- Wang et al., "Self-Consistency Improves Chain of Thought Reasoning in Language Models"（arXiv:2203.11171）— https://arxiv.org/abs/2203.11171 — 形式化：采样多条独立推理路径并选择最一致的答案，相比贪心解码减少错误，确立了基于集成的验证是实证有效的技术

## 相关模式（Related）

- `patterns/demand-independent-proof.md`
- `patterns/verify-independently.md`
- `patterns/evidence-before-assertions.md`
- `patterns/fail-loud-over-fallbacks.md`
