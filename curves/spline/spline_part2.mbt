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
