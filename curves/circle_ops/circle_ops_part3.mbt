///|
/// Intersection points of a circle and an infinite line (0/1/2 points).
/// Returns 0, 1, or 2 intersection points.
/// 圆与无限直线的交点（0/1/2 个）。
/// 返回 0、1 或 2 个交点。
pub fn circle_line_intersect(
  circle : @core.Circle,
  line : @core.Line,
) -> Array[@core.Point2D] {
  let cx = circle.center.x
  let cy = circle.center.y
  let r = circle.radius
  let a = line.a
  let b = line.b
  let c = line.c
  let denom = a * a + b * b
  let result : Array[@core.Point2D] = []
  if denom == 0.0 {
    return result
  }
  let dist = (a * cx + b * cy + c).abs() / denom.sqrt()
  if dist > r {
    return result
  }
  let x0 = (b * (b * cx - a * cy) - a * c) / denom
  let y0 = (a * (-b * cx + a * cy) - b * c) / denom
  if dist == r {
    result.push(@core.Point2D::new(x0, y0))
    return result
  }
  let offset = (r * r - dist * dist).sqrt() / denom.sqrt()
  let dx = -b * offset
  let dy = a * offset
  result.push(@core.Point2D::new(x0 + dx, y0 + dy))
  result.push(@core.Point2D::new(x0 - dx, y0 - dy))
  result
}
