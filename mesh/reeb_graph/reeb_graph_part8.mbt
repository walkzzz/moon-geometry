///|
/// Count Reeb graph nodes. / 计算 Reeb 图节点数。
pub fn reeb_node_count(rg : ReebGraph) -> Int32 {
  rg.nodes.length()
}

///|
/// Count Reeb graph edges. / 计算 Reeb 图边数。
pub fn reeb_edge_count(rg : ReebGraph) -> Int32 {
  rg.edges.length()
}
