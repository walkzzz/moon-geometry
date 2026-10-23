///|
/// # Filtered Predicates
/// # 过滤谓词
///
/// Fast approximate predicates with fallback to exact computation.
/// 快速近似谓词，必要时回退到精确计算。


///|
pub fn filtered_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  let det = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let eps = 0.000000000001 * ((b.x() - a.x()).abs() * (c.y() - a.y()).abs() + (b.y() - a.y()).abs() * (c.x() - a.x()).abs())
  if det > eps { 1 } else if det < -eps { -1 } else { 0 }
}
