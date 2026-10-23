///|
/// Compute the cost of collapsing an edge (distance between endpoints). / 计算折叠边的代价（端点间距离）。
pub fn edge_collapse_cost(
  mesh : @mesh_data.Mesh,
  v0 : Int32,
  v1 : Int32,
) -> Double {
  @mesh_data.Mesh::get_vertex(mesh, v0).dist(
    @mesh_data.Mesh::get_vertex(mesh, v1),
  )
}

///|
/// Count the number of edges that can be collapsed. / 计算可折叠的边数。
pub fn collapsible_edges(mesh : @mesh_data.Mesh, threshold : Double) -> Int32 {
  let mut count = 0
  let n = @mesh_data.Mesh::vertex_count(mesh)
  for i in 0..<n {
    for j in (i + 1)..<n {
      if edge_collapse_cost(mesh, i, j) < threshold {
        count += 1
      }
    }
  }
  count
}

///|
/// Compute the simplification ratio. / 计算简化率。
pub fn simplification_ratio(
  original : @mesh_data.Mesh,
  simplified : @mesh_data.Mesh,
) -> Double {
  let orig_count = @mesh_data.Mesh::vertex_count(original)
  if orig_count == 0 {
    return 0.0
  }
  1.0 -
  @mesh_data.Mesh::vertex_count(simplified).to_double() / orig_count.to_double()
}
