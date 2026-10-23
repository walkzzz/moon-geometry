///|
/// Compute the area-weighted normal of a face. / 计算面的面积加权法向量。
pub fn area_weighted_normal(
  mesh : @mesh_data.Mesh,
  face_idx : Int32,
) -> @core.Point3D {
  face_normal(mesh, face_idx)
}

///|
/// Compute the area of a triangle face. / 计算三角面的面积。
pub fn face_area(mesh : @mesh_data.Mesh, face_idx : Int32) -> Double {
  let n = face_normal(mesh, face_idx)
  0.5 * (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
}
