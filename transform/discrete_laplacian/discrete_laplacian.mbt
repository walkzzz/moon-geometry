///|
/// # Discrete Laplacian
/// # 离散 Laplace 算子
///
/// Discrete Laplace-Beltrami operator (cotangent weights, uniform weights).
/// 离散 Laplace-Beltrami 算子（余切权重、均匀权重）。


///|
pub fn uniform_laplacian(values : Array[Double], neighbors : Array[Double]) -> Double {
  let n = neighbors.length()
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    sum += neighbors[i] - values[0]
  }
  sum / n.to_double()
}
