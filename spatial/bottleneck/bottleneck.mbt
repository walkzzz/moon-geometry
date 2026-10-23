///|
/// Bottleneck distance: min over all matchings of max pairwise distance. / 瓶颈距离：所有匹配中最大配对距离的最小值。
pub fn bottleneck_distance(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let dists : Array[Double] = []
  for pa in a {
    for pb in b {
      dists.push(pa.dist(pb))
    }
  }
  dists.sort()
  let k = if n < m { n } else { m }
  dists[k - 1]
}

///|
/// Check if bottleneck distance <= threshold. / 检查瓶颈距离是否 <= 阈值。
pub fn bottleneck_within(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Bool {
  bottleneck_distance(a, b) <= threshold
}

///|
/// Greedy bottleneck matching (returns matched pairs). / 贪心瓶颈匹配（返回匹配对）。
pub fn bottleneck_match(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Array[(Int32, Int32, Double)] {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return []
  }
  let pairs : Array[(Int32, Int32, Double)] = []
  let used_b : Array[Bool] = []
  for _ in 0..<m {
    used_b.push(false)
  }
  for i in 0..<n {
    let mut best_j = -1
    let mut best_d = 1.0 / 0.000000000001
    for j in 0..<m {
      if !used_b[j] {
        let d = a[i].dist(b[j])
        if d < best_d {
          best_d = d
          best_j = j
        }
      }
    }
    if best_j >= 0 {
      used_b[best_j] = true
      pairs.push((i, best_j, best_d))
    }
  }
  pairs
}

///|
/// Maximum pairwise distance in bottleneck matching. / 瓶颈匹配中最大配对距离。
pub fn bottleneck_max(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let pairs = bottleneck_match(a, b)
  let mut max_d = 0.0
  for (_, _, d) in pairs {
    if d > max_d {
      max_d = d
    }
  }
  max_d
}
