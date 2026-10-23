///|
/// Terrain built from Z-valued points via Delaunay triangulation. / 由带高程点经 Delaunay 三角剖分构建的地形。
pub struct Terrain {
  points : Array[@core.Point3D]
  triangles : Array[@triangulation.TriangleIdx]
  constraints : Array[(Int32, Int32)]
}

///|
/// Construct terrain. / 构造地形。
pub fn Terrain::new(
  points : Array[@core.Point3D],
  triangles : Array[@triangulation.TriangleIdx],
  constraints : Array[(Int32, Int32)],
) -> Terrain {
  { points, triangles, constraints, }
}

///|
/// Build terrain from points (unconstrained Delaunay). / 从点构建地形（无约束 Delaunay）。
pub fn build_terrain(points : Array[@core.Point3D]) -> Terrain {
  let n = points.length()
  if n < 3 {
    return { points, triangles: [], constraints: [], }
  }
  let pts2d : Array[@core.Point2D] = []
  for p in points {
    pts2d.push(@core.Point2D::new(p.x, p.y))
  }
  let tris = @triangulation.delaunay_triangulation(pts2d)
  { points, triangles: tris, constraints: [], }
}
