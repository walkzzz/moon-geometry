///|
/// # CMA-ES
/// # 协方差矩阵自适应进化策略
///
/// Covariance Matrix Adaptation Evolution Strategy for continuous optimization.
/// 协方差矩阵自适应进化策略，用于连续优化。

///|
pub struct CmaesConfig {
  dim : Int
  pop_size : Int
  sigma : Double
  max_iter : Int
}

///|
pub fn CmaesConfig::new(dim : Int, pop_size : Int, sigma : Double, max_iter : Int) -> CmaesConfig {
  { dim, pop_size, sigma, max_iter }
}

///|
/// Update step size sigma. / 更新步长sigma。
pub fn update_sigma(sigma : Double, ps_norm : Double, dim : Int) -> Double {
  let cs = 2.0 / (dim.to_double() + 2.0).sqrt()
  let damps = 0.5 + cs
  sigma * @math.exp((ps_norm - dim.to_double().sqrt()) / damps)
}

///|
/// Covariance matrix adaptation factor. / 协方差矩阵自适应因子。
pub fn cmaes_adapt_factor(gen : Int, dim : Int) -> Double {
  let c = 4.0 / (dim.to_double() + 4.0)
  1.0 - c * c / (gen.to_double() + 1.0)
}

///|
pub fn cmaes_convergence_check(sigma : Double, threshold : Double) -> Bool {
  sigma < threshold
}
