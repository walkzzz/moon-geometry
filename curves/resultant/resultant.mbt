///|
/// # Resultant Computation
/// # 结式计算
///
/// Resultant via Sylvester matrix determinant for polynomial elimination.
/// 通过 Sylvester 矩阵行列式计算结式，用于多项式消元。

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

///|
/// Determinant of a square matrix via LU decomposition with partial pivoting.
/// 通过带部分主元的 LU 分解计算方阵行列式。
pub fn matrix_determinant(mat : Array[Array[Double]]) -> Double {
  let n = mat.length()
  if n == 0 {
    return 1.0
  }
  let a : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(mat[i][j])
    }
    a.push(row)
  }
  let mut det = 1.0
  for k in 0..<n {
    let mut pivot = k
    let mut max_val = a[k][k].abs()
    for i in (k + 1)..<n {
      if a[i][k].abs() > max_val {
        max_val = a[i][k].abs()
        pivot = i
      }
    }
    if max_val < 0.0000000000000001 {
      return 0.0
    }
    if pivot != k {
      let tmp = a[k]
      a[k] = a[pivot]
      a[pivot] = tmp
      det = -det
    }
    det *= a[k][k]
    for i in (k + 1)..<n {
      let factor = a[i][k] / a[k][k]
      for j in k..<n {
        a[i][j] -= factor * a[k][j]
      }
    }
  }
  det
}

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

///|
/// Degree of a polynomial (highest non-zero coefficient index), -1 if zero.
/// 多项式次数（最高非零系数索引），零多项式返回 -1。
pub fn poly_degree(coeffs : Array[Double]) -> Int32 {
  let eps = 0.0000000000000001
  let mut d = coeffs.length() - 1
  while d >= 0 && coeffs[d].abs() < eps {
    d -= 1
  }
  d
}

///|
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

///|
/// Subtract two polynomials (ascending). / 两个多项式相减（升序）。
pub fn poly_sub(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() > b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    let av = if i < a.length() { a[i] } else { 0.0 }
    let bv = if i < b.length() { b[i] } else { 0.0 }
    result.push(av - bv)
  }
  result
}

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

///|
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

///|
/// Check if two polynomials share a common root (resultant is zero).
/// 检查两个多项式是否有公共根（结式为零）。
pub fn have_common_root(
  p : Array[Double],
  q : Array[Double],
  eps : Double,
) -> Bool {
  resultant(p, q).abs() < eps
}
