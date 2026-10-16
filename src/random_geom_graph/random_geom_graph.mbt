///| Random Geometric Graphs | 随机几何图
///| Connectivity, percolation, coverage thresholds
///| 连通性、渗流、覆盖阈值

pub fn connectivity_threshold(n : Int, area : Double) -> Double {
  (@math.ln(n.to_double()) / (n.to_double() * @math.PI)).sqrt()
}

pub fn percolation_threshold_2d() -> Double {
  0.5
}

pub fn coverage_threshold(n : Int, area : Double) -> Double {
  (@math.ln(n.to_double()) / n.to_double()).sqrt()
}

pub fn expected_degree(n : Int, radius : Double, area : Double) -> Double {
  (n - 1).to_double() * @math.PI * radius * radius / area
}

pub fn isolation_probability(n : Int, radius : Double, area : Double) -> Double {
  let p = 1.0 - @math.PI * radius * radius / area
  @math.pow(p, (n - 1).to_double())
}
