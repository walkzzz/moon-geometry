///|
/// Tangent points from an external point to a convex polygon.
/// Returns (left_tangent_index, right_tangent_index).
/// Polygon must be convex and CCW. Point must be outside.
///
/// 从外部点到凸多边形的切点。返回 (左切线索引, 右切线索引)。
pub fn tangent_from_point(
  poly : @core.Polygon,
  p : @core.Point2D,
) -> (Int32, Int32) {
  let n = poly.size()
  if n == 0 {
    return (-1, -1)
  }
  let mut left = 0
  let mut right = 0
  for i in 1..<n {
    let prev_l = poly.get(left)
    let curr = poly.get(i)
    let cross_l = @core.turn(p, prev_l, curr)
    if cross_l > 0.0 {
      left = i
    }
    let prev_r = poly.get(right)
    let cross_r = @core.turn(p, prev_r, curr)
    if cross_r < 0.0 {
      right = i
    }
  }
  (left, right)
}
