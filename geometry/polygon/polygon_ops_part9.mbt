///|
/// Recursive core of Douglas-Peucker.
/// Douglas-Peucker 递归核心。
fn dp_recursive(
  pts : Array[@core.Point2D],
  start : Int,
  end : Int,
  epsilon : Double,
  keep : Array[Bool],
) -> Unit {
  if end <= start + 1 {
    return
  }
  let mut max_dist = 0.0
  let mut max_idx = start
  for i in (start + 1)..<end {
    let d = point_segment_dist(pts[i], pts[start], pts[end])
    if d > max_dist {
      max_dist = d
      max_idx = i
    }
  }
  if max_dist > epsilon {
    keep[max_idx] = true
    dp_recursive(pts, start, max_idx, epsilon, keep)
    dp_recursive(pts, max_idx, end, epsilon, keep)
  }
}
