///|
/// Exact orientation test: returns +1 if CCW, -1 if CW, 0 if collinear.
/// 精确定向测试：逆时针返回+1，顺时针返回-1，共线返回0。
pub fn exact_orientation(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Int32 {
  let det = (b.x() - a.x()) * (c.y() - a.y()) -
    (b.y() - a.y()) * (c.x() - a.x())
  if det > 0.0 {
    1
  } else if det < 0.0 {
    -1
  } else {
    0
  }
}
