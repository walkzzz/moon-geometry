/// |
/// # Simplex Method
/// # 单纯形法
///
/// Two-phase simplex method for linear programming: minimize c^T x subject to A x <= b, x >= 0.
/// 线性规划的两阶段单纯形法：最小化 c^T x，约束 A x <= b, x >= 0。
///
/// ## Complexity: O(iter * m * n) per iteration
/// ## 复杂度: 每次迭代 O(iter * m * n)

/// |
/// Result of simplex linear program. / 单纯形线性规划结果。
pub struct SimplexResult {
  x : Array[Double]
  value : Double
  success : Bool
}

/// |
/// Construct simplex result. / 构造单纯形结果。
pub fn SimplexResult::new(
  x : Array[Double],
  value : Double,
  success : Bool,
) -> SimplexResult {
  { x, value, success }
}

/// |
/// Core simplex tableau pivot on element (pivot_row, pivot_col).
/// 核心单纯形表旋转操作。
fn pivot(
  table : Array[Array[Double]],
  pivot_row : Int,
  pivot_col : Int,
  rows : Int,
  cols : Int,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for _ in 0..<rows {
    result.push(Array::make(cols, 0.0))
  }
  let piv = table[pivot_row][pivot_col]
  for j in 0..<cols {
    result[pivot_row][j] = table[pivot_row][j] / piv
  }
  for i in 0..<rows {
    if i != pivot_row {
      let factor = table[i][pivot_col]
      for j in 0..<cols {
        result[i][j] = table[i][j] - factor * result[pivot_row][j]
      }
    }
  }
  result
}

/// |
/// Simplex for min c^T x s.t. A x <= b, x >= 0, assuming b >= 0.
/// 单纯形法求解 min c^T x s.t. A x <= b, x >= 0，假设 b >= 0。
fn simplex_phase(
  table : Array[Array[Double]],
  n_vars : Int,
  n_slack : Int,
  max_iter : Int,
) -> (Array[Array[Double]], Bool) {
  let rows = table.length()
  let cols = n_vars + n_slack + 1
  let mut t = table
  let mut optimal = false
  for _ in 0..<max_iter {
    let obj_row = rows - 1
    let mut pivot_col = -1
    let mut min_val = -0.0000000001
    for j in 0..<(cols - 1) {
      if t[obj_row][j] < min_val {
        min_val = t[obj_row][j]
        pivot_col = j
      }
    }
    if pivot_col == -1 {
      optimal = true
      break
    }
    let mut pivot_row = -1
    let mut min_ratio = 0.0
    let mut found = false
    for i in 0..<obj_row {
      if t[i][pivot_col] > 0.0000000001 {
        let ratio = t[i][cols - 1] / t[i][pivot_col]
        if !found || ratio < min_ratio {
          min_ratio = ratio
          pivot_row = i
          found = true
        }
      }
    }
    if !found {
      break
    }
    t = pivot(t, pivot_row, pivot_col, rows, cols)
  }
  (t, optimal)
}

/// |
/// Two-phase simplex method: minimize c^T x subject to A x <= b, x >= 0.
/// 两阶段单纯形法：最小化 c^T x，约束 A x <= b, x >= 0。
pub fn simplex(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> SimplexResult {
  let m = a.length()
  let n = c.length()
  if m == 0 || n == 0 {
    return { x: Array::make(n, 0.0), value: 0.0, success: true }
  }
  let n_slack = m
  let cols = n + n_slack + 1
  let rows = m + 1
  let table : Array[Array[Double]] = []
  for _ in 0..<rows {
    table.push(Array::make(cols, 0.0))
  }
  for i in 0..<m {
    for j in 0..<n {
      table[i][j] = a[i][j]
    }
    table[i][n + i] = 1.0
    table[i][cols - 1] = b[i]
  }
  for j in 0..<n {
    table[m][j] = c[j]
  }
  let has_negative_b = {
    let mut neg = false
    for i in 0..<m {
      if b[i] < 0.0 {
        neg = true
      }
    }
    neg
  }
  if has_negative_b {
    return simplex_two_phase(a, b, c, n, m, max_iter)
  }
  let (t, optimal) = simplex_phase(table, n, n_slack, max_iter)
  if !optimal {
    return { x: Array::make(n, 0.0), value: 0.0, success: false }
  }
  let x = extract_solution(t, n, m, cols)
  let value = -t[m][cols - 1]
  { x, value, success: true }
}

/// |
/// Extract solution from simplex tableau.
/// 从单纯形表提取解。
fn extract_solution(
  table : Array[Array[Double]],
  n : Int,
  m : Int,
  cols : Int,
) -> Array[Double] {
  let x : Array[Double] = Array::make(n, 0.0)
  for j in 0..<n {
    let mut basic_row = -1
    let mut count = 0
    for i in 0..<m {
      if table[i][j].abs() > 0.0000001 {
        count += 1
        basic_row = i
      }
    }
    if count == 1 && basic_row >= 0 && table[basic_row][j].abs() > 0.01 {
      x[j] = table[basic_row][cols - 1] / table[basic_row][j]
    }
  }
  x
}

/// |
/// Two-phase simplex for problems with negative b values.
/// 处理 b 含负值的两阶段单纯形。
fn simplex_two_phase(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  n : Int,
  m : Int,
  max_iter : Int,
) -> SimplexResult {
  let n_slack = m
  let n_art = m
  let cols = n + n_slack + n_art + 1
  let rows = m + 1
  let table : Array[Array[Double]] = []
  for _ in 0..<rows {
    table.push(Array::make(cols, 0.0))
  }
  for i in 0..<m {
    let sign = if b[i] < 0.0 { -1.0 } else { 1.0 }
    for j in 0..<n {
      table[i][j] = sign * a[i][j]
    }
    table[i][n + i] = 1.0
    table[i][n + n_slack + i] = 1.0
    table[i][cols - 1] = sign * b[i]
  }
  for i in 0..<m {
    for j in 0..<cols {
      table[m][j] -= table[i][j]
    }
  }
  let (t1, _) = simplex_phase(table, n + n_slack, n_art, max_iter)
  let aux_obj = t1[m][cols - 1]
  if aux_obj < -0.0001 {
    return { x: Array::make(n, 0.0), value: 0.0, success: false }
  }
  let cols2 = n + n_slack + 1
  let table2 : Array[Array[Double]] = []
  for _ in 0..<rows {
    table2.push(Array::make(cols2, 0.0))
  }
  for i in 0..<m {
    for j in 0..<(n + n_slack) {
      table2[i][j] = t1[i][j]
    }
    table2[i][cols2 - 1] = t1[i][cols - 1]
  }
  for j in 0..<n {
    table2[m][j] = c[j]
  }
  for j in 0..<n {
    let mut basic_row = -1
    let mut count = 0
    for i in 0..<m {
      if t1[i][j].abs() > 0.0000000001 {
        count += 1
        basic_row = i
      }
    }
    if count == 1 && basic_row >= 0 {
      let factor = table2[m][j]
      for k in 0..<cols2 {
        table2[m][k] -= factor * table2[basic_row][k]
      }
    }
  }
  let (t2, optimal) = simplex_phase(table2, n, n_slack, max_iter)
  if !optimal {
    return { x: Array::make(n, 0.0), value: 0.0, success: false }
  }
  let x = extract_solution(t2, n, m, cols2)
  let value = -t2[m][cols2 - 1]
  { x, value, success: true }
}

/// |
/// Maximize c^T x subject to A x <= b, x >= 0.
/// 最大化 c^T x，约束 A x <= b, x >= 0。
pub fn simplex_max(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> SimplexResult {
  let neg_c : Array[Double] = Array::make(c.length(), 0.0)
  for i in 0..<c.length() {
    neg_c[i] = -c[i]
  }
  let result = simplex(a, b, neg_c, max_iter)
  { x: result.x, value: -result.value, success: result.success }
}