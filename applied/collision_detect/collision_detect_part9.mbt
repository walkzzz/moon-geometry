///|
/// Narrow phase: segment-polygon collision. / 窄相：线段-多边形碰撞。
pub fn segment_polygon_collide(
  a : @core.Point2D,
  b : @core.Point2D,
  poly : Array[@core.Point2D],
) -> Bool {
  if point_in_polygon(a, poly) || point_in_polygon(b, poly) {
    return true
  }
  let n = poly.length()
  for i in 0..<n {
    if segment_segment_collide(a, b, poly[i], poly[(i + 1) % n]) {
      return true
    }
  }
  false
}
