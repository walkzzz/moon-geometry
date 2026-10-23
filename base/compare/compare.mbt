///|
/// Robust orientation test: returns 1 if CCW, -1 if CW, 0 if collinear. / 鲁棒方向判定。
pub fn robust_orientation(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Int {
  let cross = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let eps = @core.default_eps
  if cross > eps {
    1
  } else if cross < -eps {
    -1
  } else {
    0
  }
}

