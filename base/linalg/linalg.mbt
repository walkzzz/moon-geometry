/// |
/// # Linear Algebra
/// # 线性代数
///
/// Solve linear systems using Gaussian elimination.
/// 使用高斯消元法求解线性方程组。
///
/// ## Complexity: O(n³)
/// ## 复杂度: O(n³)

///|
/// |
/// Solve linear system Ax = b using Gaussian elimination.
/// 使用高斯消元法求解 Ax = b。
///
/// # Arguments / 参数
/// - `a`: n × n coefficient matrix / n × n 系数矩阵
/// - `b`: right-hand side / 右端项
/// - `n`: system size / 系统大小
///
/// Returns solution vector, or empty array if singular.
/// 返回解向量，奇异则返回空数组。
pub fn solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int32,
) -> Array[Double] {
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
    for row in (col + 1)..<n {
      if m[row][col].abs() > m[pivot][col].abs() {
        pivot = row
      }
    }
    if m[pivot][col].abs() < 0.0000000001 {
      return []
    }
    if pivot != col {
      let tmp = m[pivot]
      m[pivot] = m[col]
      m[col] = tmp
    }
    for row in (col + 1)..<n {
      let factor = m[row][col] / m[col][col]
      for j in col..<=n {
        m[row][j] -= factor * m[col][j]
      }
    }
  }
  let x : Array[Double] = []
  for _ in 0..<n {
    x.push(0.0)
  }
  let mut i = n - 1
  while i >= 0 {
    let mut sum = m[i][n]
    for j in (i + 1)..<n {
      sum -= m[i][j] * x[j]
    }
    x[i] = sum / m[i][i]
    i -= 1
  }
  x
}

///|
/// |
/// Compute matrix determinant.
/// 计算矩阵行列式。
pub fn determinant(a : Array[Array[Double]], n : Int32) -> Double {
  let m : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(a[i][j])
    }
    m.push(row)
  }
  let mut det = 1.0
  for col in 0..<n {
    let mut pivot = col
    for row in (col + 1)..<n {
      if m[row][col].abs() > m[pivot][col].abs() {
        pivot = row
      }
    }
    if m[pivot][col].abs() < 0.0000000001 {
      return 0.0
    }
    if pivot != col {
      let tmp = m[pivot]
      m[pivot] = m[col]
      m[col] = tmp
      det = -det
    }
    det *= m[col][col]
    for row in (col + 1)..<n {
      let factor = m[row][col] / m[col][col]
      for j in col..<n {
        m[row][j] -= factor * m[col][j]
      }
    }
  }
  det
}

///|
/// |
/// Compute matrix inverse.
/// 计算矩阵逆。
pub fn matrix_inverse(
  a : Array[Array[Double]],
  n : Int32,
) -> Array[Array[Double]]? {
  let det = determinant(a, n)
  if det.abs() < 0.0000000001 {
    return None
  }
  let result : Array[Array[Double]] = []
  for col in 0..<n {
    let e : Array[Double] = []
    for i in 0..<n {
      e.push(if i == col { 1.0 } else { 0.0 })
    }
    let x = solve_linear(a, e, n)
    result.push(x)
  }
  let inv : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(result[j][i])
    }
    inv.push(row)
  }
  Some(inv)
}
