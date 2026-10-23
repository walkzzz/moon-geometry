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
