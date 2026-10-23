///|
/// Discrete curvature at point i (using three consecutive points). / 在点 i 处的离散曲率（使用三个连续点）。
pub fn spline_curvature(
  points : Array[@core.Point2D],
  i : Int,
) -> Double {
  let n = points.length()
  if i < 1 || i > n - 2 {
    return 0.0
  }
  let p1 = points[i - 1]
  let p2 = points[i]
  let p3 = points[i + 1]
  let dx1 = p2.x() - p1.x()
  let dy1 = p2.y() - p1.y()
  let dx2 = p3.x() - p2.x()
  let dy2 = p3.y() - p2.y()
  let cross = dx1 * dy2 - dy1 * dx2
  let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if len1 < 0.000000000001 || len2 < 0.000000000001 {
    return 0.0
  }
  let len3 = ((p3.x() - p1.x()) * (p3.x() - p1.x()) + (p3.y() - p1.y()) * (p3.y() - p1.y())).sqrt()
  if len3 < 0.000000000001 {
    return 0.0
  }
  2.0 * cross.abs() / (len1 * len2 * len3)
}
