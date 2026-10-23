///|
/// Compute rank of boundary matrix over Z/2Z via Gaussian elimination. / 通过高斯消元计算边界矩阵在 Z/2Z 上的秩。
fn matrix_rank(matrix : Array[Array[Int32]]) -> Int32 {
  let rows = matrix.length()
  if rows == 0 {
    return 0
  }
  let cols = matrix[0].length()
  if cols == 0 {
    return 0
  }
  let mat = Array::make(rows, Array::make(cols, 0))
  for i in 0..<rows {
    for j in 0..<cols {
      mat[i][j] = matrix[i][j]
    }
  }
  let mut rank = 0
  for col in 0..<cols {
    let mut pivot = -1
    for row in rank..<rows {
      if mat[row][col] == 1 {
        pivot = row
        break
      }
    }
    if pivot == -1 {
      continue
    }
    if pivot != rank {
      for j in 0..<cols {
        let tmp = mat[rank][j]
        mat[rank][j] = mat[pivot][j]
        mat[pivot][j] = tmp
      }
    }
    for row in 0..<rows {
      if row != rank && mat[row][col] == 1 {
        for j in 0..<cols {
          mat[row][j] = (mat[row][j] + mat[rank][j]) % 2
        }
      }
    }
    rank += 1
    if rank >= rows {
      break
    }
  }
  rank
}
