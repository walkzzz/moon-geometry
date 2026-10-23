///|
/// Compute all face normals. / 计算所有面法向量。
pub fn all_face_normals(
  mesh : @mesh_data.Mesh,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  for i in 0..<@mesh_data.Mesh::face_count(mesh) {
    result.push(face_normal_normalized(mesh, i))
  }
  result
}


///|
/// Compute all vertex normals. / 计算所有顶点法向量。
pub fn all_vertex_normals(
  mesh : @mesh_data.Mesh,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  for i in 0..<@mesh_data.Mesh::vertex_count(mesh) {
    result.push(vertex_normal(mesh, i))
  }
  result
}
