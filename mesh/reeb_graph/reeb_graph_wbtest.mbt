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

///|
test "critical_points empty" {
  let cps = critical_points([], [])
  assert_eq(cps.length(), 0)
}

///|
test "critical_points all equal values" {
  // 等值点：lower==0 && upper==0 → Regular
  let values = [1.0, 1.0]
  let edges = [(0, 1)]
  let cps = critical_points(values, edges)
  assert_eq(cps[0].crit_type, Regular)
  assert_eq(cps[1].crit_type, Regular)
}

///|
test "critical_points min regular max" {
  // 三顶点路径：min → regular → max
  let values = [0.0, 1.0, 2.0]
  let edges = [(0, 1), (1, 2)]
  let cps = critical_points(values, edges)
  assert_eq(cps[0].crit_type, Minimum)
  assert_eq(cps[1].crit_type, Regular)
  assert_eq(cps[2].crit_type, Maximum)
}

///|
test "reeb_graph three vertex path" {
  // 覆盖 Regular lower_comps == 1 分支
  let values = [0.0, 1.0, 2.0]
  let edges = [(0, 1), (1, 2)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 3)
  assert_eq(reeb_edge_count(rg), 1)
}

///|
test "reeb_graph regular with multiple lower comps" {
  // Regular 点有两个不同 component 的下邻居
  // 覆盖 Regular else 分支（lower_comps.length() != 1）
  let values = [0.0, 0.0, 1.0, 2.0]
  let edges = [(0, 2), (1, 2), (2, 3)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 4)
  assert_eq(reeb_edge_count(rg), 1)
  let cps = critical_points(values, edges)
  assert_eq(cps[2].crit_type, Regular)
}

///|
test "reeb_graph all equal values" {
  // 等值点都是 Regular，覆盖 Regular else 分支（lower_comps 为空）
  let values = [1.0, 1.0]
  let edges = [(0, 1)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 2)
  assert_eq(reeb_edge_count(rg), 0)
}

///|
test "reeb_graph two separate maxima" {
  // 两个独立山峰，覆盖 Maximum lower_comps > 0 分支
  let values = [0.0, 1.0, 0.0, 1.0]
  let edges = [(0, 1), (2, 3)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 4)
  assert_eq(reeb_edge_count(rg), 2)
  let cps = critical_points(values, edges)
  assert_eq(cps[1].crit_type, Maximum)
  assert_eq(cps[3].crit_type, Maximum)
}

///|
test "reeb_graph isolated vertices" {
  // 孤立顶点（无边）：lower==0 && upper==0 → Regular
  let values = [0.0, 1.0, 2.0]
  let rg = reeb_graph(values, [])
  assert_eq(reeb_node_count(rg), 3)
  assert_eq(reeb_edge_count(rg), 0)
  let cps = critical_points(values, [])
  assert_eq(cps[0].crit_type, Regular)
  assert_eq(cps[1].crit_type, Regular)
  assert_eq(cps[2].crit_type, Regular)
}

///|
test "reeb_graph star shape" {
  // 星形：中心点连接多个叶子
  let values = [0.0, 1.0, 1.0, 1.0]
  let edges = [(0, 1), (0, 2), (0, 3)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 4)
  let cps = critical_points(values, edges)
  assert_eq(cps[0].crit_type, Minimum)
}

///|
test "reeb_graph valley peak valley" {
  // 谷谷形状
  let values = [1.0, 0.0, 1.0]
  let edges = [(0, 1), (1, 2)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 3)
  let cps = critical_points(values, edges)
  assert_eq(cps[1].crit_type, Minimum)
}

///|
test "reeb_graph union find branches" {
  // 4 个下邻居触发 count_components 的 UnionFind::union
  // 覆盖 rank > 分支和 rx == ry 分支
  let values = [0.0, 0.0, 0.0, 0.0, 1.0, 2.0]
  let edges = [(0, 4), (1, 4), (2, 4), (3, 4), (4, 5)]
  let rg = reeb_graph(values, edges)
  assert_eq(reeb_node_count(rg), 6)
  assert_eq(reeb_edge_count(rg), 1)
  let cps = critical_points(values, edges)
  assert_eq(cps[4].crit_type, Regular)
  assert_eq(cps[5].crit_type, Maximum)
}
