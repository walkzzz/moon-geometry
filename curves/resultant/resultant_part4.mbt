///|
/// Resultant of two polynomials (Sylvester determinant).
/// Coefficients in ascending order. / 两个多项式的结式（Sylvester 行列式），系数升序。
pub fn resultant(p : Array[Double], q : Array[Double]) -> Double {
  let m = poly_degree(p)
  let n = poly_degree(q)
  if m < 0 || n < 0 {
    return 0.0
  }
  if m == 0 && n == 0 {
    return 1.0
  }
  if m == 0 {
    let mut r = 1.0
    for _ in 0..<n {
      r *= p[0]
    }
    return r
  }
  if n == 0 {
    let mut r = 1.0
    for _ in 0..<m {
      r *= q[0]
    }
    return r
  }
  let pp = trim_zeros(p)
  let qq = trim_zeros(q)
  let sm = sylvester_matrix(pp, qq)
  matrix_determinant(sm)
}
