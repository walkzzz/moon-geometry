///|
/// Intersection points of a circle and a line segment (0/1/2 points).
/// Returns 0, 1, or 2 intersection points.
/// 圆与线段的交点（0/1/2 个）。
/// 返回 0、1 或 2 个交点。
pub fn circle_segment_intersect(
  circle : @core.Circle,
  seg : @core.Segment,
) -> Array[@core.Point2D] {
  let cx = circle.center.x
  let cy = circle.center.y
  let r = circle.radius
  let ax = seg.start.x
  let ay = seg.start.y
  let bx = seg.end.x
  let by = seg.end.y
  let dx = bx - ax
  let dy = by - ay
  let fx = ax - cx
  let fy = ay - cy
  let a = dx * dx + dy * dy
  let b = 2.0 * (fx * dx + fy * dy)
  let c = fx * fx + fy * fy - r * r
  let disc = b * b - 4.0 * a * c
  let result : Array[@core.Point2D] = []
  if disc < 0.0 || a == 0.0 {
    return result
  }
  let sq = disc.sqrt()
  let t1 = (-b - sq) / (2.0 * a)
  let t2 = (-b + sq) / (2.0 * a)
  if t1 >= 0.0 && t1 <= 1.0 {
    result.push(@core.Point2D::new(ax + t1 * dx, ay + t1 * dy))
  }
  if t2 >= 0.0 && t2 <= 1.0 {
    result.push(@core.Point2D::new(ax + t2 * dx, ay + t2 * dy))
  }
  result
}
