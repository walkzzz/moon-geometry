///|
/// Check if a 2D point lies inside a 2D triangle.
/// 检查二维点是否在二维三角形内。
pub fn point_in_triangle_2d(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let eps = 0.0000001
  let d1 = sign2(p, a, b)
  let d2 = sign2(p, b, c)
  let d3 = sign2(p, c, a)
  let has_neg = d1 < -eps || d2 < -eps || d3 < -eps
  let has_pos = d1 > eps || d2 > eps || d3 > eps
  !(has_neg && has_pos)
}

///|
fn sign2(p : @core.Point2D, a : @core.Point2D, b : @core.Point2D) -> Double {
  (p.x() - b.x()) * (a.y() - b.y()) - (a.x() - b.x()) * (p.y() - b.y())
}
