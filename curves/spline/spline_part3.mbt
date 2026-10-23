///|
/// Find the point of maximum curvature. / 找到最大曲率点。
pub fn spline_max_curvature_point(points : Array[@core.Point2D]) -> Int32? {
  let n = points.length()
  if n < 3 {
    return None
  }
  let mut max_k = 0.0
  let mut max_idx = 1
  for i in 1..<(n - 1) {
    let k = spline_curvature(points, i)
    if k > max_k {
      max_k = k
      max_idx = i
    }
  }
  Some(max_idx)
}
