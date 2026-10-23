///|
/// Distance from a point to a line segment.
/// 点到线段的距离。
pub fn point_to_segment_distance(
  p : @core.Point2D,
  seg : @core.Segment,
) -> Double {
  let a = seg.start
  let b = seg.end
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
