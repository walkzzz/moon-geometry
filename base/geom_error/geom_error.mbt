///|
/// Unified geometry error type for Result-based error handling. / 统一几何错误类型，用于 Result 错误处理。
///
/// Provides a structured error type as an alternative to `raise`. Downstream
/// developers can use `Result[T, GeomError]` for safe error handling.
///
/// 提供结构化错误类型作为 `raise` 的替代。下游开发者可以使用
/// `Result[T, GeomError]` 进行安全错误处理。

///|
/// Geometry error types. / 几何错误类型。
pub enum GeomError {
  /// Empty input (no points, no vertices, etc.). / 空输入（无点、无顶点等）。
  EmptyInput
  /// Insufficient input (too few points for operation). / 输入不足（操作所需点数不够）。
  InsufficientInput(String)
  /// Degenerate geometry (collinear, coincident, zero-area). / 退化几何（共线、重合、零面积）。
  DegenerateGeometry(String)
  /// Numerical failure (singular matrix, convergence failure). / 数值失败（奇异矩阵、收敛失败）。
  NumericalFailure(String)
  /// Invalid parameter (negative radius, out-of-range parameter). / 无效参数（负半径、超出范围的参数）。
  InvalidParameter(String)
  /// Topology error (non-manifold, dangling edge). / 拓扑错误（非流形、悬挂边）。
  TopologyError(String)
  /// I/O error (parse failure, write failure). / I/O 错误（解析失败、写入失败）。
  IoError(String)
} derive(Debug, Eq)

///|
pub extend GeomError with Eq::{not_equal, equal}

///|
pub extend GeomError with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Suppress unused constructor warnings — all variants are part of public API. / 抑制未使用构造子警告——所有变体都是公共 API 的一部分。
fn _suppress_unused_geom_error() -> Unit {
  ignore(EmptyInput)
  ignore(InsufficientInput(""))
  ignore(DegenerateGeometry(""))
  ignore(NumericalFailure(""))
  ignore(InvalidParameter(""))
  ignore(TopologyError(""))
  ignore(IoError(""))
}

///|
/// Convert GeomError to a human-readable message. / 将 GeomError 转换为可读消息。
pub fn GeomError::to_message(self : GeomError) -> String {
  match self {
    EmptyInput => "Empty input"
    InsufficientInput(msg) => "Insufficient input: " + msg
    DegenerateGeometry(msg) => "Degenerate geometry: " + msg
    NumericalFailure(msg) => "Numerical failure: " + msg
    InvalidParameter(msg) => "Invalid parameter: " + msg
    TopologyError(msg) => "Topology error: " + msg
    IoError(msg) => "I/O error: " + msg
  }
}
