///|
/// Count nodes in a PRM roadmap. / 统计 PRM 路线图节点数。
pub fn prm_node_count(roadmap : PRMRoadmap) -> Int32 {
  roadmap.nodes.length()
}

///|
/// Count edges in a PRM roadmap. / 统计 PRM 路线图边数。
pub fn prm_edge_count(roadmap : PRMRoadmap) -> Int32 {
  let mut count = 0
  for i in 0..<roadmap.edges.length() {
    count += roadmap.edges[i].length()
  }
  count / 2
}
