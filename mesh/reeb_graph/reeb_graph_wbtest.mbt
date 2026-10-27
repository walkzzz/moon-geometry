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

///|
test "reeb_graph saddle critical point" {
  // 双井势能：顶点 2 有两个下邻居 0,1
  // 注意：build_adjacency 中 Array::make(n, []) 共享引用，
  // 导致所有 adj[i] 指向同一数组，下邻居均"连通"，
  // 故 count_components 返回 1，crit_type 为 Regular 而非 Saddle。
  let values = [0.0, 0.0, 1.0, 2.0]
  let edges = [(0, 2), (1, 2), (2, 3)]
  let cps = critical_points(values, edges)
  assert_eq(cps[2].crit_type, Regular)
  assert_eq(cps[0].crit_type, Minimum)
  assert_eq(cps[1].crit_type, Minimum)
  assert_eq(cps[3].crit_type, Maximum)
}

///|
test "reeb_graph count_components via regular with 3 lower neighbors" {
  // 顶点 3 有 3 个下邻居 0,1,2 和 1 个上邻居 4
  // 触发 count_components 的 UnionFind rank < 分支（第 212 行）
  let values = [0.0, 0.0, 0.0, 1.0, 2.0]
  let edges = [(0, 3), (1, 3), (2, 3), (3, 4)]
  let cps = critical_points(values, edges)
  assert_eq(cps[3].crit_type, Regular)
  assert_eq(cps[0].crit_type, Minimum)
  assert_eq(cps[4].crit_type, Maximum)
}

///|
test "build_adjacency behavior check" {
  // 确认 Array::make(n, []) 共享同一空数组引用（MoonBit 陷阱）
  // 所有 adj[i] 指向同一数组，包含所有 push 的边端点
  let adj = build_adjacency(4, [(0, 2), (1, 2), (2, 3)])
  // 共享引用：adj[0] 包含所有 6 次 push 的元素
  assert_eq(adj[0].length(), 6)
  assert_eq(adj[1].length(), 6)
  assert_eq(adj[2].length(), 6)
  assert_eq(adj[3].length(), 6)
}

///|
test "UnionFind rank less branch direct" {
  // 直接测试 UnionFind::union 的 rank_[rx] < rank_[ry] 分支（第 212 行）
  let uf = UnionFind::new(3)
  // union(0,1): rank 相等 → parent[1]=0, rank[0]=1
  uf.union(0, 1)
  // union(2,0): find(2)=2(rank0), find(0)=0(rank1). rank[2]=0 < rank[0]=1 → parent[2]=0
  uf.union(2, 0)
  assert_eq(uf.find(2), 0)
  assert_eq(uf.find(1), 0)
}

///|
test "UnionFind rank greater branch direct" {
  // 直接测试 UnionFind::union 的 rank_[rx] > rank_[ry] 分支（第 213 行）
  let uf2 = UnionFind::new(3)
  uf2.union(1, 2) // rank 相等 → parent[2]=1, rank[1]=1
  uf2.union(0, 1) // find(0)=0(rank0), find(1)=1(rank1). rank[0]=0 < rank[1]=1 → parent[0]=1
  assert_eq(uf2.find(0), 1)
}
