///|
/// PLY mesh: vertices + polygon faces (index lists).
/// PLY 网格：顶点 + 多边形面（索引列表）。
pub struct PlyMesh {
  vertices : Array[@core.Point3D]
  faces : Array[Array[Int]]
}


///|
/// Create an empty PLY mesh. / 创建空 PLY 网格。
pub fn PlyMesh::new() -> PlyMesh {
  { vertices: [], faces: [] }
}


///|
/// Number of vertices. / 顶点数。
pub fn PlyMesh::vertex_count(m : PlyMesh) -> Int {
  m.vertices.length()
}


///|
/// Number of faces. / 面数。
pub fn PlyMesh::face_count(m : PlyMesh) -> Int {
  m.faces.length()
}
