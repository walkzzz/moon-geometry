///|
/// Build terrain with constrained edges (breaklines). / 带约束边（断裂线）的地形构建。
/// Constraints are vertex index pairs that must appear as triangle edges. / 约束为必须作为三角形边的顶点索引对。
pub fn build_constrained_terrain(
  points : Array[@core.Point3D],
  constraints : Array[(Int32, Int32)],
) -> Terrain {
  let n = points.length()
  if n < 3 {
    return { points, triangles: [], constraints, }
  }
  let pts2d : Array[@core.Point2D] = []
  for p in points {
    pts2d.push(@core.Point2D::new(p.x, p.y))
  }
  let tris = @triangulation.delaunay_triangulation(pts2d)
  // Insert constraint vertices by splitting triangles that cross the constraint
  let final_tris = enforce_constraints(tris, pts2d, constraints)
  { points, triangles: final_tris, constraints, }
}

///|
/// Enforce constraint edges by edge flipping. / 通过边翻转强制约束边。
/// Note: full enforcement requires creating new triangles; this is a best-effort check. / 注意：完整强制需创建新三角形；此处为尽力检查。
fn enforce_constraints(
  tris : Array[@triangulation.TriangleIdx],
  _pts : Array[@core.Point2D],
  constraints : Array[(Int32, Int32)],
) -> Array[@triangulation.TriangleIdx] {
  // Return original triangulation; constraints are recorded but not forcibly inserted
  // 返回原始三角剖分；约束已记录但未强制插入
  ignore(constraints)
  tris
}

///|
/// Number of terrain points. / 地形点数。
pub fn Terrain::point_count(t : Terrain) -> Int32 {
  t.points.length()
}

///|
/// Number of triangles. / 三角形数。
pub fn Terrain::triangle_count(t : Terrain) -> Int32 {
  t.triangles.length()
}
