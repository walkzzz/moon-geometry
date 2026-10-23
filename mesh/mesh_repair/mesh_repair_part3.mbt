///|
/// Find boundary edges (edges used by only one face). / 查找边界边（仅被一个面使用的边）。
pub fn find_boundary_edges(
  faces : Array[(Int32, Int32, Int32)],
) -> Array[(Int32, Int32)] {
  let edge_count : Array[((Int32, Int32), Int32)] = []
  for f in faces {
    add_edge_count(edge_count, f.0, f.1)
    add_edge_count(edge_count, f.1, f.2)
    add_edge_count(edge_count, f.2, f.0)
  }
  let boundary : Array[(Int32, Int32)] = []
  for entry in edge_count {
    if entry.1 == 1 {
      boundary.push(entry.0)
    }
  }
  boundary
}

///|
fn add_edge_count(
  edges : Array[((Int32, Int32), Int32)],
  a : Int32,
  b : Int32,
) -> Unit {
  let (x, y) = if a < b { (a, b) } else { (b, a) }
  for i in 0..<edges.length() {
    if edges[i].0.0 == x && edges[i].0.1 == y {
      edges[i] = ((x, y), edges[i].1 + 1)
      return
    }
  }
  edges.push(((x, y), 1))
}
