///|
/// Mesh boolean union (simple: merge vertices and faces, remove internal). / 网格布尔并集（简单：合并顶点和面，移除内部）。
pub fn mesh_union(
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
    if !(point_inside_mesh(centroid3(verts_a[f.0], verts_a[f.1], verts_a[f.2]), verts_b, faces_b)) {
      result_faces.push(f)
    }
  }
  let offset = verts_a.length()
  for v in verts_b {
    result_verts.push(v)
  }
  for f in faces_b {
    let c = centroid3(verts_b[f.0], verts_b[f.1], verts_b[f.2])
    if !(point_inside_mesh(c, verts_a, faces_a)) {
      result_faces.push((f.0 + offset, f.1 + offset, f.2 + offset))
    }
  }
  { vertices: result_verts, faces: result_faces }
}
