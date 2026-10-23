///|
/// Reparameterize points by arc length (equal arc length spacing). / 按弧长重新参数化（等弧长间距）。
pub fn arc_length_parametrize(
  points : Array[@core.Point2D],
  num_samples : Int,
) -> Array[@core.Point2D] {
  let n = points.length()
  if n < 2 || num_samples < 2 {
    return points
  }
  let total = arc_length(points)
  if total < 0.000000000001 {
    return points
  }
  let result : Array[@core.Point2D] = []
  let mut seg_idx = 0
  let mut seg_start_dist = 0.0
  for i in 0..<num_samples {
    let target_dist = total * i.to_double() / (num_samples - 1).to_double()
    while seg_idx < n - 2 {
      let seg_len = points[seg_idx].dist(points[seg_idx + 1])
      if seg_start_dist + seg_len < target_dist {
        seg_start_dist += seg_len
        seg_idx += 1
      } else {
        break
      }
    }
    let seg_len = points[seg_idx].dist(points[seg_idx + 1])
    if seg_len < 0.000000000001 {
      result.push(points[seg_idx])
    } else {
      let t = (target_dist - seg_start_dist) / seg_len
      result.push(@core.Point2D::new(
        points[seg_idx].x() + t * (points[seg_idx + 1].x() - points[seg_idx].x()),
        points[seg_idx].y() + t * (points[seg_idx + 1].y() - points[seg_idx].y()),
      ))
    }
  }
  result
}
