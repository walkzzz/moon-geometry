///|
/// Check if vertex i is an ear of the polygon (triangle prev-curr-next is inside and contains no other vertex). / 检查顶点 i 是否为多边形的耳（三角形 prev-curr-next 在内部且不含其他顶点）。
pub fn is_ear(
  poly : Array[@core.Point2D],
  indices : Array[Int32],
  i : Int32,
) -> Bool {
  let n = indices.length()
  if n < 3 {
    return false
  }
  let idx = indices[i]
  let prev_idx = indices[(i - 1 + n) % n]
  let next_idx = indices[(i + 1) % n]
  let prev = poly[prev_idx]
  let curr = poly[idx]
  let next = poly[next_idx]
  let cross = (curr.x() - prev.x()) * (next.y() - curr.y()) -
    (curr.y() - prev.y()) * (next.x() - curr.x())
  if cross <= 0.0 {
    return false
  }
  let eps = 0.000000000001
  for k in 0..<n {
    let vi = indices[k]
    if vi == prev_idx || vi == idx || vi == next_idx {
      continue
    }
    let p = poly[vi]
    let d1 = (curr.x() - prev.x()) * (p.y() - prev.y()) -
      (curr.y() - prev.y()) * (p.x() - prev.x())
    let d2 = (next.x() - curr.x()) * (p.y() - curr.y()) -
      (next.y() - curr.y()) * (p.x() - curr.x())
    let d3 = (prev.x() - next.x()) * (p.y() - next.y()) -
      (prev.y() - next.y()) * (p.x() - next.x())
    if d1 > eps && d2 > eps && d3 > eps {
      return false
    }
  }
  true
}

///|
/// Find an ear vertex index. / 找到一个耳顶点索引。
pub fn find_ear(poly : Array[@core.Point2D], indices : Array[Int32]) -> Int32? {
  let n = indices.length()
  if n < 3 {
    return None
  }
  for i in 0..<n {
    if is_ear(poly, indices, i) {
      return Some(i)
    }
  }
  None
}

///|
/// Triangulate a simple polygon using ear clipping. / 使用耳裁剪法三角剖分简单多边形。
pub fn ear_clip_triangulate(
  poly : Array[@core.Point2D],
) -> Array[(Int32, Int32, Int32)] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let triangles : Array[(Int32, Int32, Int32)] = []
  let indices : Array[Int32] = []
  for i in 0..<n {
    indices.push(i)
  }
  while indices.length() > 3 {
    let ear_pos = find_ear(poly, indices)
    match ear_pos {
      Some(pos) => {
        let m = indices.length()
        let prev_pos = (pos - 1 + m) % m
        let next_pos = (pos + 1) % m
        triangles.push((indices[prev_pos], indices[pos], indices[next_pos]))
        ignore(indices.remove(pos))
      }
      None => break
    }
  }
  if indices.length() == 3 {
    triangles.push((indices[0], indices[1], indices[2]))
  }
  triangles
}

///|
/// Count triangles in ear clipping triangulation. / 耳裁剪三角剖分中三角形数量。
pub fn ear_clip_count(poly : Array[@core.Point2D]) -> Int32 {
  ear_clip_triangulate(poly).length()
}

///|
/// Total area of ear clipping triangulation. / 耳裁剪三角剖分的总面积。
pub fn ear_clip_area(poly : Array[@core.Point2D]) -> Double {
  let triangles = ear_clip_triangulate(poly)
  let mut total = 0.0
  for tri in triangles {
    let (a, b, c) = tri
    let pa = poly[a]
    let pb = poly[b]
    let pc = poly[c]
    let area = ((pb.x() - pa.x()) * (pc.y() - pa.y()) -
      (pb.y() - pa.y()) * (pc.x() - pa.x())).abs() /
      2.0
    total += area
  }
  total
}
