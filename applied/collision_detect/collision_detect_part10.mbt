///|
/// Narrow phase: polygon-polygon collision (edge test). / 窄相：多边形-多边形碰撞（边测试）。
pub fn polygon_polygon_collide(
  poly1 : Array[@core.Point2D],
  poly2 : Array[@core.Point2D],
) -> Bool {
  for i in 0..<poly1.length() {
    if point_in_polygon(poly1[i], poly2) {
      return true
    }
  }
  for i in 0..<poly2.length() {
    if point_in_polygon(poly2[i], poly1) {
      return true
    }
  }
  let n1 = poly1.length()
  let n2 = poly2.length()
  for i in 0..<n1 {
    for j in 0..<n2 {
      if segment_segment_collide(poly1[i], poly1[(i + 1) % n1], poly2[j], poly2[(j + 1) % n2]) {
        return true
      }
    }
  }
  false
}
