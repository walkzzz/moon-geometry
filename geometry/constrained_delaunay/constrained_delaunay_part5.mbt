///|
/// Count triangles in the constrained Delaunay triangulation. / 计算约束 Delaunay 三角剖分中的三角形数。
pub fn constrained_triangle_count(cd : ConstrainedDelaunay) -> Int32 {
  cd.triangles.length()
}
