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
