///|
/// # Gaussian Process | 高斯过程
/// Gaussian process regression on manifolds. / 流形上的高斯过程回归。
///|
pub fn squared_exp_kernel(x1 : Double, x2 : Double, l : Double, sigma : Double) -> Double {
  let d = x1 - x2
  sigma * sigma * @math.exp(-0.5 * d * d / (l * l))
}
///|
pub fn matern_kernel(x1 : Double, x2 : Double, l : Double, nu : Double) -> Double {
  let d = (x1 - x2).abs()
  if d < 0.000000000001 { 1.0 } else {
    let r = d * (2.0 * nu).sqrt() / l
    (1.0 + r) * @math.exp(-r)
  }
}
///|
pub fn rational_quad_kernel(x1 : Double, x2 : Double, l : Double, alpha : Double) -> Double {
  let d = x1 - x2
  1.0 + d * d / (2.0 * alpha * l * l)
}
///|
pub fn gp_predict_mean(k_train : Array[Double], k_test : Array[Double], y : Array[Double], noise : Double) -> Double {
  let n = y.length()
  let mut num = 0.0
  for i in 0..<n {
    num += k_test[i] * y[i]
  }
  let mut den = 0.0
  for i in 0..<n {
    den += k_train[i] * k_test[i]
  }
  den += noise
  if den.abs() < 0.000000000001 { 0.0 } else { num / den }
}
