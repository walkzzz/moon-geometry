///|
/// Reeb graph of a scalar field on a mesh. / 网格上标量场的 Reeb 图。
pub struct ReebGraph {
  nodes : Array[ReebNode]
  edges : Array[ReebEdge]
}

///|
pub extend ReebGraph with @core.EdgeCountable::{edge_count}

///|
/// Construct an empty Reeb graph. / 构造空的 Reeb 图。
pub fn ReebGraph::new() -> ReebGraph {
  { nodes: [], edges: [], }
}

///|
/// Get the number of nodes. / 获取节点数。
pub fn ReebGraph::node_count(rg : ReebGraph) -> Int32 {
  rg.nodes.length()
}

///|
/// Get the number of edges. / 获取边数。
pub impl @core.EdgeCountable for ReebGraph with fn edge_count(self) {
  self.edges.length()
}
