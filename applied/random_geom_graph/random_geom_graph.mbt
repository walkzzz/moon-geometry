///| Random Geometric Graphs | 随机几何图

///| Connectivity, percolation, coverage thresholds

///| 连通性、渗流、覆盖阈值

///|
/// Compute asymptotic connectivity threshold radius for a random geometric graph. / 计算随机几何图的渐近连通性阈值半径。
pub fn connectivity_threshold(n : Int32, _area : Double) -> Double {
  (@math.ln(n.to_double()) / (n.to_double() * @math.PI)).sqrt()
}

///|
/// Return 2D percolation threshold constant. / 返回二维渗流阈值常数。
pub fn percolation_threshold_2d() -> Double {
  0.5
}

///|
/// Compute coverage threshold radius for n points. / 计算 n 个点的覆盖阈值半径。
pub fn coverage_threshold(n : Int32, _ : Double) -> Double {
  (@math.ln(n.to_double()) / n.to_double()).sqrt()
}

///|
/// Compute expected degree of a node in a random geometric graph. / 计算随机几何图中节点的期望度数。
pub fn expected_degree(n : Int32, radius : Double, area : Double) -> Double {
  (n - 1).to_double() * @math.PI * radius * radius / area
}

///|
pub fn isolation_probability(
  n : Int32,
  radius : Double,
  area : Double,
) -> Double {
  let p = 1.0 - @math.PI * radius * radius / area
  @math.pow(p, (n - 1).to_double())
}
