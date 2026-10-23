///|
/// Dynamic Time Warping distance between two polylines (DP). / 两条折线的 DTW 距离（动态规划）。
pub fn dtw_distance(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
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
      row.push(0.0)
    }
    dp.push(row)
  }
  dp[0][0] = c1[0].dist_sq(c2[0])
  for i in 1..<n {
    dp[i][0] = dp[i - 1][0] + c1[i].dist_sq(c2[0])
  }
  for j in 1..<m {
    dp[0][j] = dp[0][j - 1] + c1[0].dist_sq(c2[j])
  }
  for i in 1..<n {
    for j in 1..<m {
      let cost = c1[i].dist_sq(c2[j])
      let min_prev = if dp[i - 1][j] < dp[i][j - 1] {
        if dp[i - 1][j] < dp[i - 1][j - 1] {
          dp[i - 1][j]
        } else {
          dp[i - 1][j - 1]
        }
      } else if dp[i][j - 1] < dp[i - 1][j - 1] {
        dp[i][j - 1]
      } else {
        dp[i - 1][j - 1]
      }
      dp[i][j] = cost + min_prev
    }
  }
  dp[n - 1][m - 1].sqrt()
}
