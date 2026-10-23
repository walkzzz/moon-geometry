///|
/// Build adjacency list from edge list. / 由边列表构建邻接表。
fn build_adjacency(
  n : Int32,
  edges : Array[(Int32, Int32)],
) -> Array[Array[Int32]] {
  let adj = Array::make(n, [])
  for e in edges {
    adj[e.0].push(e.1)
    adj[e.1].push(e.0)
  }
  adj
}
