///|
/// Radius of curvature (1/curvature). / 曲率半径（1/曲率）。
pub fn curvature_radius(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let k = curvature_at(p1, p2, p3)
  if k < 0.000000000001 {
    return 1.0 / 0.000000000001
  }
  1.0 / k
}

///|
/// Total absolute curvature (approximation of total curvature). / 总绝对曲率。
pub fn curvature_total(points : Array[@core.Point2D]) -> Double {
  let profile = curvature_profile(points)
  let mut total = 0.0
  for k in profile {
    total += k
  }
  total
}
