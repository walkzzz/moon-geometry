///| Information Geometry | 信息几何
///| Fisher information metric, statistical manifolds, dual connections
///| Fisher 信息度量、统计流形、对偶联络

///| Fisher metric components for Gaussian distribution. / 高斯分布的 Fisher 度量分量。
pub fn fisher_metric_gaussian(_ : Double, sigma : Double) -> (Double, Double) {
  let g11 = 1.0 / (sigma * sigma)
  let g22 = 2.0 / (sigma * sigma)
  (g11, g22)
}

///| Fisher metric for Bernoulli distribution. / 伯努利分布的 Fisher 度量。
pub fn fisher_metric_bernoulli(p : Double) -> Double {
  1.0 / (p * (1.0 - p))
}

///| Fisher metric for Poisson distribution. / 泊松分布的 Fisher 度量。
pub fn fisher_metric_poisson(lambda : Double) -> Double {
  1.0 / lambda
}

///| Kullback-Leibler divergence between two Bernoulli distributions. / 两个伯努利分布间的 KL 散度。
pub fn kl_divergence(p : Double, q : Double) -> Double {
  p * @math.ln(p / q) + (1.0 - p) * @math.ln((1.0 - p) / (1.0 - q))
}

///| Jeffreys symmetric divergence between two distributions. / 两个分布间的 Jeffreys 对称散度。
pub fn jeffreys_divergence(p : Double, q : Double) -> Double {
  kl_divergence(p, q) + kl_divergence(q, p)
}

///| Alpha-connection components from metric and alpha. / 由度量和 alpha 计算 α-联络分量。
pub fn alpha_connection(g11 : Double, g22 : Double, alpha : Double) -> (Double, Double) {
  ((1.0 - alpha) * g11 / 2.0, (1.0 - alpha) * g22 / 2.0)
}
