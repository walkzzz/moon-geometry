///|
/// Cross product of vectors (b-a) and (c-a).
/// 向量 (b-a) 和 (c-a) 的叉积。

///|
/// Distance from point p to line through a and b.
/// 点 p 到直线 ab 的距离。
fn point_line_dist(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len = (dx * dx + dy * dy).sqrt()
  if len < @core.default_eps {
    return 0.0
  }
  let cross_val = dx * (p.y() - a.y()) - dy * (p.x() - a.x())
  cross_val.abs() / len
}
