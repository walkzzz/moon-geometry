///|
/// Add an edge between two vertices. / 在两个顶点之间添加边。
pub fn PlanarGraph::add_edge(
  graph : PlanarGraph,
  from : Int32,
  to : Int32,
) -> Unit {
  graph.edges.push({ from, to, })
  graph.adj[from].push(to)
  graph.adj[to].push(from)
}

///|
/// Get the number of vertices. / 获取顶点数。
pub impl @core.VertexCountable for PlanarGraph with fn vertex_count(self) {
  self.vertices.length()
}

///|
/// Get the number of edges. / 获取边数。
pub impl @core.EdgeCountable for PlanarGraph with fn edge_count(self) {
  self.edges.length()
}
