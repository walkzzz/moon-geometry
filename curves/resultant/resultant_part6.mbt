///|
/// Degree of a polynomial (highest non-zero coefficient index), -1 if zero.
/// 多项式次数（最高非零系数索引），零多项式返回 -1。
pub fn poly_degree(coeffs : Array[Double]) -> Int {
  let eps = 0.0000000000000001
  let mut d = coeffs.length() - 1
  while d >= 0 && coeffs[d].abs() < eps {
    d -= 1
  }
  d
}

fn trim_zeros(coeffs : Array[Double]) -> Array[Double] {
  let d = poly_degree(coeffs)
  if d < 0 {
    return [0.0]
  }
  let result : Array[Double] = []
  for i in 0..<(d + 1) {
    result.push(coeffs[i])
  }
  result
}
