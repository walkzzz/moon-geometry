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
