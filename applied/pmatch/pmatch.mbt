///|
/// Match points between two sets within a threshold (greedy). / 在阈值内贪心匹配两个点集。
pub fn point_match(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Array[(Int32, Int32)] {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return []
  }
  let matches : Array[(Int32, Int32)] = []
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

///|
/// Count matched points. / 计数匹配点数。
pub fn match_count(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Int32 {
  point_match(a, b, threshold).length()
}

///|
/// Match ratio (matched / min(|A|, |B|)). / 匹配比率。
pub fn match_ratio(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Double {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let count = match_count(a, b, threshold)
  let min_size = if n < m { n } else { m }
  count.to_double() / min_size.to_double()
}

///|
/// Unmatched points in set A. / A 中未匹配的点。
pub fn unmatched_a(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Int32 {
  a.length() - match_count(a, b, threshold)
}

///|
/// Unmatched points in set B. / B 中未匹配的点。
pub fn unmatched_b(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Int32 {
  let matches = point_match(a, b, threshold)
  b.length() - matches.length()
}
