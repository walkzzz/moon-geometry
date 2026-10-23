///|
/// Check if triangle (a, b, c) is an "ear" of the polygon:
/// convex vertex AND no other vertex lies inside the triangle.
/// 检查三角形 (a, b, c) 是否为多边形的"耳朵"：
/// 凸顶点且无其他顶点在三角形内部。
fn is_ear(
  vertices : Array[@core.Point2D],
  indices : Array[Int32],
  prev_idx : Int32,
  curr_idx : Int32,
  next_idx : Int32,
) -> Bool {
  let a = vertices[indices[prev_idx]]
  let b = vertices[indices[curr_idx]]
  let c = vertices[indices[next_idx]]
  if !is_convex_vertex(a, b, c) {
    return false
  }
  let m = indices.length()
  for i in 0..<m {
    if i == prev_idx || i == curr_idx || i == next_idx {
      continue
    }
    let p = vertices[indices[i]]
    if point_in_triangle(p, a, b, c) {
      return false
    }
  }
  true
}
