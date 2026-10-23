///|
/// Check if the graph is planar using Euler's formula (V - E + F = 2, E <= 3V - 6 for V >= 3). / 用欧拉公式检查平面性（V >= 3 时 E <= 3V - 6）。
pub fn PlanarGraph::is_planar(graph : PlanarGraph) -> Bool {
  let v = graph.vertices.length()
  let e = graph.edges.length()
  if v < 3 {
    return true
  }
  e <= 3 * v - 6
}

///|
/// Compute the degree of a vertex. / 计算顶点的度数。
pub fn PlanarGraph::degree(graph : PlanarGraph, v : Int32) -> Int32 {
  graph.adj[v].length()
}

///|
/// Get neighbors of a vertex. / 获取顶点的邻居。
pub fn PlanarGraph::neighbors(graph : PlanarGraph, v : Int32) -> Array[Int32] {
  graph.adj[v]
}
