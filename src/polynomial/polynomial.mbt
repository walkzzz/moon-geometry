/// |
/// # Polynomial Operations
/// # 多项式运算
///
/// Polynomial evaluation, arithmetic, and root finding.
/// 多项式求值、运算和求根。
///
/// ## Complexity: O(n) for evaluation
/// ## 复杂度: 求值 O(n)

/// |
/// Evaluate polynomial at x. Coefficients in ascending order.
/// 在 x 处求值多项式。系数升序排列。
pub fn poly_eval(coeffs : Array[Double], x : Double) -> Double {
  let n = coeffs.length()
  if n == 0 {
    return 0.0
  }
  let mut result = coeffs[n - 1]
  let mut i = n - 2
  while i >= 0 {
    result = result * x + coeffs[i]
    i -= 1
  }
  result
}

/// |
/// Compute derivative polynomial.
/// 计算导数多项式。
pub fn poly_derivative(coeffs : Array[Double]) -> Array[Double] {
  let n = coeffs.length()
  if n <= 1 {
    return [0.0]
  }
  let result : Array[Double] = []
  for i in 1..<n {
    result.push(coeffs[i] * i.to_double())
  }
  result
}

/// |
/// Add two polynomials.
/// 两个多项式相加。
pub fn poly_add(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() > b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    let av = if i < a.length() { a[i] } else { 0.0 }
    let bv = if i < b.length() { b[i] } else { 0.0 }
    result.push(av + bv)
  }
  result
}

/// |
/// Multiply two polynomials.
/// 两个多项式相乘。
pub fn poly_mul(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = a.length() + b.length() - 1
  let result : Array[Double] = []
  for _ in 0..<n {
    result.push(0.0)
  }
  for i in 0..<a.length() {
    for j in 0..<b.length() {
      result[i + j] += a[i] * b[j]
    }
  }
  result
}

/// |
/// Find real roots using companion matrix eigenvalues (simplified).
/// 使用简化方法查找实根。
pub fn poly_roots(coeffs : Array[Double]) -> Array[Double] {
  let n = coeffs.length()
  if n <= 1 {
    return []
  }
  let mut degree = n - 1
  while degree > 0 && coeffs[degree].abs() < 0.0000000001 {
    degree -= 1
  }
  if degree <= 0 {
    return []
  }
  if degree == 1 {
    return [-coeffs[0] / coeffs[1]]
  }
  if degree == 2 {
    let a = coeffs[2]
    let b = coeffs[1]
    let c = coeffs[0]
    let disc = b * b - 4.0 * a * c
    if disc < 0.0 {
      return []
    }
    let sq = disc.sqrt()
    return [(-b + sq) / (2.0 * a), (-b - sq) / (2.0 * a)]
  }
  let roots : Array[Double] = []
  let mut x = -100.0
  let step = 0.01
  while x < 100.0 {
    let fx = poly_eval(coeffs, x)
    let fx2 = poly_eval(coeffs, x + step)
    if fx * fx2 <= 0.0 && fx.abs() > 0.0000000001 {
      let mut lo = x
      let mut hi = x + step
      for _ in 0..<50 {
        let mid = (lo + hi) / 2.0
        let fm = poly_eval(coeffs, mid)
        if fm * fx < 0.0 {
          hi = mid
        } else {
          lo = mid
        }
      }
      roots.push((lo + hi) / 2.0)
    }
    x += step
  }
  roots
}