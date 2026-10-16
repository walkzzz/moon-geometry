/// |
/// # Levenberg-Marquardt
/// # Levenberg-Marquardt 算法
///
/// Levenberg-Marquardt algorithm for nonlinear least squares: minimize sum r_i(x)^2.
/// 非线性最小二乘的 Levenberg-Marquardt 算法：最小化 sum r_i(x)^2。
///
/// ## Complexity: O(m * n^2 + n^3) per step (m residuals, n parameters)
/// ## 复杂度: 每步 O(m * n^2 + n^3)（m 个残差，n 个参数）

/// |
/// Result of Levenberg-Marquardt optimization. / Levenberg-Marquardt 优化结果。
pub struct LMResult {
  x : Array[Double]
  residual : Double
  iterations : Int
  success : Bool
}

/// |
/// Construct LM result. / 构造 LM 结果。
pub fn LMResult::new(
  x : Array[Double],
  residual : Double,
  iterations : Int,
  success : Bool,
) -> LMResult {
  { x, residual, iterations, success }
}

/// |
/// Compute sum of squared residuals. / 计算残差平方和。
fn residual_sq(r : Array[Double]) -> Double {
  let mut s = 0.0
  for i in 0..<r.length() {
    s += r[i] * r[i]
  }
  s
}

/// |
/// Solve linear system A x = b via Gaussian elimination.
/// 高斯消元法求解线性方程组。
fn solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
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

/// |
/// Levenberg-Marquardt with numerical Jacobian.
/// 使用数值雅可比矩阵的 Levenberg-Marquardt 算法。
pub fn levenberg_marquardt(
  residual : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  max_iter : Int,
) -> LMResult {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let mut lam = 0.001
  let r0 = residual(x)
  let mut cost = residual_sq(r0)
  let mut iter_done = 0
  for it in 0..<max_iter {
    iter_done = it + 1
    let r = residual(x)
    let m = r.length()
    let jac : Array[Array[Double]] = []
    for _ in 0..<m {
      jac.push(Array::make(n, 0.0))
    }
    let h = 0.0001
    for j in 0..<n {
      let xp : Array[Double] = Array::make(n, 0.0)
      let xm : Array[Double] = Array::make(n, 0.0)
      for k in 0..<n {
        xp[k] = x[k]
        xm[k] = x[k]
      }
      xp[j] += h
      xm[j] -= h
      let rp = residual(xp)
      let rm = residual(xm)
      for i in 0..<m {
        jac[i][j] = (rp[i] - rm[i]) / (2.0 * h)
      }
    }
    let a : Array[Array[Double]] = []
    for _ in 0..<n {
      a.push(Array::make(n, 0.0))
    }
    let g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      for j in 0..<n {
        let mut s = 0.0
        for k in 0..<m {
          s += jac[k][i] * jac[k][j]
        }
        a[i][j] = s
      }
      let mut s = 0.0
      for k in 0..<m {
        s += jac[k][i] * r[k]
      }
      g[i] = s
    }
    let a_damped : Array[Array[Double]] = []
    for i in 0..<n {
      let row : Array[Double] = Array::make(n, 0.0)
      for j in 0..<n {
        if i == j {
          row[j] = a[i][j] + lam * (1.0 + a[i][j].abs())
        } else {
          row[j] = a[i][j]
        }
      }
      a_damped.push(row)
    }
    let neg_g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      neg_g[i] = -g[i]
    }
    match solve_linear(a_damped, neg_g, n) {
      Some(d) => {
        let x_new : Array[Double] = Array::make(n, 0.0)
        for i in 0..<n {
          x_new[i] = x[i] + d[i]
        }
        let r_new = residual(x_new)
        let cost_new = residual_sq(r_new)
        if cost_new < cost {
          let improvement = cost - cost_new
          for i in 0..<n {
            x[i] = x_new[i]
          }
          cost = cost_new
          lam *= 0.5
          if lam < 0.0000000001 {
            lam = 0.0000000001
          }
          if improvement < 0.0000000000000001 {
            return { x, residual: cost, iterations: iter_done, success: true }
          }
        } else {
          lam *= 2.0
          if lam > 1000000000000.0 {
            return { x, residual: cost, iterations: iter_done, success: true }
          }
        }
      }
      None => {
        lam *= 10.0
      }
    }
  }
  { x, residual: cost, iterations: iter_done, success: false }
}

/// |
/// Levenberg-Marquardt with analytic Jacobian.
/// 使用解析雅可比矩阵的 Levenberg-Marquardt 算法。
pub fn levenberg_marquardt_jac(
  residual : (Array[Double]) -> Array[Double],
  jacobian : (Array[Double]) -> Array[Array[Double]],
  x0 : Array[Double],
  max_iter : Int,
) -> LMResult {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let mut lam = 0.001
  let r0 = residual(x)
  let mut cost = residual_sq(r0)
  let mut iter_done = 0
  for it in 0..<max_iter {
    iter_done = it + 1
    let r = residual(x)
    let jac = jacobian(x)
    let m = r.length()
    let a : Array[Array[Double]] = []
    for _ in 0..<n {
      a.push(Array::make(n, 0.0))
    }
    let g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      for j in 0..<n {
        let mut s = 0.0
        for k in 0..<m {
          s += jac[k][i] * jac[k][j]
        }
        a[i][j] = s
      }
      let mut s = 0.0
      for k in 0..<m {
        s += jac[k][i] * r[k]
      }
      g[i] = s
    }
    let a_damped : Array[Array[Double]] = []
    for i in 0..<n {
      let row : Array[Double] = Array::make(n, 0.0)
      for j in 0..<n {
        if i == j {
          row[j] = a[i][j] + lam * (1.0 + a[i][j].abs())
        } else {
          row[j] = a[i][j]
        }
      }
      a_damped.push(row)
    }
    let neg_g : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      neg_g[i] = -g[i]
    }
    match solve_linear(a_damped, neg_g, n) {
      Some(d) => {
        let x_new : Array[Double] = Array::make(n, 0.0)
        for i in 0..<n {
          x_new[i] = x[i] + d[i]
        }
        let cost_new = residual_sq(residual(x_new))
        if cost_new < cost {
          for i in 0..<n {
            x[i] = x_new[i]
          }
          cost = cost_new
          lam *= 0.5
          if lam < 0.0000000001 {
            lam = 0.0000000001
          }
        } else {
          lam *= 2.0
        }
      }
      None => lam *= 10.0
    }
  }
  { x, residual: cost, iterations: iter_done, success: false }
}

/// |
/// 2D curve fitting convenience: fit y = a + b*x to data points.
/// 二维曲线拟合便捷：拟合 y = a + b*x。
pub fn lm_line_fit(
  xs : Array[Double],
  ys : Array[Double],
) -> (Double, Double) {
  let residual = fn(p : Array[Double]) -> Array[Double] {
    let r : Array[Double] = Array::make(xs.length(), 0.0)
    for i in 0..<xs.length() {
      r[i] = p[0] + p[1] * xs[i] - ys[i]
    }
    r
  }
  let result = levenberg_marquardt(residual, [0.0, 0.0], 100)
  (result.x[0], result.x[1])
}
/// |
/// Root mean square error from residual sum of squares. / 拋差平方和的均方根误差。
///
/// RMS = sqrt(rss / n). / RMS = sqrt(rss / n)。
pub fn lm_rms_error(residual_sq : Double, n : Int) -> Double {
  if n <= 0 {
    return 0.0
  }
  (residual_sq / n.to_double()).sqrt()
}

/// |
/// Log of residual sum of squares for convergence monitoring.
/// 拋差平方和的自然对数，用于收敛监测。
///
/// Returns ln(rss + epsilon) to avoid log(0). / 返回 ln(rss + epsilon) 避免 log(0)。
pub fn lm_log_residual(residual_sq : Double) -> Double {
  @math.ln(residual_sq + 0.000000000000000000000000000001)
}