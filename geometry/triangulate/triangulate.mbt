///|
/// Check if a triangle (a, b, c) is counter-clockwise (convex vertex).
/// 检查三角形 (a, b, c) 是否为逆时针（凸顶点）。
fn is_convex_vertex(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  @core.turn(a, b, c) > 0.0
}

///|
/// Check if point p is strictly inside triangle (a, b, c).
/// 检查点 p 是否严格在三角形 (a, b, c) 内部。
fn point_in_triangle(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(a, b, p)
  let d2 = @core.turn(b, c, p)
  let d3 = @core.turn(c, a, p)
  (d1 > 0.0 && d2 > 0.0 && d3 > 0.0) || (d1 < 0.0 && d2 < 0.0 && d3 < 0.0)
}

///|
/// Check if triangle (a, b, c) is an "ear" of the polygon:
/// convex vertex AND no other vertex lies inside the triangle.
/// 检查三角形 (a, b, c) 是否为多边形的"耳朵"：
/// 凸顶点且无其他顶点在三角形内部。
fn is_ear(
  vertices : Array[@core.Point2D],
  indices : Array[Int],
  prev_idx : Int,
  curr_idx : Int,
  next_idx : Int,
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
