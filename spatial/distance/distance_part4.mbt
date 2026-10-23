///|
/// Minimum distance between two polygons (0 if they overlap).
/// 两多边形之间的最小距离（重叠时为 0）。
pub fn polygon_to_polygon_distance(
  p1 : @core.Polygon,
  p2 : @core.Polygon,
) -> Double {
  let n1 = p1.size()
  let n2 = p2.size()
  let mut min_dist = point_to_segment_distance(
    p1.get(0),
    @core.Segment::new(p2.get(0), p2.get(1)),
  )
  for i in 0..<n1 {
    let seg1 = @core.Segment::new(p1.get(i), p1.get((i + 1) % n1))
    for j in 0..<n2 {
      let seg2 = @core.Segment::new(p2.get(j), p2.get((j + 1) % n2))
      let d = segment_to_segment_distance(seg1, seg2)
      if d < min_dist {
        min_dist = d
      }
    }
  }
  min_dist
}

///|
/// Distance from a point to a line (infinite).
/// 点到直线（无限长）的距离。
pub fn point_to_line_distance(p : @core.Point2D, line : @core.Line) -> Double {
  line.point_distance(p)
}
