///|
/// Construct the Sylvester matrix of two polynomials.
/// Coefficients are in ascending order (coeffs[0] is constant term).
/// 构造两个多项式的 Sylvester 矩阵。系数升序排列（coeffs[0] 为常数项）。
pub fn sylvester_matrix(
  p : Array[Double],
  q : Array[Double],
) -> Array[Array[Double]] {
  let m = p.length() - 1
  let n = q.length() - 1
  let size = m + n
  let mat : Array[Array[Double]] = []
  for _ in 0..<size {
    let row : Array[Double] = []
    for _ in 0..<size {
      row.push(0.0)
    }
    mat.push(row)
  }
  for i in 0..<n {
    for j in 0..<p.length() {
      mat[i][i + j] = p[j]
    }
  }
  for i in 0..<m {
    for j in 0..<q.length() {
      mat[n + i][i + j] = q[j]
    }
  }
  mat
}
