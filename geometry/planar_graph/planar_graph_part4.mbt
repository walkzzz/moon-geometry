///|
/// Check if the graph is connected using BFS. / 使用 BFS 检查图是否连通。
pub fn PlanarGraph::is_connected(graph : PlanarGraph) -> Bool {
  let n = graph.vertices.length()
  if n == 0 {
    return true
  }
  let visited = Array::make(n, false)
  let queue : Array[Int32] = [0]
  visited[0] = true
  while queue.length() > 0 {
    let v = queue.remove(0)
    for u in graph.adj[v] {
      if !visited[u] {
        visited[u] = true
        queue.push(u)
      }
    }
  }
  for v in 0..<n {
    if !visited[v] {
      return false
    }
  }
  true
}
