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
