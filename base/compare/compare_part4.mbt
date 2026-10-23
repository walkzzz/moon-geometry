///|
/// Check if a < b lexicographically. / 字典序小于。
pub fn less_than(a : @core.Point2D, b : @core.Point2D) -> Bool {
  compare_points(a, b) < 0
}


///|
/// Check if two points are equal within epsilon. / 检查两点是否在精度内相等。
pub fn points_equal(
  a : @core.Point2D,
  b : @core.Point2D,
  eps : Double,
) -> Bool {
  @core.approx_eq(a.x(), b.x(), eps) && @core.approx_eq(a.y(), b.y(), eps)
}