///|
/// Discriminant of a polynomial (ascending coefficients).
/// 多项式的判别式（升序系数）。
pub fn discriminant(coeffs : Array[Double]) -> Double {
  let n = poly_degree(coeffs)
  if n < 2 {
    return 0.0
  }
  let deriv : Array[Double] = []
  for i in 1..<coeffs.length() {
    deriv.push(coeffs[i] * i.to_double())
  }
  let r = resultant(coeffs, deriv)
  let lc = coeffs[n]
  let mut sign = 1.0
  if n % 2 == 0 {
    sign = -1.0
  }
  sign * r / lc
}
