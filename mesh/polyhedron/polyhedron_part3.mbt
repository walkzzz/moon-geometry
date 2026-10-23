///|
/// Number of edges (unique). / 边数（去重）。
pub impl @core.EdgeCountable for Polyhedron with edge_count(self) {
  let edges : Array[(Int, Int)] = []
  for face in self.faces {
    let n = face.length()
    for i in 0..<n {
      let a = face[i]
      let b = face[(i + 1) % n]
      add_edge(edges, a, b)
    }
  }
  edges.length()
}

fn add_edge(edges : Array[(Int, Int)], a : Int, b : Int) -> Unit {
  let (x, y) = if a < b { (a, b) } else { (b, a) }
  for e in edges {
    if e.0 == x && e.1 == y {
      return
    }
  }
  edges.push((x, y))
}
