///|
/// Solve n x n linear system via Gaussian elimination with partial pivoting.
/// 高斯消元法（部分选主元）解 n x n 线性方程组。
fn solve_linear(a : Array[Array[Double]], b : Array[Double]) -> Array[Double]? {
  let n = a.length()
  if n == 0 {
    return Some([])
  }
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
    for i in (col + 1)..<n {
      if m[i][col].abs() > max_val {
        max_val = m[i][col].abs()
        pivot = i
      }
    }
    if max_val < 0.000000000001 {
      return None
    }
    if pivot != col {
      let tmp = m[col]
      m[col] = m[pivot]
      m[pivot] = tmp
    }
    for i in (col + 1)..<n {
      let factor = m[i][col] / m[col][col]
      for j in col..<=n {
        m[i][j] = m[i][j] - factor * m[col][j]
      }
    }
  }
  let x : Array[Double] = Array::make(n, 0.0)
  let mut row = n - 1
  while row >= 0 {
    let mut s = m[row][n]
    for j in (row + 1)..<n {
      s = s - m[row][j] * x[j]
    }
    x[row] = s / m[row][row]
    row -= 1
  }
  Some(x)
}
