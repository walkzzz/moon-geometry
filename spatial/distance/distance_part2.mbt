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
