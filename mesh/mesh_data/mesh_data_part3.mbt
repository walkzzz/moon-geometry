///|
/// Get the number of edges (each face has 3 edges, shared edges counted once). / 获取边数（每个面 3 条边，共享边只计一次）。
pub impl @core.EdgeCountable for Mesh with fn edge_count(self) {
  let edge_set : Array[(Int32, Int32)] = []
  for f in self.faces {
    add_edge_unique(edge_set, f.v0, f.v1)
    add_edge_unique(edge_set, f.v1, f.v2)
    add_edge_unique(edge_set, f.v2, f.v0)
  }
  edge_set.length()
}

///|
fn add_edge_unique(edges : Array[(Int32, Int32)], a : Int32, b : Int32) -> Unit {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for e in edges {
    if e.0 == lo && e.1 == hi {
      return
    }
  }
  edges.push((lo, hi))
}
