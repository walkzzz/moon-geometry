///|
/// # Eigenvalue Solver | 特征值求解器
/// Eigenvalue problem solver. / 特征值问题求解器。
///|
pub fn power_iteration(a : Array[Array[Double]], v : Array[Double], n_iter : Int) -> (Double, Array[Double]) {
  let n = v.length()
  let vec = []
  for i in 0..<n { vec.push(v[i]) }
  let mut lambda = 0.0
  for _ in 0..<n_iter {
    let new_vec = Array::make(n, 0.0)
    for i in 0..<n {
      for j in 0..<n {
        new_vec[i] += a[i][j] * vec[j]
      }
    }
    let mut norm = 0.0
    for i in 0..<n { norm += new_vec[i] * new_vec[i] }
    norm = norm.sqrt()
    if norm.abs() < 0.000000000001 { return (0.0, vec) }
    lambda = norm
    for i in 0..<n { vec[i] = new_vec[i] / norm }
  }
  (lambda, vec)
}
///|
pub fn rayleigh_quotient(a : Array[Array[Double]], v : Array[Double]) -> Double {
  let n = v.length()
  let mut num = 0.0; let mut den = 0.0
  for i in 0..<n {
    let mut av = 0.0
    for j in 0..<n { av += a[i][j] * v[j] }
    num += v[i] * av
    den += v[i] * v[i]
  }
  if den.abs() < 0.000000000001 { 0.0 } else { num / den }
}
///|
pub fn gershgorin_bounds(a : Array[Array[Double]]) -> (Double, Double) {
  let n = a.length()
  let mut lower = 999999.0; let mut upper = -999999.0
  for i in 0..<n {
    let mut r = 0.0
    for j in 0..<n {
      if i != j { r += a[i][j].abs() }
    }
    let lo = a[i][i] - r; let hi = a[i][i] + r
    if lo < lower { lower = lo }
    if hi > upper { upper = hi }
  }
  (lower, upper)
}
