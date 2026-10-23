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
