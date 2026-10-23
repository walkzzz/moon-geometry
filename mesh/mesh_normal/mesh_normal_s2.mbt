///|
/// Compute vertex normal by averaging adjacent face normals. / 通过平均相邻面法向量计算顶点法向量。
pub fn vertex_normal(
  mesh : @mesh_data.Mesh,
  vertex_idx : Int32,
) -> @core.Point3D {
  let mut nx = 0.0
  let mut ny = 0.0
  let mut nz = 0.0
  for i in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, i)
    if f.v0 == vertex_idx || f.v1 == vertex_idx || f.v2 == vertex_idx {
      let n = face_normal(mesh, i)
      nx += n.x
      ny += n.y
      nz += n.z
    }
  }
  normalize(@core.Point3D::new(nx, ny, nz))
}
