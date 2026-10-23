///|
/// Result of a line fit: y = slope * x + intercept.
/// 直线拟合结果：y = slope * x + intercept。
pub struct LineFit {
  slope : Double
  intercept : Double
  r_squared : Double
} derive(Debug)


///|
pub extend LineFit with @moonbitlang/core/debug.Debug::{to_repr}


///|
/// Result of a circle fit: center (cx, cy) and radius.
/// 圆拟合结果：圆心 (cx, cy) 和半径。
pub struct CircleFit {
  cx : Double
  cy : Double
  radius : Double
  r_squared : Double
} derive(Debug)


///|
pub extend CircleFit with @moonbitlang/core/debug.Debug::{to_repr}
