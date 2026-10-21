# Moon Geometry 开发规则全集 / Development Rules

> **用途**：本文件是 Moon Geometry 项目所有开发规则的权威汇总，供 agent 与人类协作者复用。  
> **维护**：每次新增规则时回写本文件。  
> **优先级**：防跑偏规则 > 项目规则 > 个人偏好。

---

## 一、项目规则 / Project Rules

### R1 — 源码目录
全部源代码放在 `src/` 目录下，按 24 个领域分类子目录组织。

### R2 — 多手段测试
MoonBit 形式化证明 + AI/FAKE/MOCK/E2E 多手段测试，确保无 bug。每个 Sprint 交付前 `moon check` 0 error、`moon test` 全通过。

### R3 — 代码文档注释
代码三级文档注释中英文（包级、类型级、方法级）。所有 `pub fn` 必须有 `///` 注释。

### R4 — README 规范
README 中英文，美化，默认中文；每个子包也要 README.md。

### R5 — 迭代路线
先制定 `docs/roadmap.md` 迭代路线，按 Sprint 推进。

### R6 — 提交查证
提交历史有迹可循——每个 Sprint 完成回写 `roadmap.md` 状态 + commit hash。

### R7 — 自动迭代触发
没有任务迭代时，自动触发新的路线迭代计划。

### R8 — 文档治理
每次迭代后进行开源项目文档治理：更新根 README、roadmap、CHANGELOG、子包 README。

### R9 — 经验沉淀（立即）⭐ 加固
开发经验教训**立即沉淀**复用：每完成一个有新发现的步骤（warning 治理、语法陷阱、规则增强），**立即**更新 memory（`C:\Users\Administrator\.codeartsdoer\memory\...`），**不得拖延**到"稍后"或"下一个 Sprint 后"。

**执行时机**：在当前动作完成时、进入下一个动作之前执行 memory 更新。在 todo 流程中，memory 更新是步骤的一部分，不是事后补丁。

### R10 — 一级子包重导出
一级子包（如 `src/base`、`src/hull`）也要 README.md 并重导出子包 API。

### R11 — 防跑偏规则（记/锁/回）
每一步做三件事：
1. **记**：把已确认的"规则/负责人/截止时间"写进固定区块；
2. **锁**：遇到与前序约定冲突的新要求，先停下，标注冲突来源，问"谁有权改"；
3. **回**：每完成一环，回写一句"已交付 x，下环依赖 Y"。
禁止在没确认的情况下，把群聊里的某句话当成最终决定。

### R12 — 根包重导出
项目根包（`walkzzz/moon-geometry`，根目录 `moon.pkg` + `reexport.mbt`）重导出所有一级子包公共 API，对外提供统一入口 `@moon-geometry`。

### R13 — Warning 治理（目标 0，无例外）⭐ 增强
每次迭代完成后必须进行 **warning 治理**：运行 `moon check` / `moon test`，对所有 warning 逐一**根因治理**，目标 **0 warning，无任何例外**。

**禁止简单抑制**：不得用 `#warnings("-...")` 属性或 `moon.pkg` warnings 字段掩盖 warning。

**根因治理方式**（按官方文档 [E0001](https://docs.moonbitlang.com/en/latest/language/error_codes/E0001.html)）：
1. **删除**：函数/实现确实无用 → 删除定义
2. **加 `pub`**：是公共 API 的一部分 → 加 `pub` 关键字
3. **`ignore()`**：需保留私有且未使用 → 调用 `ignore(fn)` 强制使用
4. **trait impl 治理**：`impl Trait for Type with fn method` 报 "Unused trait implementation" → 改为 `pub impl` + `pub extend Type with Trait::{method}`
5. **未使用参数**：`fn f(self : T)` 报 "Unused variable 'self'" → 改为 `fn f(_ : T)` 或实际使用 self
6. **unused_package（wbtest 局限）**：导入在 `_wbtest.mbt` 中使用但主源文件未使用 → 在主源文件中添加 `ignore(@pkg)` 或将导入移至测试专用

**验收门禁**：`moon check` 输出 0 warning 0 error，`moon test` 全通过。

### R14 — 占位 todo 检查
所有的占位 todo 项，每次迭代后都要检查是否具备条件完成。若依赖已满足且资源就绪，立即推进；否则标注阻塞原因。

### R15 — 规则输出复用
所有规则输出到本文件 `docs/rules.md`，供 agent 与人类协作者复用。每次新增规则回写。

### R16 — 连续迭代不停顿 ⭐ 新增
有迭代计划（roadmap 中有"待开始"且依赖已满足的 Sprint）时**不得停顿**，完成当前 Sprint 后立即推进下一个，直到：
- 所有依赖已满足的 Sprint 全部完成，或
- 遇到需要用户决策的阻塞点（按 R11 锁规则停下问谁有权改）

禁止在无阻塞的情况下中途停顿等待用户指令。

### R17 — 多手段测试工作流 ⭐ 新增

所有设计文档补充、架构变更、新模块合入必须经过**五类多手段测试**验证，全 Pass 后方可进入下一阶段：

| 测试手段 | 职责 | 适用场景 |
|----------|------|----------|
| **形式化证明** | 校验文档结构完整性、跨章节一致性、引用闭环、规则完备性 | 架构文档、规则文档、输出契约 |
| **AI 测试** | 用 AI 智能体模拟工作流执行，验证设计可行性 | 工作流设计、算子语义、用户场景模拟 |
| **FAKE 测试** | 构造假数据结构，验证输出契约字段完整可构造 | 数据结构定义、类型完备性 |
| **MOCK 测试** | mock 外部依赖组件，验证编排逻辑正确 | 工作流编排、接口调用顺序 |
| **E2E 测试** | 端到端模拟完整流程，验证多组件串联闭环 | 用户需求 → 最终输出的完整链路 |

**执行规则**：
1. **全 Pass 才放行**：五类测试任一 Fail 则阻塞合入，修复后重跑全部五类。
2. **测试报告落盘**：每次多手段测试必须输出 `docs/arch_test_report.md`（或追加章节），记录每类测试的输入、执行、输出、结论。
3. **分级触发**：纯文档变更可只跑形式化证明 + docs 一致性；代码变更必须跑全五类。
4. **发现即沉淀**：测试中发现的设计要点、契约缺口、边界场景必须立即回写到设计文档或 memory。

**Why**: 单一测试手段无法覆盖架构设计的结构一致性（形式化证明）、可行性（AI）、类型完备性（FAKE）、编排正确性（MOCK）、端到端闭环（E2E）五个维度。五类组合才能确保设计无死角。
**How to apply**: 每次架构补充、新模块合入、工作流设计时，按上表跑五类测试，全 Pass 后提交 + 进入下一阶段。

### R18 — Trait 抽象与去重 ⭐ 新增
优先用 `pub(open) trait` 抽象公共行为模式，消除跨模块代码重复。实现 trait 时用 `pub impl Trait for Type with method` + `pub extend Type with Trait::{method}` 模式确保跨包可用且消除 deprecation warning。

### R19 — 尽可能使用 Trait ⭐ 新增
**强制要求**：所有新代码必须优先使用 trait 抽象行为模式，而非裸函数。

1. **公共行为 trait 化**：任何被 2+ 个包/类型共享的行为模式（如 `version()`、`create()`、`check()`、`validate()`、`run()`、`reset()`），必须抽象为 `pub(open) trait`。
2. **trait 优先于函数**：新增公共 API 时，优先设计 trait 方法而非独立函数。独立函数仅在行为不可复用时才允许。
3. **现有代码 trait 化**：迭代时逐步将现有裸函数重构为 trait 实现，每次 Sprint 至少 trait 化一个公共模式。
4. **trait 命名规范**：行为 trait 用形容词/动词命名（`Versioned`、`Checkable`、`Runnable`、`Resettable`、`Validatable`），而非名词。
5. **默认实现**：trait 中提供默认实现 `method(Self) -> T = _`，减少实现样板代码。

**Why**: trait 抽象是 MoonBit 的核心能力，能消除跨模块重复、提高类型安全性、增强可测试性。裸函数无法被多态调度，导致代码重复和扩展困难。
**How to apply**: 每次新增函数前，先检查是否已有 trait 可复用；每次迭代时，识别 2+ 包共享的行为模式并 trait 化。

---

## 二、MoonBit 技术要点 / Technical Notes

| 要点 | 说明 |
| --- | --- |
| 工具链版本 | MoonBit v0.1.20260920 |
| 配置文件 | `moon.mod` / `moon.pkg`（TOML，无 .json 后缀） |
| 科学计数法 | 不支持 `1e-13` 字面量，用 `0.000000000001` |
| pub enum 跨包 | 构造子跨包不可构造，需提供 `pub fn` 构造函数 |
| 字符串插值 | `{}` 不生效，用 `+` 拼接 |
| 关键字 | `var` 是关键字，不能做函数名 |
| 白盒测试 | `_wbtest.mbt` 后缀（避免 `@pkg` 前缀要求） |
| 布尔取反 | 用 `!expr`，`not(x)` 已 deprecated |
| 闭包调用 | record field 调用需 `(self.func)(x, y)` 而非 `self.func(x, y)` |
| trait 方法调用 | 跨包用 `Trait::method(obj, args)`，隐式提升已 deprecated |
| trait impl 可见性 | `pub impl Trait for Type with fn method` + `pub extend Type with Trait::{method}` 让 impl 跨包可用且消除 unused warning |
| Array.push | 不需要 `mut`（Array 默认可变），`mut` 仅用于变量重新赋值 |
| range 循环 | `for i in 0..<n`（字面量 OK）；表达式边界加括号 `0..<(n-1)`；返回值函数内用 C 风格 `for i = 0; i < n; i = i + 1` |
| Double sqrt | `value.sqrt()` 方法（非 `@math.sqrt`） |
| `pub(open) trait` | 跨包实现必须用 `pub(open) trait`（`pub trait` = readonly/sealed，只能在定义包内实现） |
| trait 默认实现 | 在 trait 中用 `method(Self) -> T = _`，然后用 `impl Trait with method(self) { ... }` 提供默认实现（不带 `pub`） |
| `pub extend` vs `pub impl` | `pub impl` 提供 trait 方法实现；`pub extend Type with Trait::{method}` 将 trait 方法提升为常规方法（消除 implicit_impl_as_method warning） |
| unused_package 局限 | MoonBit `unused_package` 不考虑 `_wbtest.mbt` 文件中的使用 |

### 重导出语法
```
pub using @pkg { type T, name1, trait Trait1 }
```
- 必须带 `{}`；`pub using @pkg` 不带花括号报错 "expect `{`"。
- 只能列类型/trait/顶层标识符，不能列方法 `Type::method`。
- 重导出类型后，其 pub 方法自动随类型可见。
- `moon.pkg` 不支持 `export` 段；`pub use` 非有效语法，应为 `pub using`。

### 根包
项目根目录加 `moon.pkg` + `reexport.mbt` 即为模块根包，可重导出一级子包对外统一入口。

---

## 三、迭代流程 / Iteration Workflow

每个 Sprint 执行步骤：

1. **查架构**：读 `docs/roadmap.md` 对应章节，明确范围。
2. **实现**：写源码 + 白盒测试（`_wbtest.mbt`）。
3. **验证**：`moon check` 0 error + `moon test` 全通过。
4. **Warning 治理**（R13）：逐一处理 warning，目标 0 warning。
5. **重导出**（R10/R12）：一级子包聚合 + 根包重导出。
6. **文档治理**（R8）：更新 README / roadmap / CHANGELOG / 子包 README。
7. **经验沉淀**（R9）：更新 memory。
8. **占位检查**（R14）：检查占位 todo 是否可推进。
9. **提交**（R6）：git commit + 回写 roadmap commit hash。
10. **回写**（R11 回）：回写"已交付 x，下环依赖 Y"。

---

## 四、进度查证 / Progress Audit

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| v0.237.0 | Trait 去重（PointTransform trait） | ✅ | 30876e5 |
| v0.238.0 | 目录重构（401模块→24分类） | ✅ | 842c0e4 |
| v0.239.0 | Warning 治理（204→54） | ✅ | 9dabf20 |
| v0.240.0 | Curve2D trait + 代码去重 | ✅ | c80f6de |
| v0.241.0 | Warning 治理达标 0（54→0）+ 规则适配 | ✅ | 87fef56 |
| v0.242.0 | API 文档注释 218 个 pub fn（R3 合规） | ✅ | 68e6dc6 |
| v0.243.0 | 24 分类 README.md（R4/R10 合规） | ✅ | e7b95bd |
| v0.244.0 | R19 Trait 化：Measurable/PerimeterMeasurable/Containable/Measurable3D | ✅ | 45a74c9 |
| v0.245.0 | 项目瘦身：删除 118 过度理论化/专业化模块（401→283） | ✅ | f810ad1 |

**当前测试**：2111 passed · **当前模块**：283（24 分类） · **当前 warning**：0 · **当前 error**：0 · **未文档化 pub fn**：0 · **Trait 数**：6

---

> **文件结束** | Moon Geometry Rules v1.0 | 2026-10-21