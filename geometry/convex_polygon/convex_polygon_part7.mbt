///|
/// Minimum distance from a point to a convex polygon.
/// O(n) edge check. / 点到凸多边形最小距离。O(n)。
pub fn point_to_convex_polygon_distance(
  poly : @core.Polygon,
  p : @core.Point2D,
) -> Double {
  if point_in_convex_polygon(poly, p) {
    return 0.0
  }
  let n = poly.size()
  let mut best = 999999999999999.0
  for i in 0..<n {
    let a = poly.get(i)
    let b = poly.get((i + 1) % n)
    let seg = @core.Segment::new(a, b)
    let d = @distance.point_to_segment_distance(p, seg)
    if d < best {
      best = d
    }
  }
  best
}
