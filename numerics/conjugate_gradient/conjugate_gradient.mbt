/// |
/// # Conjugate Gradient
/// # 共轭梯度法
///
/// Conjugate gradient for linear systems (CG, preconditioned CG) and nonlinear optimization.
/// 线性方程组的共轭梯度法（CG、预处理 CG）及非线性优化共轭梯度。
///
/// ## Complexity: O(n^2) per iteration (matrix-vector product)
/// ## 复杂度: 每次迭代 O(n^2)（矩阵向量乘）

///|
/// |
/// Matrix-vector product. / 矩阵向量乘。
fn mat_vec(
  a : Array[Array[Double]],
  v : Array[Double],
  n : Int32,
) -> Array[Double] {
  let r : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let mut s = 0.0
    for j in 0..<n {
      s += a[i][j] * v[j]
    }
    r[i] = s
  }
  r
}

///|
/// |
/// Dot product. / 点积。
fn dot(a : Array[Double], b : Array[Double], n : Int32) -> Double {
  let mut s = 0.0
  for i in 0..<n {
    s += a[i] * b[i]
  }
  s
}

///|
/// |
/// Conjugate gradient for solving A x = b (A symmetric positive definite).
/// 共轭梯度法求解 A x = b（A 对称正定）。
pub fn cg_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  x0 : Array[Double],
  max_iter : Int32,
) -> Array[Double] {
  let n = b.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let ax = mat_vec(a, x, n)
  let r : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    r[i] = b[i] - ax[i]
  }
  let p : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    p[i] = r[i]
  }
  let mut rsold = dot(r, r, n)
  if rsold < 0.0000000000000001 {
    return x
  }
  for _ in 0..<max_iter {
    let ap = mat_vec(a, p, n)
    let pap = dot(p, ap, n)
    if pap.abs() < 0.0000000000000001 {
      break
    }
    let alpha = rsold / pap
    for i in 0..<n {
      x[i] += alpha * p[i]
      r[i] -= alpha * ap[i]
    }
    let rsnew = dot(r, r, n)
    if rsnew < 0.0000000000000001 {
      break
    }
    let beta = rsnew / rsold
    for i in 0..<n {
      p[i] = r[i] + beta * p[i]
    }
    rsold = rsnew
  }
  x
}

///|
/// |
/// Preconditioned conjugate gradient. M_inv applies the inverse of preconditioner M.
/// 预处理共轭梯度法。M_inv 施加预处理矩阵 M 的逆。
pub fn pcg_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  m_inv : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int32,
) -> Array[Double] {
  let n = b.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let ax = mat_vec(a, x, n)
  let r : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    r[i] = b[i] - ax[i]
  }
  let z = m_inv(r)
  let p : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    p[i] = z[i]
  }
  let mut rsold = dot(r, z, n)
  if rsold < 0.0000000000000001 {
    return x
  }
  for _ in 0..<max_iter {
    let ap = mat_vec(a, p, n)
    let pap = dot(p, ap, n)
    if pap.abs() < 0.0000000000000001 {
      break
    }
    let alpha = rsold / pap
    for i in 0..<n {
      x[i] += alpha * p[i]
      r[i] -= alpha * ap[i]
    }
    let z_new = m_inv(r)
    let rsnew = dot(r, z_new, n)
    if rsnew < 0.0000000000000001 {
      break
    }
    let beta = rsnew / rsold
    for i in 0..<n {
      p[i] = z_new[i] + beta * p[i]
    }
    rsold = rsnew
  }
  x
}

///|
/// |
/// Nonlinear conjugate gradient (Polak-Ribiere) for optimization.
/// 非线性共轭梯度法（Polak-Ribiere）用于优化。
pub fn nonlinear_cg(
  f : (Array[Double]) -> Double,
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int32,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let g = grad(x)
  let p : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    p[i] = -g[i]
  }
  let mut gnorm_sq = dot(g, g, n)
  if gnorm_sq < 0.0000000000000001 {
    return x
  }
  for _ in 0..<max_iter {
    let mut alpha = 1.0
    let f0 = f(x)
    let mut slope = 0.0
    for i in 0..<n {
      slope += g[i] * p[i]
    }
    if slope >= 0.0 {
      for i in 0..<n {
        p[i] = -g[i]
      }
      for i in 0..<n {
        slope += g[i] * p[i]
      }
    }
    let x_new : Array[Double] = Array::make(n, 0.0)
    let mut accepted = false
    for _ in 0..<30 {
      for i in 0..<n {
        x_new[i] = x[i] + alpha * p[i]
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
      x[i] = x[i] + alpha * p[i]
    }
    let g_new = grad(x)
    let gnew_norm_sq = dot(g_new, g_new, n)
    if gnew_norm_sq < 0.0000000000000001 {
      break
    }
    let mut num = 0.0
    for i in 0..<n {
      num += g_new[i] * (g_new[i] - g[i])
    }
    let beta = num / gnorm_sq
    let beta_pos = if beta > 0.0 { beta } else { 0.0 }
    for i in 0..<n {
      p[i] = -g_new[i] + beta_pos * p[i]
    }
    for i in 0..<n {
      g[i] = g_new[i]
    }
    gnorm_sq = gnew_norm_sq
  }
  x
}

///|
/// |
/// 2D nonlinear CG convenience wrapper.
/// 二维非线性共轭梯度便捷封装。
pub fn nonlinear_cg_2d(
  f : (Double, Double) -> Double,
  grad : (Double, Double) -> (Double, Double),
  x0 : Double,
  y0 : Double,
  max_iter : Int32,
) -> @core.Point2D {
  let f_wrap = fn(x : Array[Double]) -> Double { f(x[0], x[1]) }
  let g_wrap = fn(x : Array[Double]) -> Array[Double] {
    let (gx, gy) = grad(x[0], x[1])
    [gx, gy]
  }
  let result = nonlinear_cg(f_wrap, g_wrap, [x0, y0], max_iter)
  @core.Point2D::new(result[0], result[1])
}

///|
/// |
/// Jacobi preconditioner: M = diag(A), M_inv applies 1/diag.
/// Jacobi 预处理：M = diag(A)，M_inv 施加 1/对角。
pub fn jacobi_preconditioner(
  a : Array[Array[Double]],
  n : Int32,
) -> (Array[Double]) -> Array[Double] {
  let diag : Array[Double] = Array::make(n, 1.0)
  for i in 0..<n {
    if a[i][i].abs() > 0.0000000000000001 {
      diag[i] = 1.0 / a[i][i]
    }
  }
  fn(r : Array[Double]) -> Array[Double] {
    let z : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      z[i] = diag[i] * r[i]
    }
    z
  }
}
