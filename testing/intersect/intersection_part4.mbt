///|
/// Intersection of a line (general form) with a segment.
/// 直线（一般式）与线段的交点。
pub fn line_segment_intersection(
  line : @core.Line,
  seg : @core.Segment,
) -> @core.Point2D? {
  let d = seg.end.sub(seg.start)
  let denom = line.a * d.x + line.b * d.y
  if denom == 0.0 {
    // Parallel
    if line.evaluate(seg.start) == 0.0 {
      // @core.Collinear: return segment start as a point on both
      return Some(seg.start)
    }
    return None
  }
  let t = -(line.a * seg.start.x + line.b * seg.start.y + line.c) / denom
  if t >= 0.0 && t <= 1.0 {
    Some(@core.Point2D::new(seg.start.x + t * d.x, seg.start.y + t * d.y))
  } else {
    None
  }
}
