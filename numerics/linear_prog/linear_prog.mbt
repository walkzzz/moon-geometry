///|
/// 2D linear programming result. / 二维线性规划结果。
pub struct LPResult {
  point : @core.Point2D
  value : Double
} derive(Debug)

pub extend LPResult with @moonbitlang/core/debug.Debug::{to_repr}
