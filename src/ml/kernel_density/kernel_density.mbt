///|
/// # Kernel Density Estimation | 核密度估计
/// Kernel density estimation on geometric data. / 几何数据核密度估计。
///|
pub fn gaussian_kernel(x : Double, h : Double) -> Double {
  let u = x / h
  @math.exp(-0.5 * u * u) / (h * (2.0 * @math.PI).sqrt())
}
///|
pub fn kde_estimate(points : Array[Double], x : Double, h : Double) -> Double {
  let n = points.length().to_double()
  let mut sum = 0.0
  for i in 0..<points.length() {
    sum += gaussian_kernel(x - points[i], h)
  }
  sum / n
}
///|
pub fn silverman_bandwidth(n : Int, std_dev : Double) -> Double {
  1.06 * std_dev * @math.pow(1.0 / n.to_double(), 1.0 / 5.0)
}
///|
pub fn epanechnikov_kernel(x : Double, h : Double) -> Double {
  let u = x / h
  if u.abs() <= 1.0 { 0.75 * (1.0 - u * u) / h } else { 0.0 }
}
