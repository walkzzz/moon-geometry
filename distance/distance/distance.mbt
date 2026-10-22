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

///|
/// Distance from a point to a polygon (0 if inside or on boundary).
/// 点到多边形的距离（在内部或边界上时为 0）。
pub fn point_to_polygon_distance(
  p : @core.Point2D,
  poly : @core.Polygon,
) -> Double {
  if @polygon.point_in_polygon(p, poly) {
    return 0.0
  }
  let n = poly.size()
  let mut min_dist = point_to_segment_distance(
    p,
    @core.Segment::new(poly.get(0), poly.get(1)),
  )
  for i in 1..<n {
    let d = point_to_segment_distance(
      p,
      @core.Segment::new(poly.get(i), poly.get((i + 1) % n)),
    )
    if d < min_dist {
      min_dist = d
    }
  }
  min_dist
}

///|
/// Minimum distance between two line segments.
/// 两线段之间的最小距离。
pub fn segment_to_segment_distance(
  s1 : @core.Segment,
  s2 : @core.Segment,
) -> Double {
  if @intersect.segments_intersect(s1, s2) {
    return 0.0
  }
  let p1 = s1.start
  let p2 = s1.end
  let p3 = s2.start
  let p4 = s2.end
  let d1 = point_to_segment_distance(p1, s2)
  let d2 = point_to_segment_distance(p2, s2)
  let d3 = point_to_segment_distance(p3, s1)
  let d4 = point_to_segment_distance(p4, s1)
  let mut min_d = d1
  if d2 < min_d {
    min_d = d2
  }
  if d3 < min_d {
    min_d = d3
  }
  if d4 < min_d {
    min_d = d4
  }
  min_d
}

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
