///|
/// TIN (Triangulated Irregular Network) built from 3D points. / 由三维点构建的不规则三角网。
pub struct TIN {
  points : Array[@core.Point3D]
  triangles : Array[@triangulation.TriangleIdx]
}


///|
/// Construct a TIN from points and triangle indices. / 从点和三角形索引构造 TIN。
pub fn TIN::new(
  points : Array[@core.Point3D],
  triangles : Array[@triangulation.TriangleIdx],
) -> TIN {
  { points, triangles }
}


///|
/// Build a TIN from 3D points using Delaunay triangulation of XY. / 用 XY 平面的 Delaunay 三角剖分从三维点构建 TIN。
pub fn build_tin(points : Array[@core.Point3D]) -> TIN {
  let n = points.length()
  if n < 3 {
    return { points, triangles: [] }
  }
  let pts2d : Array[@core.Point2D] = []
  for p in points {
    pts2d.push(@core.Point2D::new(p.x, p.y))
  }
  let tris = @triangulation.delaunay_triangulation(pts2d)
  { points, triangles: tris }
}


///|
/// Number of points in the TIN. / TIN 中的点数。
pub fn TIN::point_count(t : TIN) -> Int {
  t.points.length()
}


///|
/// Number of triangles in the TIN. / TIN 中的三角形数。
pub fn TIN::triangle_count(t : TIN) -> Int {
  t.triangles.length()
}
