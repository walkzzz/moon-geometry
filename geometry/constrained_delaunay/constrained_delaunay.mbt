///|
/// Constrained Delaunay triangulation result. / 约束 Delaunay 三角剖分结果。
pub struct ConstrainedDelaunay {
  points : Array[@core.Point2D]
  triangles : Array[(Int, Int, Int)]
  constraints : Array[(Int, Int)]
}


///|
/// Construct an empty constrained Delaunay triangulation. / 构造空的约束 Delaunay 三角剖分。
pub fn ConstrainedDelaunay::new() -> ConstrainedDelaunay {
  { points: [], triangles: [], constraints: [] }
}


///|
/// Get the number of triangles. / 获取三角形数量。
pub fn ConstrainedDelaunay::triangle_count(cd : ConstrainedDelaunay) -> Int {
  cd.triangles.length()
}


///|
/// Get the number of constraint edges. / 获取约束边数量。
pub fn ConstrainedDelaunay::constraint_count(cd : ConstrainedDelaunay) -> Int {
  cd.constraints.length()
}
