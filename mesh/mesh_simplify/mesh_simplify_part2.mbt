///|
/// Simplify a mesh by collapsing edges shorter than threshold. / 通过折叠短于阈值的边来简化网格。
pub fn simplify_by_edge_length(
  mesh : @mesh_data.Mesh,
  threshold : Double,
) -> @mesh_data.Mesh {
  let result = @mesh_data.Mesh::new()
  let old_to_new : Array[Int32] = Array::make(
    @mesh_data.Mesh::vertex_count(mesh),
    -1,
  )
  for i in 0..<@mesh_data.Mesh::vertex_count(mesh) {
    let v = @mesh_data.Mesh::get_vertex(mesh, i)
    let mut keep = true
    for j in 0..<@mesh_data.Mesh::vertex_count(mesh) {
      if i == j || old_to_new[j] == -1 {
        continue
      }
      let vj = @mesh_data.Mesh::get_vertex(mesh, j)
      if v.dist(vj) < threshold {
        old_to_new[i] = old_to_new[j]
        keep = false
        break
      }
    }
    if keep {
      old_to_new[i] = result.add_vertex(v)
    }
  }
  for i in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, i)
    let n0 = old_to_new[f.v0]
    let n1 = old_to_new[f.v1]
    let n2 = old_to_new[f.v2]
    if n0 != n1 && n1 != n2 && n0 != n2 {
      result.add_face(n0, n1, n2)
    }
  }
  result
}
