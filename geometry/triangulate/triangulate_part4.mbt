///|
/// Triangulate a simple polygon using ear clipping.
/// Returns an array of vertex index triples `(i, j, k)`.
/// Each triple indexes into the original polygon vertices.
/// Uses the ear clipping algorithm: repeatedly find and remove "ears"
/// (convex vertices whose triangle contains no other polygon vertex).
///
/// 使用 ear clipping 算法对简单多边形进行三角剖分。
/// 返回顶点索引三元组数组 `(i, j, k)`。
/// 每个三元组是原始多边形的顶点索引。
/// 反复寻找并移除"耳朵"（凸顶点且其三角形内无其他多边形顶点）。
pub fn triangulate_polygon(poly : @core.Polygon) -> Array[(Int, Int, Int)] {
  let n = poly.size()
  let result : Array[(Int, Int, Int)] = []
  if n < 3 {
    return result
  }
  if n == 3 {
    result.push((0, 1, 2))
    return result
  }
  let vertices : Array[@core.Point2D] = []
  for i in 0..<n {
    vertices.push(poly.get(i))
  }
  let indices : Array[Int] = []
  for i in 0..<n {
    indices.push(i)
  }
  let mut m = n
  let mut safety = 0
  while m > 3 {
    let mut ear_found = false
    for i in 0..<m {
      let prev_idx = (i - 1 + m) % m
      let curr_idx = i
      let next_idx = (i + 1) % m
      if is_ear(vertices, indices, prev_idx, curr_idx, next_idx) {
        result.push((indices[prev_idx], indices[curr_idx], indices[next_idx]))
        ignore(indices.remove(curr_idx))
        m -= 1
        ear_found = true
        break
      }
    }
    if !ear_found {
      safety += 1
      if safety > n * n {
        return result
      }
    } else {
      safety = 0
    }
  }
  if m == 3 {
    result.push((indices[0], indices[1], indices[2]))
  }
  result
}
