///|
/// Compute the normal vector of a triangle face. / 计算三角面的法向量。
pub fn face_normal(mesh : @mesh_data.Mesh, face_idx : Int32) -> @core.Point3D {
  let f = @mesh_data.Mesh::get_face(mesh, face_idx)
  let v0 = @mesh_data.Mesh::get_vertex(mesh, f.v0)
  let v1 = @mesh_data.Mesh::get_vertex(mesh, f.v1)
  let v2 = @mesh_data.Mesh::get_vertex(mesh, f.v2)
  let e1 = v1.sub(v0)
  let e2 = v2.sub(v0)
  e1.cross(e2)
}

///|
/// Normalize a 3D vector to unit length. / 将三维向量归一化为单位长度。
pub fn normalize(v : @core.Point3D) -> @core.Point3D {
  let len = (v.x * v.x + v.y * v.y + v.z * v.z).sqrt()
  if len < 0.000000001 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  @core.Point3D::new(v.x / len, v.y / len, v.z / len)
}

///|
/// Compute normalized face normal. / 计算归一化的面法向量。
pub fn face_normal_normalized(
  mesh : @mesh_data.Mesh,
  face_idx : Int32,
) -> @core.Point3D {
  normalize(face_normal(mesh, face_idx))
}
