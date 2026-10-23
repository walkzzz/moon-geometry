/// |
/// # Quadratic Programming
/// # 二次规划
///
/// Quadratic programming: minimize 1/2 x^T Q x + c^T x subject to A x <= b.
/// Uses unconstrained solver, equality-constrained KKT solver, and active-set method.
/// 二次规划：最小化 1/2 x^T Q x + c^T x，约束 A x <= b。
/// 使用无约束求解器、等式约束 KKT 求解器和活跃集方法。
///
/// ## Complexity: O(n^3) per KKT solve, O(iter * n^3) for active set
/// ## 复杂度: 每次 KKT 求解 O(n^3)，活跃集 O(iter * n^3)

///|
/// |
/// Solve a linear system A x = b via Gaussian elimination with partial pivoting.
/// 用部分主元高斯消元法求解线性方程组 A x = b。
pub fn solve_linear(
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
  for k in 1..<n {
    let i = n - k
    let mut s = m[i][n]
    for j in (i + 1)..<n {
      s -= m[i][j] * x[j]
    }
    x[i] = s / m[i][i]
  }
  if n > 0 {
    let mut s = m[0][n]
    for j in 1..<n {
      s -= m[0][j] * x[j]
    }
    x[0] = s / m[0][0]
  }
  Some(x)
}

///|
/// |
/// Solve unconstrained QP: minimize 1/2 x^T Q x + c^T x. Solution: Q x = -c.
/// 求解无约束二次规划。解：Q x = -c。
pub fn solve_unconstrained_qp(
  q : Array[Array[Double]],
  c : Array[Double],
  n : Int32,
) -> Array[Double]? {
  let neg_c : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    neg_c[i] = -c[i]
  }
  solve_linear(q, neg_c, n)
}

///|
/// |
/// Result of a quadratic program. / 二次规划结果。
pub struct QPResult {
  x : Array[Double]
  value : Double
  success : Bool
}

///|
/// |
/// Construct QP result. / 构造二次规划结果。
pub fn QPResult::new(
  x : Array[Double],
  value : Double,
  success : Bool,
) -> QPResult {
  { x, value, success, }
}

///|
/// |
/// Solve QP with inequality constraints A x <= b using active-set method.
/// 用活跃集方法求解带不等式约束 A x <= b 的二次规划。
pub fn active_set_qp(
  q : Array[Array[Double]],
  c : Array[Double],
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int32,
  max_iter : Int32,
) -> QPResult {
  let m_con = a.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let active : Array[Bool] = Array::make(m_con, false)
  for _ in 0..<max_iter {
    let active_idx : Array[Int32] = []
    for i in 0..<m_con {
      if active[i] {
        active_idx.push(i)
      }
    }
    let na = active_idx.length()
    let sz = n + na
    let kkt : Array[Array[Double]] = []
    for _ in 0..<sz {
      kkt.push(Array::make(sz, 0.0))
    }
    let rhs : Array[Double] = Array::make(sz, 0.0)
    for i in 0..<n {
      for j in 0..<n {
        kkt[i][j] = q[i][j]
      }
      rhs[i] = -c[i]
    }
    for k in 0..<na {
      let ci = active_idx[k]
      for j in 0..<n {
        kkt[n + k][j] = a[ci][j]
        kkt[j][n + k] = a[ci][j]
      }
      rhs[n + k] = b[ci]
    }
    let sol = solve_linear(kkt, rhs, n + na)
    let new_x : Array[Double] = Array::make(n, 0.0)
    match sol {
      Some(s) =>
        for i in 0..<n {
          new_x[i] = s[i]
        }
      None =>
        for i in 0..<n {
          new_x[i] = x[i]
        }
    }
    let mut all_feasible = true
    let mut worst_viol = -1
    let mut worst_val = 0.0000000001
    for i in 0..<m_con {
      if !active[i] {
        let mut val = -b[i]
        for j in 0..<n {
          val += a[i][j] * new_x[j]
        }
        if val > worst_val {
          worst_val = val
          worst_viol = i
        }
      }
    }
    if worst_viol >= 0 {
      active[worst_viol] = true
      all_feasible = false
    }
    if all_feasible {
      let mut remove_idx = -1
      let mut min_lam = -0.0000000001
      match sol {
        Some(s) =>
          for k in 0..<na {
            let lam = s[n + k]
            if lam < min_lam {
              min_lam = lam
              remove_idx = active_idx[k]
            }
          }
        None => ()
      }
      if remove_idx >= 0 {
        active[remove_idx] = false
      } else {
        for i in 0..<n {
          x[i] = new_x[i]
        }
        let mut val = 0.0
        for i in 0..<n {
          val += c[i] * x[i]
          for j in 0..<n {
            val += 0.5 * q[i][j] * x[i] * x[j]
          }
        }
        return { x, value: val, success: true, }
      }
    }
    for i in 0..<n {
      x[i] = new_x[i]
    }
  }
  let mut val = 0.0
  for i in 0..<n {
    val += c[i] * x[i]
    for j in 0..<n {
      val += 0.5 * q[i][j] * x[i] * x[j]
    }
  }
  { x, value: val, success: false, }
}

///|
/// |
/// Solve a 2D QP: minimize 1/2 x^T Q x + c^T x with box constraints lo <= x <= hi.
/// 求解二维二次规划，带盒约束 lo <= x <= hi。
pub fn qp_2d_box(
  q11 : Double,
  q12 : Double,
  q22 : Double,
  c1 : Double,
  c2 : Double,
  lo1 : Double,
  hi1 : Double,
  lo2 : Double,
  hi2 : Double,
) -> @core.Point2D {
  let q = [[q11, q12], [q12, q22]]
  let c = [c1, c2]
  let a = [[1.0, 0.0], [-1.0, 0.0], [0.0, 1.0], [0.0, -1.0]]
  let b = [hi1, -lo1, hi2, -lo2]
  let result = active_set_qp(q, c, a, b, 2, 100)
  @core.Point2D::new(result.x[0], result.x[1])
}

///|
/// |
/// Evaluate quadratic objective 1/2 x^T Q x + c^T x.
/// 计算二次目标函数值。
pub fn qp_objective(
  q : Array[Array[Double]],
  c : Array[Double],
  x : Array[Double],
  n : Int32,
) -> Double {
  let mut val = 0.0
  for i in 0..<n {
    val += c[i] * x[i]
    for j in 0..<n {
      val += 0.5 * q[i][j] * x[i] * x[j]
    }
  }
  val
}
