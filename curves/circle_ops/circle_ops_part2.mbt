///|
/// Intersection points of two circles (0/1/2 points).
/// Returns 0, 1, or 2 intersection points.
/// 两圆交点（0/1/2 个）。
/// 返回 0、1 或 2 个交点。
pub fn circle_circle_intersect(
  c1 : @core.Circle,
  c2 : @core.Circle,
) -> Array[@core.Point2D] {
  let dx = c2.center.x - c1.center.x
  let dy = c2.center.y - c1.center.y
  let d = (dx * dx + dy * dy).sqrt()
  let result : Array[@core.Point2D] = []
  if d == 0.0 {
    return result
  }
  if d > c1.radius + c2.radius {
    return result
  }
  if d < (c1.radius - c2.radius).abs() {
    return result
  }
  let a = (c1.radius * c1.radius - c2.radius * c2.radius + d * d) / (2.0 * d)
  let h_sq = c1.radius * c1.radius - a * a
  let px = c1.center.x + a * dx / d
  let py = c1.center.y + a * dy / d
  if h_sq <= 0.0 {
    result.push(@core.Point2D::new(px, py))
    return result
  }
  let h = h_sq.sqrt()
  let rx = -dy * h / d
  let ry = dx * h / d
  result.push(@core.Point2D::new(px + rx, py + ry))
  result.push(@core.Point2D::new(px - rx, py - ry))
  result
}
