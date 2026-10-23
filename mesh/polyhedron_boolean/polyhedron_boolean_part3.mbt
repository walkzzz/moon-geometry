///|
/// Polyhedron union. / 多面体并集。
pub fn polyhedron_union(
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
    if !(point_in_polyhedron(c, verts_b, faces_b)) {
      result_faces.push(face)
    }
  }
  let offset = verts_a.length()
  for v in verts_b {
    result_verts.push(v)
  }
  for face in faces_b {
    let c = face_centroid(face, verts_b)
    if !(point_in_polyhedron(c, verts_a, faces_a)) {
      let new_face : Array[Int] = []
      for idx in face {
        new_face.push(idx + offset)
      }
      result_faces.push(new_face)
    }
  }
  { vertices: result_verts, faces: result_faces, success: true }
}
