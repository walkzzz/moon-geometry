///|
/// Perpendicular distance from point p to line segment (a, b).
/// 点 p 到线段 (a, b) 的垂直距离。
fn point_segment_dist(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  let len_sq = dx * dx + dy * dy
  if len_sq == 0.0 {
    return p.dist(a)
  }
  let t = ((p.x - a.x) * dx + (p.y - a.y) * dy) / len_sq
  let tc = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let proj = @core.Point2D::new(a.x + tc * dx, a.y + tc * dy)
  p.dist(proj)
}
