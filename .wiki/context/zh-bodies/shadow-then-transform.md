## 这是什么（What it is）

许多领域——政府、保险、类医疗的工作流、规划、企业运营——依靠从未出现在任何文档中的默会知识（tacit knowledge）运转：人们搭出来的变通办法、本地规范、例外路径、政治约束、只存在于工作实际做法中的机构记忆。这些知识无法通过提问引出，因为持有它们的人并不把它们体验为知识；那就是事情本来的样子。由智能体也改变不了的人类动作，是坐到用户身边看他们工作——旁听（shadow）会话、当场提问、记录发生的事、拿到记录（transcript）。智能体化工具改变的不是观察本身，而是观察之后的一切：过去把一次原始旁听转化为可用工件是缓慢的手工劳动，如今记录可以被总结为用户故事（user story）、从中挖掘矛盾、解析领域术语、建模为工作流、变成评审未来工作的人格（persona）、立即用来生成原型，以及被阅读以从观察到的行为中导出验收标准。人类的观察仍不可替代——看工作没有替代品——但把观察转化为意图工件的流水线变得足够快，可以在会话记忆仍新鲜时运行。纪律在于真的去转化：一份从未被转化为结构化工件的记录是死重，不是意图。

## 适用场景（When to reach for it）

- 领域依靠默会知识运转——变通办法、例外路径、机构记忆——没有文档能捕获、也没有人能随口背出。
- 利益相关方描述一个理想化流程，而你怀疑它与他们实际所做的不同。
- 你正在进入一个陌生的运营领域，在规定任何东西之前需要地面真值行为。
- 你已有旁听或访谈录音，想从中快速提取最大的意图。
- 例外路径与边缘情况和 happy path 一样重要，而只有观察才能揭示它们。

## 慎用场景（When NOT to）

- 工作已有良好文档，且文档被信任与实况相符。
- 你会拿到会话记录但缺少转化它的时间或意图——未经处理的记录不是工件。
- 观察会违反无法满足的隐私、保密或同意约束。
- 你要观察的行为本身就是你即将忠实编码的坏变通办法——把它与『这个工作流是否应该存在』的检查配对使用。

## 实例（Exemplars）

- Beyer & Holtzblatt, Contextual Inquiry（情境调查；via Nielsen Norman Group, Kim Flaherty, 2020）— https://www.nngroup.com/articles/contextual-inquiry/ — 奠基性的 HCI 田野研究方法：观察用户执行真实工作并当场提问，以引出从业者离开任务情境便无法言说的知识；本模式所述旁听步骤最初的系统化形态。
- Michael Polanyi, *The Tacit Dimension*（1966）— https://en.wikipedia.org/wiki/Tacit_knowledge — （经由 tacit knowledge 的维基百科条目）为旁听为何必要提供哲学根据：领域从业者持有自己不体验为知识的知识（『我们知道的比我们能说出的多』），使观察成为不可替代的引出方法。

## 相关模式（Related）

- `patterns/mine-transcripts.md`
- `patterns/contradiction-extraction.md`
- `patterns/good-pile-bad-pile.md`
- `patterns/simulated-review-squad.md`
- `patterns/dont-automate-the-workaround.md`
