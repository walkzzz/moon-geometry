# Contributing to moon-geometry / 参与贡献指南

Thank you for your interest in contributing to **moon-geometry**, a MoonBit geometry
computation library. This guide covers everything you need to get started.
感谢你对 **moon-geometry**（MoonBit 几何计算库）的贡献。本指南涵盖上手所需的一切。

---

## 1. Prerequisites / 环境准备

- **MoonBit toolchain** — install from <https://cli.moonbitlang.com>:
  ```bash
  curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash   # Linux / macOS
  ```
  Verify with `moon version`.
- **Git** for version control.

---

## 2. Build, Test, Format / 构建、测试、格式化

```bash
moon check                 # type check + warnings (target: 0 warning, 0 error)
moon test                  # run all tests
moon fmt                   # format source files (.mbt only)
moon fmt --check           # CI-style format check (no diff allowed)
moon info                  # regenerate .mbti interface files
moon build                 # build all targets
```

**Before opening a PR**, always run:
**提交 PR 前**务必运行：

```bash
moon check && moon test && moon fmt --check
```

---

## 3. Project Layout / 项目结构

moon-geometry uses a **multi-root package** layout (flat, no `src/` directory).
Each directory is a MoonBit package with its own `moon.pkg`:

```
moon-geometry/
├── moon.mod              # module metadata
├── moon.pkg              # root package
├── reexport.mbt          # root re-export entry
├── <package>/            # each package = one directory
│   ├── moon.pkg
│   ├── *.mbt             # source
│   ├── *_test.mbt        # blackbox tests (need @pkg prefix)
│   └── *_wbtest.mbt      # whitebox tests (package-private scope)
└── .github/              # CI + community files
```

---

## 4. Code Style / 代码风格

### 4.1 Block style / 块风格
MoonBit code is organized in blocks separated by `///|`. Block order is irrelevant;
process blocks independently during refactoring.
MoonBit 代码按 `///|` 分块，块顺序无关，重构时可逐块独立处理。

### 4.2 Bilingual doc comments / 中英文档注释
**Every `pub fn` must have a `///` comment** in both English and Chinese:
**每个 `pub fn` 必须有 `///` 注释**，中英双语：

```moonbit
/// Compute the Euclidean distance between two points.
/// 计算两点间的欧几里得距离。
pub fn distance(p1 : Point, p2 : Point) -> Double {
  ...
}
```

### 4.3 0 warning policy / 零警告策略
`moon check` must report **0 warning, 0 error**. Do **not** suppress warnings with
`#warnings(...)` or `moon.pkg` warning fields. Fix the root cause instead:
`moon check` 必须 **0 warning 0 error**。**禁止**用 `#warnings(...)` 或 `moon.pkg`
warnings 字段抑制警告，必须根因治理：

- unused function → `ignore(fn)` or delete
- unused package → `ignore(@pkg)` in main source
- unused param → `fn f(_ : T)`
- public API surface → add `pub`
- trait impl → `pub impl` + `pub extend Type with Trait::{method}`

### 4.4 Trait usage / Trait 使用
Prefer `pub(open) trait` abstractions over bare functions for shared behavior.
Use `pub impl Trait for Type with method` + `pub extend Type with Trait::{method}`
so implementations are cross-package usable and warning-free.
优先用 `pub(open) trait` 抽象公共行为，而非裸函数。

### 4.5 Formatting / 格式化
Run `moon fmt` before committing. `moon fmt --check` must pass in CI.
提交前运行 `moon fmt`，CI 中 `moon fmt --check` 必须通过。

---

## 5. Adding a New Module / 新增模块

1. Create a new directory `<module>/` with a `moon.pkg` declaring dependencies:
   ```json
   { "import": [ "@moonbitlang/core" ] }
   ```
2. Add source files `*.mbt` with bilingual `///` comments on all `pub fn`.
3. Add `reexport.mbt` aggregating the package's public API:
   ```moonbit
   pub using @<module> { type T, fn_name }
   ```
4. Update the root `reexport.mbt` to re-export the new package.
5. Add `README.md` inside the new package (bilingual).
6. Run `moon info && moon fmt` and review the `.mbti` diff.

---

## 6. Testing Requirements / 测试要求

| Test type | Suffix | Scope | `@pkg` prefix? |
|-----------|--------|-------|----------------|
| Whitebox  | `_wbtest.mbt` | package-private | No |
| Blackbox  | `_test.mbt`  | external/public | Yes |

- **Every module must have whitebox tests** (`_wbtest.mbt`) covering internal logic.
- Prefer `assert_eq` / `assert_true(pattern is Pattern(...))` for stable results.
- For structured debug output, derive `Debug` and use `debug_inspect`.
- Use `moon test --update` to refresh snapshot tests when output intentionally changes.
- Check coverage with `moon coverage analyze > uncovered.log`.

**每个模块必须有白盒测试**（`_wbtest.mbt`）覆盖内部逻辑。

---

## 7. Commit & PR / 提交与 PR

- Write clear commit messages (imperative mood, e.g. `Add point-line distance`).
- One logical change per PR.
- Fill in the [PR template](.github/PULL_REQUEST_TEMPLATE.md) checklist.
- Do **not** commit secrets, credentials, or large binary files.
- Do **not** commit unless explicitly asked.

---

## 8. Reporting Issues / 反馈问题

- Bug → use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md).
- Feature → use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md).
- Include `moon version` output and the relevant package name.

---

Thank you for contributing! / 感谢你的贡献！