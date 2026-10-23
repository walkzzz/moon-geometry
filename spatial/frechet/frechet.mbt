///|
/// Discrete Fréchet distance between two polylines (DP algorithm). / 两条折线的离散 Fréchet 距离（动态规划）。
pub fn frechet_distance(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
) -> Double {
  let n = c1.length()
  let m = c2.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  if n == 1 && m == 1 {
    return c1[0].dist(c2[0])
  }
  let dp : Array[Array[Double]] = []
  for _ in 0..<n {
    let row : Array[Double] = []
    for _ in 0..<m {
      row.push(-1.0)
    }
    dp.push(row)
  }
  frechet_dp(c1, c2, n - 1, m - 1, dp)
}

fn frechet_dp(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
  i : Int,
  j : Int,
  dp : Array[Array[Double]],
) -> Double {
  if dp[i][j] >= 0.0 {
    return dp[i][j]
  }
  let d = c1[i].dist(c2[j])
  let mut result = d
  if i == 0 && j == 0 {
    result = d
  } else if i > 0 && j == 0 {
    let prev = frechet_dp(c1, c2, i - 1, j, dp)
    result = if d > prev { d } else { prev }
  } else if i == 0 && j > 0 {
    let prev = frechet_dp(c1, c2, i, j - 1, dp)
    result = if d > prev { d } else { prev }
  } else {
    let a = frechet_dp(c1, c2, i - 1, j, dp)
    let b = frechet_dp(c1, c2, i, j - 1, dp)
    let c = frechet_dp(c1, c2, i - 1, j - 1, dp)
    let min_prev = if a < b { if a < c { a } else { c } } else { if b < c { b } else { c } }
    result = if d > min_prev { d } else { min_prev }
  }
  dp[i][j] = result
  result
}
