///|
/// Check if interpolation nodes are distinct. / 检查插值节点是否互异。
pub fn lagrange_nodes_distinct(xs : Array[Double]) -> Bool {
  let n = xs.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if (xs[i] - xs[j]).abs() < 0.000000000001 {
        return false
      }
    }
  }
  true
}
