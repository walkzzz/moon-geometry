///|
/// Build adjacency list from edge list. / 由边列表构建邻接表。
fn build_adjacency(
  n : Int,
  edges : Array[(Int, Int)],
) -> Array[Array[Int]] {
  let adj = Array::make(n, [])
  for e in edges {
    adj[e.0].push(e.1)
    adj[e.1].push(e.0)
  }
  adj
}
