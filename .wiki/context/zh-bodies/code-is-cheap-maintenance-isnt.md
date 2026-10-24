## 这是什么（What it is）

用 AI 生成代码的边际成本接近于零，但拥有这段代码的边际成本不是。每往代码库里加一个函数，都会产生持续的义务：安全补丁、依赖更新、缺陷报告、值班告警（on-call pages）、下一位工程师的上手负担，以及下一次读取该文件的 AI 会话的认知负荷。『免费得来的是小狗』（free as in puppies）这个说法精确捕捉了这一点：小狗的获得不花一分钱，养它却样样都花钱。AI 辅助开发把创建成本压到接近零，而维护成本分毫未动，这让人极易以超过偿付能力的速度积累义务，非常危险。

## 适用场景（When to reach for it）

- 在接受一个 AI 生成的功能、模块或抽象之前：问清由谁维护、维护多久、持续成本几何。
- 当 AI 建议了一个规格（spec）之外的『有了更好』的补充时——即使代码免费，也要抵制。
- 做容量规划时：AI 加速的是创建；人员与流程要为维护同时规划，而不是事后补课。
- 在决定是否保留那些『以后也许有用』的生成代码时。

## 慎用场景（When NOT to）

- 有明确过期日期的探索性一次性代码——只跑一次的脚本、演示后即删的原型、只活一个迭代周期的分析笔记本（notebook）。
- 由自动化工具维护、不构成人类义务的代码（例如完全从模式（schema）生成、且每次 schema 变更后重新生成）。

## 实例（Exemplars）

- Lehman, M.M.，《Programs, Life Cycles, and Laws of Software Evolution》（Proc. IEEE，1980）— https://blog.acolyer.org/2020/02/14/programs-life-cycles-laws/ — 经典先例（链接为 Adrian Colyer《The Morning Paper》的摘要；IEEE 原文需付费）：确立了 E 型程序（E-type programs）需要永无止境的变更，且若不主动对抗，复杂度必然增长，因此系统全生命周期的累积维护成本会超过初始开发成本
- Ward Cunningham，《The WyCash Portfolio Management System》（OOPSLA 1992）— https://c2.com/doc/oopsla92.html — 经典先例：创造了技术债（technical debt）这一比喻——首次发布的代码会累积一笔必须通过重构偿还的义务，未偿还的债会累积利息，最终压倒此后所有开发的成本

## 相关模式（Related）

- `patterns/start-least-agentic.md`
