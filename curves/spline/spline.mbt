///|
/// Total length of a spline (sum of segment lengths). / 样条总长度（线段长度之和）。
pub fn spline_length(points : Array[@core.Point2D]) -> Double {
  @core.polyline_length(points)
}

///|
/// Curvature profile at all interior points. / 所有内部点的曲率分布。
pub fn spline_curvature_profile(points : Array[@core.Point2D]) -> Array[Double] {
  let n = points.length()
  let result : Array[Double] = []
  if n < 3 {
    return result
  }
  for i in 1..<(n - 1) {
    result.push(spline_curvature(points, i))
  }
  result
}

///|
/// Total absolute curvature. / 总绝对曲率。
pub fn spline_total_curvature(points : Array[@core.Point2D]) -> Double {
  let profile = spline_curvature_profile(points)
  let mut total = 0.0
  for k in profile {
    total += k
  }
  total
}

///|
/// Discrete curvature at point i (using three consecutive points). / 在点 i 处的离散曲率（使用三个连续点）。
pub fn spline_curvature(points : Array[@core.Point2D], i : Int32) -> Double {
  let n = points.length()
  if i < 1 || i > n - 2 {
    return 0.0
  }
  let p1 = points[i - 1]
  let p2 = points[i]
  let p3 = points[i + 1]
  let dx1 = p2.x() - p1.x()
  let dy1 = p2.y() - p1.y()
  let dx2 = p3.x() - p2.x()
  let dy2 = p3.y() - p2.y()
  let cross = dx1 * dy2 - dy1 * dx2
  let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if len1 < 0.000000000001 || len2 < 0.000000000001 {
    return 0.0
  }
  let len3 = ((p3.x() - p1.x()) * (p3.x() - p1.x()) +
  (p3.y() - p1.y()) * (p3.y() - p1.y())).sqrt()
  if len3 < 0.000000000001 {
    return 0.0
  }
  2.0 * cross.abs() / (len1 * len2 * len3)
}

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
