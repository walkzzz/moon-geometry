///| Information Geometry | 信息几何
///| Fisher information metric, statistical manifolds, dual connections
///| Fisher 信息度量、统计流形、对偶联络

pub fn fisher_metric_gaussian(mu : Double, sigma : Double) -> (Double, Double) {
  let g11 = 1.0 / (sigma * sigma)
  let g22 = 2.0 / (sigma * sigma)
  (g11, g22)
}

pub fn fisher_metric_bernoulli(p : Double) -> Double {
  1.0 / (p * (1.0 - p))
}

pub fn fisher_metric_poisson(lambda : Double) -> Double {
  1.0 / lambda
}

pub fn kl_divergence(p : Double, q : Double) -> Double {
  p * @math.ln(p / q) + (1.0 - p) * @math.ln((1.0 - p) / (1.0 - q))
}

pub fn jeffreys_divergence(p : Double, q : Double) -> Double {
  kl_divergence(p, q) + kl_divergence(q, p)
}

pub fn alpha_connection(g11 : Double, g22 : Double, alpha : Double) -> (Double, Double) {
  ((1.0 - alpha) * g11 / 2.0, (1.0 - alpha) * g22 / 2.0)
}
