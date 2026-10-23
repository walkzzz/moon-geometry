///|
/// Mesh boolean difference (A - B). / 网格布尔差集（A - B）。
pub fn mesh_difference(
  verts_a : Array[@core.Point3D],
  faces_a : Array[(Int32, Int32, Int32)],
  verts_b : Array[@core.Point3D],
  faces_b : Array[(Int32, Int32, Int32)],
) -> MeshBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[(Int32, Int32, Int32)] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for f in faces_a {
    let c = centroid3(verts_a[f.0], verts_a[f.1], verts_a[f.2])
    if !point_inside_mesh(c, verts_b, faces_b) {
      result_faces.push(f)
    }
  }
  { vertices: result_verts, faces: result_faces, }
}

///|
fn centroid3(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
) -> @core.Point3D {
  @core.Point3D::new(
    (p0.x + p1.x + p2.x) / 3.0,
    (p0.y + p1.y + p2.y) / 3.0,
    (p0.z + p1.z + p2.z) / 3.0,
  )
}
