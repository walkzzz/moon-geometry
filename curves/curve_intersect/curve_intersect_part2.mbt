///|
/// Check if a polyline self-intersects. / 检查折线是否自相交。
pub fn curve_self_intersect(points : Array[@core.Point2D]) -> Bool {
  let n = points.length()
  if n < 4 {
    return false
  }
  for i in 0..<(n - 1) {
    for j in (i + 2)..<(n - 1) {
      if segments_cross(points[i], points[i + 1], points[j], points[j + 1]) {
        return true
      }
    }
  }
  false
}
