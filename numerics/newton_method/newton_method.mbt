/// |
/// # Newton's Method
/// # 牛顿法
///
/// Newton's method for optimization: 1D, multi-dimensional, with line search and trust region.
/// 优化牛顿法：一维、多维、带线搜索和信赖域。
///
/// ## Complexity: O(n^3) per step for multi-dimensional (Hessian solve)
/// ## 复杂度: 多维每步 O(n^3)（Hessian 求解）

///|
/// |
/// 1D Newton's method for finding f(x) = 0.
/// 一维牛顿法求根。
pub fn newton_1d(
  f : (Double) -> Double,
  fp : (Double) -> Double,
  x0 : Double,
  tol : Double,
  max_iter : Int32,
) -> Double {
  let mut x = x0
  for _ in 0..<max_iter {
    let fx = f(x)
    if fx.abs() < tol {
      return x
    }
    let fpx = fp(x)
    if fpx.abs() < 0.0000000000000001 {
      return x
    }
    x = x - fx / fpx
  }
  x
}

///|
/// |
/// Solve linear system A x = b via Gaussian elimination.
/// 高斯消元法求解线性方程组。
fn solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int32,
) -> Array[Double]? {
  let m : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(a[i][j])
    }
    row.push(b[i])
    m.push(row)
  }
  for col in 0..<n {
    let mut pivot = col
    let mut max_val = m[col][col].abs()
    for r in (col + 1)..<n {
      if m[r][col].abs() > max_val {
        max_val = m[r][col].abs()
        pivot = r
      }
    }
    if max_val < 0.0000000000000001 {
      return None
    }
    if pivot != col {
      let tmp = m[pivot]
      m[pivot] = m[col]
      m[col] = tmp
    }
    let piv = m[col][col]
    for r in (col + 1)..<n {
      let factor = m[r][col] / piv
      for c in col..<(n + 1) {
        m[r][c] -= factor * m[col][c]
      }
    }
  }
  let x : Array[Double] = Array::make(n, 0.0)
  for k in 0..<n {
    let i = n - 1 - k
    let mut s = m[i][n]
    for j in (i + 1)..<n {
      s -= m[i][j] * x[j]
    }
    x[i] = s / m[i][i]
  }
  Some(x)
}

///|
/// |
/// Multi-dimensional Newton's method for optimization.
/// 多维牛顿法优化：x = x - H^{-1} * grad。
pub fn newton_multi(
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  tol : Double,
  max_iter : Int32,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  for _ in 0..<max_iter {
    let g = grad(x)
    let mut norm_sq = 0.0
    for i in 0..<n {
      norm_sq += g[i] * g[i]
    }
    if norm_sq < tol * tol {
      break
    }
    let h = hess(x)
    let neg_g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      neg_g[i] = -g[i]
    }
    match solve_linear(h, neg_g, n) {
      Some(d) =>
        for i in 0..<n {
          x[i] += d[i]
        }
      None => break
    }
  }
  x
}

///|
/// |
/// Newton's method with backtracking line search.
/// 带回溯线搜索的牛顿法。
pub fn newton_line_search(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int32,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  for _ in 0..<max_iter {
    let g = grad(x)
    let mut norm_sq = 0.0
    for i in 0..<n {
      norm_sq += g[i] * g[i]
    }
    if norm_sq < 0.0000000000000001 {
      break
    }
    let h = hess(x)
    let neg_g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      neg_g[i] = -g[i]
    }
    let d = match solve_linear(h, neg_g, n) {
      Some(dd) => dd
      None => {
        for i in 0..<n {
          neg_g[i] = -g[i]
        }
        neg_g
      }
    }
    let mut alpha = 1.0
    let f0 = f(x)
    let mut slope = 0.0
    for i in 0..<n {
      slope += g[i] * d[i]
    }
    let x_new : Array[Double] = Array::make(n, 0.0)
    let mut accepted = false
    for _ in 0..<30 {
      for i in 0..<n {
        x_new[i] = x[i] + alpha * d[i]
      }
      if f(x_new) < f0 + 0.0001 * alpha * slope {
        accepted = true
        break
      }
      alpha *= 0.5
    }
    if !accepted {
      break
    }
    for i in 0..<n {
      x[i] = x[i] + alpha * d[i]
    }
  }
  x
}

///|
/// |
/// Trust region Newton's method.
/// 信赖域牛顿法。
pub fn newton_trust_region(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  hess : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_delta : Double,
  max_iter : Int32,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let mut delta = max_delta * 0.5
  for _ in 0..<max_iter {
    let g = grad(x)
    let mut norm_sq = 0.0
    for i in 0..<n {
      norm_sq += g[i] * g[i]
    }
    if norm_sq < 0.0000000000000001 {
      break
    }
    let h = hess(x)
    let neg_g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      neg_g[i] = -g[i]
    }
    let d = match solve_linear(h, neg_g, n) {
      Some(dd) => dd
      None => {
        for i in 0..<n {
          neg_g[i] = -g[i]
        }
        neg_g
      }
    }
    let mut d_norm = 0.0
    for i in 0..<n {
      d_norm += d[i] * d[i]
    }
    d_norm = d_norm.sqrt()
    if d_norm > delta {
      let scale = delta / d_norm
      for i in 0..<n {
        d[i] *= scale
      }
    }
    let f0 = f(x)
    let x_new : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      x_new[i] = x[i] + d[i]
    }
    let f1 = f(x_new)
    let mut pred = 0.0
    for i in 0..<n {
      pred += g[i] * d[i]
      for j in 0..<n {
        pred += 0.5 * h[i][j] * d[i] * d[j]
      }
    }
    let actual = f1 - f0
    if pred.abs() < 0.0000000000000001 {
      break
    }
    let ratio = actual / pred
    if ratio < 0.25 {
      delta *= 0.5
    } else if ratio > 0.75 && d_norm >= delta * 0.999 {
      delta = (2.0 * delta).min(max_delta)
    }
    if ratio > 0.0 {
      for i in 0..<n {
        x[i] = x_new[i]
      }
    }
  }
  x
}

///|
/// |
/// 2D Newton's method convenience wrapper.
/// 二维牛顿法便捷封装。
pub fn newton_2d(
  grad : (Double, Double) -> (Double, Double),
  hess : (Double, Double) -> ((Double, Double), (Double, Double)),
  x0 : Double,
  y0 : Double,
  max_iter : Int32,
) -> @core.Point2D {
  let g_wrap = fn(x : Array[Double]) -> Array[Double] {
    let (gx, gy) = grad(x[0], x[1])
    [gx, gy]
  }
  let h_wrap = fn(x : Array[Double]) -> Array[Array[Double]] {
    let ((h11, h12), (h21, h22)) = hess(x[0], x[1])
    [[h11, h12], [h21, h22]]
  }
  let result = newton_multi(g_wrap, h_wrap, [x0, y0], 0.0000000001, max_iter)
  @core.Point2D::new(result[0], result[1])
}
