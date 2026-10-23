///|
/// Closest pair of points via divide and conquer. O(n log n).
/// Returns the closest pair and their distance, or None if fewer than 2 points.
/// 返回最近点对及其距离，少于 2 点返回 None。
pub fn closest_pair(
  points : Array[@core.Point2D],
) -> (@core.Point2D, @core.Point2D, Double)? {
  let n = points.length()
  if n < 2 {
    return None
  }
  if n <= 3 {
    return closest_pair_brute(points, 0, n - 1)
  }
  let pts = points.copy()
  pts.sort_by(fn(a, b) {
    if a.x < b.x {
      -1
    } else if a.x > b.x {
      1
    } else if a.y < b.y {
      -1
    } else if a.y > b.y {
      1
    } else {
      0
    }
  })
  closest_pair_rec(pts, 0, n - 1)
}
