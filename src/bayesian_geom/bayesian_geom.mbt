///|
/// # Bayesian Geometry | 贝叶斯几何
/// Bayesian inference on geometric distributions. / 几何分布贝叶斯推断。
///|
pub fn gaussian_log_likelihood(x : Double, mean : Double, std : Double) -> Double {
  let variance = std * std
  -0.5 * @math.ln(2.0 * @math.PI * variance) - (x - mean) * (x - mean) / (2.0 * variance)
}
///|
pub fn posterior_mean(prior_mean : Double, prior_var : Double, data_mean : Double, data_var : Double) -> Double {
  let denom = 1.0 / prior_var + 1.0 / data_var
  if denom.abs() < 0.000000000001 { prior_mean } else {
    (prior_mean / prior_var + data_mean / data_var) / denom
  }
}
///|
pub fn posterior_var(prior_var : Double, data_var : Double) -> Double {
  let denom = 1.0 / prior_var + 1.0 / data_var
  if denom.abs() < 0.000000000001 { prior_var } else { 1.0 / denom }
}
///|
pub fn bayes_update(prior : Double, likelihood : Double, evidence : Double) -> Double {
  if evidence.abs() < 0.000000000001 { 0.0 } else { prior * likelihood / evidence }
}
