///|
/// Hungarian (Kuhn-Munkres) algorithm for minimum-cost assignment.
/// 匈牙利（Kuhn-Munkres）算法求最小代价指派。
///
/// # Arguments / 参数
/// - `cost`: cost matrix (rows x cols) / 代价矩阵（行 x 列）
///
/// Returns array of length = rows, where result[i] = assigned column index,
/// or -1 if row i is unassigned (matrix was padded). / 返回长度为行数的数组，
/// result[i] 为指派的列索引，未指派时为 -1。
pub fn hungarian(cost : Array[Array[Double]]) -> Array[Int] {
  let n = cost.length()
  if n == 0 {
    return []
  }
  let m = cost[0].length()
  let sz = if n > m { n } else { m }
  let a : Array[Array[Double]] = []
  for _ in 0..=(sz) {
    a.push(Array::make(sz + 1, inf_val))
  }
  for i in 1..=sz {
    for j in 1..=sz {
      if i - 1 < n && j - 1 < m {
        a[i][j] = cost[i - 1][j - 1]
      }
    }
  }
  let u : Array[Double] = Array::make(sz + 1, 0.0)
  let v : Array[Double] = Array::make(sz + 1, 0.0)
  let p : Array[Int] = Array::make(sz + 1, 0)
  let way : Array[Int] = Array::make(sz + 1, 0)
  for i in 1..=sz {
    p[0] = i
    let mut j0 = 0
    let minv : Array[Double] = Array::make(sz + 1, inf_val)
    let used : Array[Bool] = Array::make(sz + 1, false)
    while true {
      used[j0] = true
      let i0 = p[j0]
      let mut delta = inf_val
      let mut j1 = -1
      for j in 1..=sz {
        if !used[j] {
          let cur = a[i0][j] - u[i0] - v[j]
          if cur < minv[j] {
            minv[j] = cur
            way[j] = j0
          }
          if minv[j] < delta {
            delta = minv[j]
            j1 = j
          }
        }
      }
      for j in 0..=sz {
        if used[j] {
          u[p[j]] = u[p[j]] + delta
          v[j] = v[j] - delta
        } else {
          minv[j] = minv[j] - delta
        }
      }
      j0 = j1
      if j0 < 0 {
        j0 = 0
        break
      }
      if p[j0] == 0 {
        break
      }
    }
    while j0 != 0 {
      let j1 = way[j0]
      p[j0] = p[j1]
      j0 = j1
    }
  }
  let result : Array[Int] = Array::make(n, -1)
  for j in 1..=sz {
    let row = p[j]
    if row > 0 && row - 1 < n && j - 1 < m {
      result[row - 1] = j - 1
    }
  }
  result
}
