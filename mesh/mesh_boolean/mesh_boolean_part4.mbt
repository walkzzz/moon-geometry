///|
/// Mesh boolean intersection. / 网格布尔交集。
pub fn mesh_intersection(
  verts_a : Array[@core.Point3D],
  faces_a : Array[(Int, Int, Int)],
  verts_b : Array[@core.Point3D],
  faces_b : Array[(Int, Int, Int)],
) -> MeshBoolResult {
  let result_verts : Array[@core.Point3D] = []
  let result_faces : Array[(Int, Int, Int)] = []
  for v in verts_a {
    result_verts.push(v)
  }
  for f in faces_a {
    let c = centroid3(verts_a[f.0], verts_a[f.1], verts_a[f.2])
    if point_inside_mesh(c, verts_b, faces_b) {
      result_faces.push(f)
    }
  }
  { vertices: result_verts, faces: result_faces }
}
