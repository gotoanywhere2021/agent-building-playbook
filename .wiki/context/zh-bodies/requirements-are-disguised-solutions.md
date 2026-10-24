## 这是什么（What it is）

利益相关方很少陈述需求；他们陈述的是实现。他们要一个字段、一条校验规则、一份报告、一个按钮或一处工作流变更——每一个都已经是解法的猜测，由他们拥有的工具、他们记得的系统、他们学会共存的变通办法塑形。在传统产品工作中，看穿陈述的解法、找到底层需求的职责属于产品管理、设计研究与实现团队。在一个智能体化的组织里，它成为机器接口的一等公民，因为智能体会欣然且迅速地照单全收——而如果陈述的解法是对一个坏流程的变通，智能体只是在加速错误的事情。意图层（intent layer）的职责是先问为什么再问怎么做：把『加这个字段』翻译成*什么决策依赖这个字段？*，把『换个方式校验』翻译成*我们在防止什么失败？*，把『做这个看板』翻译成*谁会在看到它之后改变行为？*，把『把这个工作流自动化』翻译成*这个工作流还应该存在吗？*，把『做得像旧系统一样』翻译成*哪些行为是本质的、哪些是历史偶然？*，把『答案要看情况』翻译成*哪些变量决定了情况、我们能收集例子吗？*。请求是需求的线索，不是需求本身；把它当作规范，就是把利益相关方的诊断当成了需求。本模式针对的是单个陈述的解法——一个字段、一条规则、一份报告；当伪装的解法是一整个本不该存在的工作流时，这个特例足够尖锐，值得它自己的纪律（见 Don't Automate the Workaround）。

## 适用场景（When to reach for it）

- 利益相关方请求具体的实现细节（字段、按钮、规则）——先把它转换为其服务的决策或失败，再动手构建。
- 请求引用『旧系统』或『我们一直的做法』——先分离本质行为与历史偶然，再复现它们。
- 一个请求将把既有手工工作流自动化——先问这个工作流是否应该存续。
- 陈述的答案是『看情况』——拉住这个依赖：哪些变量，利益相关方能否提供带标注的例子而非规则？
- 你注意到某个智能体即将原样实现被要求的东西、却对为什么毫无模型——暂停并找回意图。

## 慎用场景（When NOT to）

- 所请求的解法本身就是需求（法律强制、固定的外部合同、硬性接口）——追问它只会浪费所有人的时间。
- 照字面构建请求的成本微不足道且可逆——有时交付被要求的东西正是检验它对不对的最便宜方式。
- 反复追问『但你到底为什么想要这个？』已成为侵蚀利益相关方信任的阻碍——察言观色，然后果断交付。

## 实例（Exemplars）

- Gause & Weinberg, *Exploring Requirements: Quality Before Design*（1989）— https://geraldmweinberg.com/Site/Exploring_Requirements.html — 经典需求工程著作，专注于穿透陈述的解法找到底层需求；评论者称其『满是从用户身上引出那些没有你的帮助便无法表达的需要的技巧』。
- The XY Problem — https://xyproblem.info — 计算机社区对本模式的简称：提问者询问的是自己尝试的解法（Y）而非真正的目标（X）；该页面将 Eric Raymond 的 "How To Ask Questions The Smart Way" 列为相关阅读。
- Carmen Nobel, "Clay Christensen's Milkshake Marketing"（Harvard Business School Working Knowledge, 2011）— https://www.library.hbs.edu/working-knowledge/clay-christensens-milkshake-marketing — 报道 Christensen 的待办任务（Jobs-to-be-Done）研究：产品被『雇用』去做的工作常常不同于利益相关方点名的功能或人群；找回底层任务需要追问陈述的解法意在服务什么决策或结果。

## 相关模式（Related）

- `patterns/interview-to-a-spec.md`
- `patterns/dont-automate-the-workaround.md`
- `patterns/document-intent.md`
- `patterns/good-pile-bad-pile.md`
