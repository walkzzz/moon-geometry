///|
/// Polyhedron intersection. / 多面体交集。
pub fn polyhedron_intersection(
  verts_a : Array[@core.Point3D],
  faces_a : Array[Array[Int]],
  verts_b : Array[@core.Point3D],
  faces_b : Array[Array[Int]],
) -> PolyBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[Array[Int]] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for face in faces_a {
    let c = face_centroid(face, verts_a)
    if point_in_polyhedron(c, verts_b, faces_b) {
      result_faces.push(face)
    }
  }
  { vertices: result_verts, faces: result_faces, success: true }
}
