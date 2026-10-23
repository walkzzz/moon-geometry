///| Compute the match ratio between two hash arrays. / 计算两个哈希数组的匹配率。
pub fn similarity_score(h1 : Array[Int], h2 : Array[Int]) -> Double {
  let mut match_count = 0
  let n = if h1.length() < h2.length() { h1.length() } else { h2.length() }
  for i in 0..<n {
    if h1[i] == h2[i] {
      match_count += 1
    }
  }
  match_count.to_double() / n.to_double()
}
