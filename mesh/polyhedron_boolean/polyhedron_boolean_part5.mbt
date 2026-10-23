///|
/// Polyhedron difference (A - B). / 多面体差集（A - B）。
pub fn polyhedron_difference(
  verts_a : Array[@core.Point3D],
  faces_a : Array[Array[Int32]],
  verts_b : Array[@core.Point3D],
  faces_b : Array[Array[Int32]],
) -> PolyBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[Array[Int32]] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for face in faces_a {
    let c = face_centroid(face, verts_a)
    if !point_in_polyhedron(c, verts_b, faces_b) {
      result_faces.push(face)
    }
  }
  { vertices: result_verts, faces: result_faces, success: true, }
}

///|
fn face_centroid(
  face : Array[Int32],
  verts : Array[@core.Point3D],
) -> @core.Point3D {
  let n = face.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  for idx in face {
    cx += verts[idx].x
    cy += verts[idx].y
    cz += verts[idx].z
  }
  @core.Point3D::new(cx / n.to_double(), cy / n.to_double(), cz / n.to_double())
}
