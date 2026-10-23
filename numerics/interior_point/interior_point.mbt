/// |
/// # Interior Point Method
/// # 内点法
///
/// Primal-dual path-following interior point method for LP: min c^T x s.t. A x <= b, x >= 0.
/// 线性规划的原始-对偶路径跟踪内点法：最小化 c^T x，约束 A x <= b, x >= 0。
///
/// ## Complexity: O(sqrt(n) * log(1/eps)) iterations, O(n^3) per iteration
/// ## 复杂度: O(sqrt(n) * log(1/eps)) 次迭代，每次迭代 O(n^3)

///|
/// |
/// Result of interior point LP. / 内点法线性规划结果。
pub struct IPResult {
  x : Array[Double]
  value : Double
  success : Bool
}

///|
/// |
/// Construct IP result. / 构造内点法结果。
pub fn IPResult::new(
  x : Array[Double],
  value : Double,
  success : Bool,
) -> IPResult {
  { x, value, success, }
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
/// Barrier interior point method: min c^T x s.t. A x = b, x >= 0.
/// 障碍内点法：最小化 c^T x，约束 A x = b, x >= 0。
fn barrier_solve(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  n : Int32,
  m : Int32,
  max_iter : Int32,
) -> Array[Double] {
  let x : Array[Double] = Array::make(n, 1.0)
  let mut mu = 1.0
  for _ in 0..<max_iter {
    for _ in 0..<20 {
      let h_inv : Array[Double] = Array::make(n, 0.0)
      for i in 0..<n {
        h_inv[i] = x[i] * x[i] / mu
      }
      let g : Array[Double] = Array::make(n, 0.0)
      for i in 0..<n {
        g[i] = c[i] - mu / x[i]
      }
      let ah_inv_at : Array[Array[Double]] = []
      for _ in 0..<m {
        ah_inv_at.push(Array::make(m, 0.0))
      }
      for i in 0..<m {
        for j in 0..<m {
          let mut s = 0.0
          for k in 0..<n {
            s += a[i][k] * h_inv[k] * a[j][k]
          }
          ah_inv_at[i][j] = s
        }
      }
      let rhs : Array[Double] = Array::make(m, 0.0)
      for i in 0..<m {
        let mut s = 0.0
        let mut ax = 0.0
        for k in 0..<n {
          s += a[i][k] * h_inv[k] * g[k]
          ax += a[i][k] * x[k]
        }
        rhs[i] = -s + (ax - b[i])
      }
      match solve_linear(ah_inv_at, rhs, m) {
        Some(dy) => {
          let dx : Array[Double] = Array::make(n, 0.0)
          for k in 0..<n {
            let mut s = -g[k]
            for i in 0..<m {
              s -= a[i][k] * dy[i]
            }
            dx[k] = h_inv[k] * s
          }
          let mut alpha = 1.0
          for k in 0..<n {
            if dx[k] < 0.0 {
              let bound = -0.99 * x[k] / dx[k]
              if bound < alpha {
                alpha = bound
              }
            }
          }
          for k in 0..<n {
            x[k] += alpha * dx[k]
          }
          let mut dx_norm = 0.0
          for k in 0..<n {
            dx_norm += dx[k] * dx[k]
          }
          if dx_norm < 0.0000000000000001 {
            break
          }
        }
        None => break
      }
    }
    mu *= 0.1
    if mu < 0.0000000001 {
      break
    }
  }
  x
}

///|
/// |
/// Interior point method for min c^T x s.t. A x <= b, x >= 0.
/// 内点法求解 min c^T x，约束 A x <= b, x >= 0。
pub fn interior_point(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int32,
) -> IPResult {
  let m = a.length()
  let n = c.length()
  if m == 0 || n == 0 {
    return { x: Array::make(n, 0.0), value: 0.0, success: true, }
  }
  let n_total = n + m
  let a_eq : Array[Array[Double]] = []
  for _ in 0..<m {
    a_eq.push(Array::make(n_total, 0.0))
  }
  for i in 0..<m {
    for j in 0..<n {
      a_eq[i][j] = a[i][j]
    }
    a_eq[i][n + i] = 1.0
  }
  let c_ext : Array[Double] = Array::make(n_total, 0.0)
  for j in 0..<n {
    c_ext[j] = c[j]
  }
  let x_full = barrier_solve(a_eq, b, c_ext, n_total, m, max_iter)
  let x : Array[Double] = Array::make(n, 0.0)
  for j in 0..<n {
    x[j] = x_full[j]
  }
  let mut value = 0.0
  for j in 0..<n {
    value += c[j] * x[j]
  }
  let mut feasible = true
  for i in 0..<m {
    let mut val = 0.0
    for j in 0..<n {
      val += a[i][j] * x[j]
    }
    if val > b[i] + 0.01 {
      feasible = false
    }
  }
  { x, value, success: feasible, }
}

///|
/// |
/// Maximize c^T x s.t. A x <= b, x >= 0 via interior point.
/// 内点法最大化 c^T x，约束 A x <= b, x >= 0。
pub fn interior_point_max(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int32,
) -> IPResult {
  let neg_c : Array[Double] = Array::make(c.length(), 0.0)
  for i in 0..<c.length() {
    neg_c[i] = -c[i]
  }
  let result = interior_point(a, b, neg_c, max_iter)
  { x: result.x, value: -result.value, success: result.success, }
}

///|
/// |
/// Compute duality gap for given primal x and dual (y, s).
/// 计算给定原始 x 和对偶 (y, s) 的对偶间隙。
pub fn duality_gap(x : Array[Double], s : Array[Double], n : Int32) -> Double {
  let mut gap = 0.0
  for i in 0..<n {
    gap += x[i] * s[i]
  }
  gap
}
