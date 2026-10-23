///|
test "reeb_graph empty" {
  let rg = reeb_graph([], [])
  assert_eq(reeb_node_count(rg), 0)
  assert_eq(reeb_edge_count(rg), 0)
}

///|
test "reeb_graph single point" {
  let rg = reeb_graph([1.0], [])
  assert_eq(reeb_node_count(rg), 1)
}

///|
test "reeb_graph two points" {
  let values = [0.0, 1.0]
  let edges = [(0, 1)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 2)
  assert_true(reeb_edge_count(rg) >= 1)
}

///|
test "critical_points minimum" {
  let values = [0.0, 1.0, 1.0]
  let edges = [(0, 1), (0, 2)]
  let cps = critical_points(values, edges)
  assert_eq(cps[0].crit_type, Minimum)
}

///|
test "critical_points maximum" {
  let values = [0.0, 0.0, 1.0]
  let edges = [(0, 2), (1, 2)]
  let cps = critical_points(values, edges)
  assert_eq(cps[2].crit_type, Maximum)
}

///|
test "critical_points regular" {
  let values = [0.0, 1.0, 2.0]
  let edges = [(0, 1), (1, 2)]
  let cps = critical_points(values, edges)
  assert_eq(cps[1].crit_type, Regular)
}

///|
test "ReebNode::new" {
  let n = ReebNode::new(0, 1.5, Minimum)
  assert_eq(n.vertex_idx, 0)
  assert_true((n.level - 1.5).abs() < 0.0000001)
}

///|
test "ReebEdge::new" {
  let e = ReebEdge::new(0, 1)
  assert_eq(e.from, 0)
  assert_eq(e.to, 1)
}

///|
test "ReebGraph::new" {
  let rg = ReebGraph::new()
  assert_eq(rg.node_count(), 0)
  assert_eq(rg.edge_count(), 0)
}

///|
test "reeb_graph path" {
  let values = [0.0, 1.0, 2.0, 1.0, 0.0]
  let edges = [(0, 1), (1, 2), (2, 3), (3, 4)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 5)
  assert_true(reeb_edge_count(rg) >= 1)
}
