///|
/// GCD of two polynomials via the Euclidean algorithm (ascending coefficients).
/// 通过欧几里得算法计算多项式最大公因式（升序系数）。
pub fn poly_gcd(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let eps = 0.0000000001
  let mut p = trim_zeros(a)
  let mut q = trim_zeros(b)
  while poly_degree(q) >= 0 {
    let r = poly_rem(p, q)
    p = q
    q = r
  }
  let d = poly_degree(p)
  if d < 0 {
    return [0.0]
  }
  let lc = p[d]
  if lc.abs() < eps {
    return p
  }
  let result : Array[Double] = []
  for i in 0..<(d + 1) {
    result.push(p[i] / lc)
  }
  result
}

fn poly_rem(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let da = poly_degree(a)
  let db = poly_degree(b)
  if db < 0 {
    return [0.0]
  }
  if da < db {
    return trim_zeros(a)
  }
  let r : Array[Double] = []
  for i in 0..<a.length() {
    r.push(a[i])
  }
  let lc_b = b[db]
  let mut i = da
  while i >= db {
    let factor = r[i] / lc_b
    r[i - db] -= factor * b[0]
    let mut j = 1
    while j <= db {
      if i - db + j < r.length() {
        r[i - db + j] -= factor * b[j]
      }
      j += 1
    }
    i -= 1
  }
  trim_zeros(r)
}
