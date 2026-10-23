///|
/// Compute discrete Gaussian curvature of a 2D polygon. / 计算二维多边形的离散高斯曲率。
pub fn discrete_curvature2d(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for a in angles {
    sum += a
  }
  2.0 * @math.PI - sum
}
