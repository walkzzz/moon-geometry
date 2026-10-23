///|
/// Count self-intersections of a polyline. / 计数折线自相交次数。
pub fn curve_self_intersect_count(
  points : Array[@core.Point2D],
) -> Int {
  let n = points.length()
  if n < 4 {
    return 0
  }
  let mut count = 0
  for i in 0..<(n - 1) {
    for j in (i + 2)..<(n - 1) {
      if segments_cross(points[i], points[i + 1], points[j], points[j + 1]) {
        count += 1
      }
    }
  }
  count
}
