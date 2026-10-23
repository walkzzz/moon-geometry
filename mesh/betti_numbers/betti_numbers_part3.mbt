///|
/// Collect all edges from simplices (pairs of vertices). / 从单纯形中收集所有边（顶点对）。
fn collect_edges(simplices : Array[Array[Int]]) -> Array[(Int, Int)] {
  let edges : Array[(Int, Int)] = []
  for s in simplices {
    let n = s.length()
    for i in 0..<n {
      for j in (i + 1)..<n {
        let (lo, hi) = if s[i] < s[j] {
          (s[i], s[j])
        } else {
          (s[j], s[i])
        }
        let mut found = false
        for e in edges {
          if e.0 == lo && e.1 == hi {
            found = true
            break
          }
        }
        if !found {
          edges.push((lo, hi))
        }
      }
    }
  }
  edges
}
