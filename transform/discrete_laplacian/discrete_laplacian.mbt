///|
/// # Discrete Laplacian
/// # 离散 Laplace 算子
///
/// Discrete Laplace-Beltrami operator (cotangent weights, uniform weights).
/// 离散 Laplace-Beltrami 算子（余切权重、均匀权重）。

///|
pub fn uniform_laplacian(
  values : Array[Double],
  neighbors : Array[Double],
) -> Double {
  let n = neighbors.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum += neighbors[i] - values[0]
  }
  sum / n.to_double()
}

///|
pub fn cotangent_weight(cot_a : Double, cot_b : Double) -> Double {
  (cot_a + cot_b) / 2.0
}

///|
pub fn cotangent_laplacian(
  center_val : Double,
  neighbor_vals : Array[Double],
  weights : Array[Double],
) -> Double {
  let n = neighbor_vals.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  let mut total_w = 0.0
  for i in 0..<n {
    sum += weights[i] * (neighbor_vals[i] - center_val)
    total_w += weights[i]
  }
  if total_w.abs() < 0.000000000001 {
    0.0
  } else {
    sum / total_w
  }
}

///|
pub fn laplacian_eigenvalue(mode : Int32, area : Double) -> Double {
  if area < 0.000000000001 {
    return 0.0
  }
  mode.to_double() *
  mode.to_double() *
  3.141592653589793 *
  3.141592653589793 /
  area
}

///|
pub fn is_harmonic(laplacian_val : Double, tol : Double) -> Bool {
  laplacian_val.abs() < tol
}
