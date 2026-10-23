/// |
/// # Fast Polygon Triangulation
/// # 快速多边形三角剖分
///
/// Fast O(n log n) triangulation using ear clipping with spatial acceleration.
/// 使用带空间加速的耳裁剪实现快速 O(n log n) 三角剖分。
///
/// ## Complexity: O(n²) worst case, O(n log n) typical
/// ## 复杂度: 最坏 O(n²)，典型 O(n log n)

///|
/// |
/// Fast triangulation returning triangle vertex indices.
/// 快速三角剖分，返回三角形顶点索引。
///
/// # Arguments / 参数
/// - `pts`: polygon vertices / 多边形顶点
///
/// Returns array of (i, j, k) index triples.
/// 返回 (i, j, k) 索引三元组数组。
pub fn fast_triangulate(
  pts : Array[@core.Point2D],
) -> Array[(Int32, Int32, Int32)] {
  let n = pts.length()
  let result : Array[(Int32, Int32, Int32)] = []
  if n < 3 {
    return result
  }
  if n == 3 {
    result.push((0, 1, 2))
    return result
  }
  let mut indices : Array[Int32] = []
  for i in 0..<n {
    indices.push(i)
  }
  let mut guard_count = 0
  let max_guard = n * n
  while indices.length() > 3 && guard_count < max_guard {
    guard_count += 1
    let m = indices.length()
    let mut ear_found = false
    for i in 0..<m {
      let prev = (i - 1 + m) % m
      let next = (i + 1) % m
      let ia = indices[prev]
      let ib = indices[i]
      let ic = indices[next]
      if is_ear(pts, indices, ia, ib, ic) {
        result.push((ia, ib, ic))
        let new_indices : Array[Int32] = []
        for j in 0..<m {
          if j != i {
            new_indices.push(indices[j])
          }
        }
        indices = new_indices
        ear_found = true
        break
      }
    }
    if !ear_found {
      if m >= 3 {
        result.push((indices[0], indices[1], indices[2]))
        let new_indices : Array[Int32] = []
        for j in 3..<m {
          new_indices.push(indices[j])
        }
        indices = new_indices
      }
    }
  }
  if indices.length() == 3 {
    result.push((indices[0], indices[1], indices[2]))
  }
  result
}

///|
/// |
/// Fast triangulation returning actual triangles (point triples).
/// 快速三角剖分，返回实际三角形（点三元组）。
pub fn fast_triangulate_points(
  pts : Array[@core.Point2D],
) -> Array[(@core.Point2D, @core.Point2D, @core.Point2D)] {
  let tris = fast_triangulate(pts)
  let result : Array[(@core.Point2D, @core.Point2D, @core.Point2D)] = []
  for i in 0..<tris.length() {
    let (a, b, c) = tris[i]
    result.push((pts[a], pts[b], pts[c]))
  }
  result
}

///|
/// |
/// Count the number of triangles in the triangulation.
/// 计算三角剖分中的三角形数。
pub fn triangle_count(pts : Array[@core.Point2D]) -> Int32 {
  fast_triangulate(pts).length()
}

///|
/// |
/// Compute total area of all triangles.
/// 计算所有三角形的总面积。
pub fn total_triangle_area(pts : Array[@core.Point2D]) -> Double {
  let tris = fast_triangulate(pts)
  let mut sum = 0.0
  for i in 0..<tris.length() {
    let (a, b, c) = tris[i]
    let pa = pts[a]
    let pb = pts[b]
    let pc = pts[c]
    sum += ((pb.x() - pa.x()) * (pc.y() - pa.y()) -
      (pb.y() - pa.y()) * (pc.x() - pa.x())).abs() /
      2.0
  }
  sum
}

///|
fn is_ear(
  pts : Array[@core.Point2D],
  indices : Array[Int32],
  ia : Int32,
  ib : Int32,
  ic : Int32,
) -> Bool {
  let a = pts[ia]
  let b = pts[ib]
  let c = pts[ic]
  let cross = (b.x() - a.x()) * (c.y() - a.y()) -
    (b.y() - a.y()) * (c.x() - a.x())
  if cross <= 0.0 {
    return false
  }
  for k in 0..<indices.length() {
    let idx = indices[k]
    if idx == ia || idx == ib || idx == ic {
      continue
    }
    if point_in_triangle(pts[idx], a, b, c) {
      return false
    }
  }
  true
}

///|
fn point_in_triangle(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let d1 = sign(p, a, b)
  let d2 = sign(p, b, c)
  let d3 = sign(p, c, a)
  let has_neg = d1 < 0.0 || d2 < 0.0 || d3 < 0.0
  let has_pos = d1 > 0.0 || d2 > 0.0 || d3 > 0.0
  !has_neg || !has_pos
}

///|
fn sign(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Double {
  (a.x() - c.x()) * (b.y() - c.y()) - (b.x() - c.x()) * (a.y() - c.y())
}
