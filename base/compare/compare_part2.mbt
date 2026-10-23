///|
/// Robust right turn test. / 鲁棒右转判定。
pub fn robust_right_turn(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  robust_orientation(a, b, c) < 0
}


///|
/// Robust collinearity test. / 鲁棒共线判定。
pub fn robust_collinear(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  eps : Double,
) -> Bool {
  let cross = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let area = cross.abs()
  let len = ((b.x() - a.x()) * (b.x() - a.x()) + (b.y() - a.y()) * (b.y() - a.y())).sqrt()
  if len < eps {
    return true
  }
  area / len < eps
}
