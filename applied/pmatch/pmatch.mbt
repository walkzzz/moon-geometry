///|
/// Match points between two sets within a threshold (greedy). / 在阈值内贪心匹配两个点集。
pub fn point_match(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Array[(Int, Int)] {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return []
  }
  let matches : Array[(Int, Int)] = []
  let used_b : Array[Bool] = []
  for _ in 0..<m {
    used_b.push(false)
  }
  for i in 0..<n {
    let mut best_j = -1
    let mut best_d = threshold
    for j in 0..<m {
      if !used_b[j] {
        let d = a[i].dist(b[j])
        if d <= best_d {
          best_d = d
          best_j = j
        }
      }
    }
    if best_j >= 0 {
      used_b[best_j] = true
      matches.push((i, best_j))
    }
  }
  matches
}
