///|
/// Check if simplex a is a face of simplex b (subset of vertices). / 检查单纯形 a 是否为单纯形 b 的面（顶点子集）。
fn is_face(a : Array[Int], b : Array[Int]) -> Bool {
  if a.length() != b.length() - 1 {
    return false
  }
  for v in a {
    let mut found = false
    for w in b {
      if v == w {
        found = true
        break
      }
    }
    if !found {
      return false
    }
  }
  true
}
