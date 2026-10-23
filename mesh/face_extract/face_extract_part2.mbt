///|
/// Extract faces from a set of edges forming a planar subdivision. / 从构成平面细分的边集提取面。
pub fn extract_faces(
  vertices : Array[@core.Point2D],
  edges : Array[(Int32, Int32)],
) -> Array[Face] {
  let n = vertices.length()
  let adj : Array[Array[Int32]] = Array::make(n, [])
  for e in edges {
    adj[e.0].push(e.1)
    adj[e.1].push(e.0)
  }
  let visited : Array[Array[Bool]] = Array::make(n, [])
  for i in 0..<n {
    visited[i] = Array::make(adj[i].length(), false)
  }
  let faces : Array[Face] = []
  for v in 0..<n {
    for ei in 0..<adj[v].length() {
      if visited[v][ei] {
        continue
      }
      let face_boundary = trace_face(v, ei, adj, visited, vertices)
      if face_boundary.length() >= 3 {
        faces.push({ boundary: face_boundary, holes: [], })
      }
    }
  }
  faces
}

///|
fn trace_face(
  start_v : Int32,
  start_ei : Int32,
  adj : Array[Array[Int32]],
  visited : Array[Array[Bool]],
  vertices : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let boundary : Array[@core.Point2D] = []
  let mut v = start_v
  let mut ei = start_ei
  let mut steps = 0
  let max_steps = adj.length() * adj.length() + 10
  while steps < max_steps {
    if visited[v][ei] {
      break
    }
    visited[v][ei] = true
    boundary.push(vertices[v])
    steps += 1
    let u = adj[v][ei]
    let mut next_ei = -1
    for k in 0..<adj[u].length() {
      if adj[u][k] == v {
        next_ei = (k + 1) % adj[u].length()
        break
      }
    }
    if next_ei == -1 {
      break
    }
    v = u
    ei = next_ei
    if v == start_v {
      break
    }
  }
  boundary
}
