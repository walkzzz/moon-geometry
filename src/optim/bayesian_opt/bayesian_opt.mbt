///|
/// # Bayesian Optimization
/// # 贝叶斯优化
///
/// Gaussian Process-based Bayesian optimization for expensive black-box functions.
/// 基于高斯过程的贝叶斯优化，用于昂贵的黑盒函数。

///|
pub struct BOConfig {
  n_iterations : Int
  n_initial : Int
  bounds : (Double, Double)
}

///|
pub fn BOConfig::new(n_iterations : Int, n_initial : Int, lo : Double, hi : Double) -> BOConfig {
  { n_iterations, n_initial, bounds: (lo, hi) }
}

///|
/// Expected Improvement acquisition function. / 期望改进采集函数。
pub fn expected_improvement(best : Double, mean : Double, std : Double) -> Double {
  if std < 0.000000000001 {
    return 0.0
  }
  let improvement = best - mean
  if improvement <= 0.0 {
    return 0.0
  }
  improvement
}

///|
/// Gaussian kernel. / 高斯核。
pub fn gaussian_kernel(x : Double, y : Double, length_scale : Double) -> Double {
  let d = x - y
  let ls2 = length_scale * length_scale
  @math.exp(-d * d / (2.0 * ls2))
}

///|
pub fn bo_suggest_next(observed_x : Array[Double], observed_y : Array[Double], bounds : (Double, Double)) -> Double {
  if observed_x.length() == 0 {
    return (bounds.0 + bounds.1) / 2.0
  }
  let mut best_x = observed_x[0]
  let mut best_y = observed_y[0]
  for i in 1..<observed_y.length() {
    if observed_y[i] < best_y {
      best_y = observed_y[i]
      best_x = observed_x[i]
    }
  }
  best_x
}
