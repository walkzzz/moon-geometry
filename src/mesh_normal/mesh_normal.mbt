///|
/// Compute the normal vector of a triangle face. / 计算三角面的法向量。
pub fn face_normal(
  mesh : @mesh_data.Mesh,
  face_idx : Int,
) -> @core.Point3D {
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
  face_idx : Int,
) -> @core.Point3D {
  normalize(face_normal(mesh, face_idx))
}

///|
/// Compute vertex normal by averaging adjacent face normals. / 通过平均相邻面法向量计算顶点法向量。
pub fn vertex_normal(
  mesh : @mesh_data.Mesh,
  vertex_idx : Int,
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

///|
/// Compute the area-weighted normal of a face. / 计算面的面积加权法向量。
pub fn area_weighted_normal(
  mesh : @mesh_data.Mesh,
  face_idx : Int,
) -> @core.Point3D {
  face_normal(mesh, face_idx)
}

///|
/// Compute the area of a triangle face. / 计算三角面的面积。
pub fn face_area(
  mesh : @mesh_data.Mesh,
  face_idx : Int,
) -> Double {
  let n = face_normal(mesh, face_idx)
  0.5 * (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
}