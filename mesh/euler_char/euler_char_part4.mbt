///|
/// Check if the mesh is manifold (each edge shared by at most 2 faces). / 检查网格是否为流形（每条边最多被 2 个面共享）。
pub fn is_manifold(mesh : @mesh_data.Mesh) -> Bool {
  let edge_count_map : Array[(Int32, Int32, Int32)] = []
  for fi in 0..<@mesh_data.Mesh::face_count(mesh) {
    let f = @mesh_data.Mesh::get_face(mesh, fi)
    check_edge_manifold(edge_count_map, f.v0, f.v1)
    check_edge_manifold(edge_count_map, f.v1, f.v2)
    check_edge_manifold(edge_count_map, f.v2, f.v0)
  }
  for e in edge_count_map {
    if e.2 > 2 {
      return false
    }
  }
  true
}

///|
fn check_edge_manifold(
  map : Array[(Int32, Int32, Int32)],
  a : Int32,
  b : Int32,
) -> Unit {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for i in 0..<map.length() {
    if map[i].0 == lo && map[i].1 == hi {
      map[i] = (lo, hi, map[i].2 + 1)
      return
    }
  }
  map.push((lo, hi, 1))
}
