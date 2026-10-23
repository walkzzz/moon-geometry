///|
/// DTW with window constraint (Sakoe-Chiba band). / 带窗口约束的 DTW。
pub fn dtw_windowed(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
  window : Int,
) -> Double {
  let n = c1.length()
  let m = c2.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let dp : Array[Array[Double]] = []
  for _ in 0..<n {
    let row : Array[Double] = []
    for _ in 0..<m {
      row.push(1.0 / 0.000000000001)
    }
    dp.push(row)
  }
  dp[0][0] = c1[0].dist_sq(c2[0])
  for i in 1..<n {
    for j in 0..<m {
      if (i - j).abs() > window {
        continue
      }
      let cost = c1[i].dist_sq(c2[j])
      let mut min_prev = dp[i - 1][j]
      if j > 0 && dp[i][j - 1] < min_prev {
        min_prev = dp[i][j - 1]
      }
      if j > 0 && dp[i - 1][j - 1] < min_prev {
        min_prev = dp[i - 1][j - 1]
      }
      dp[i][j] = cost + min_prev
    }
  }
  dp[n - 1][m - 1].sqrt()
}
