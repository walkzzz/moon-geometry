///|
/// Count triangles in monotone triangulation. / 单调三角剖分中三角形数量。
pub fn monotone_triangulate_count(poly : Array[@core.Point2D]) -> Int32 {
  triangulate_monotone(poly).length()
}
