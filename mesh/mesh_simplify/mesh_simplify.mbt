///|
/// Add a vertex to a mesh from coordinates. Returns vertex index. / 从坐标添加顶点到网格，返回顶点索引。
pub fn add_vertex_coords(
  mesh : @mesh_data.Mesh,
  x : Double,
  y : Double,
  z : Double,
) -> Int32 {
  mesh.add_vertex(@core.Point3D::new(x, y, z))
}
