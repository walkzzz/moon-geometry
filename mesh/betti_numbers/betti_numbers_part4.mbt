///|
/// Count the maximum vertex index + 1. / 计算最大顶点索引 + 1。
fn count_vertices(simplices : Array[Array[Int32]]) -> Int32 {
  let mut max_v = -1
  for s in simplices {
    for v in s {
      if v > max_v {
        max_v = v
      }
    }
  }
  max_v + 1
}
