///|
/// # Boundary Element Method
/// # 边界元方法
///
/// BEM for boundary integral equations.
/// 边界积分方程的边界元方法。

///|
pub fn fundamental_solution_2d(r : Double) -> Double {
  if r < 0.000000000001 { 0.0 } else { -@math.ln(r) / (2.0 * 3.141592653589793) }
}

///|
pub fn boundary_integral_kernel(r : Double, normal_dist : Double) -> Double {
  if r < 0.000000000001 { return 0.0 }
  normal_dist / (2.0 * 3.141592653589793 * r * r)
}

///|
pub fn bem_matrix_entry(r : Double, weight : Double) -> Double {
  fundamental_solution_2d(r) * weight
}

///|
pub fn bem_solve(matrix : Array[Array[Double]], rhs : Array[Double]) -> Array[Double] {
  let n = rhs.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    if matrix[i][i].abs() > 0.000000000001 {
      result[i] = rhs[i] / matrix[i][i]
    }
  }
  result
}

///|
pub fn bem_error(exact : Array[Double], approx : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<exact.length() {
    let diff = exact[i] - approx[i]
    sum += diff * diff
  }
  sum.sqrt()
}
