///|
/// Type of critical point in a Reeb graph. / Reeb 图中临界点类型。
pub(all) enum CriticalType {
  Minimum
  Maximum
  Saddle
  Regular
} derive(Debug, Eq)

///|
pub extend CriticalType with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend CriticalType with Eq::{equal, not_equal}

///|
/// A node in the Reeb graph (critical point). / Reeb 图中的节点（临界点）。
pub struct ReebNode {
  vertex_idx : Int
  level : Double
  crit_type : CriticalType
}

///|
/// Construct a Reeb node. / 构造 Reeb 节点。
pub fn ReebNode::new(
  vertex_idx : Int,
  level : Double,
  crit_type : CriticalType,
) -> ReebNode {
  { vertex_idx, level, crit_type }
}

///|
/// An edge in the Reeb graph (arc between critical points). / Reeb 图中的边（临界点之间的弧）。
pub struct ReebEdge {
  from : Int
  to : Int
}

///|
/// Construct a Reeb edge. / 构造 Reeb 边。
pub fn ReebEdge::new(from : Int, to : Int) -> ReebEdge {
  { from, to }
}

///|
/// Reeb graph of a scalar field on a mesh. / 网格上标量场的 Reeb 图。
pub struct ReebGraph {
  nodes : Array[ReebNode]
  edges : Array[ReebEdge]
}

///|
/// Construct an empty Reeb graph. / 构造空的 Reeb 图。
pub fn ReebGraph::new() -> ReebGraph {
  { nodes: [], edges: [] }
}

///|
/// Get the number of nodes. / 获取节点数。
pub fn ReebGraph::node_count(rg : ReebGraph) -> Int {
  rg.nodes.length()
}

///|
/// Get the number of edges. / 获取边数。
pub fn ReebGraph::edge_count(rg : ReebGraph) -> Int {
  rg.edges.length()
}

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

///|
/// Find critical points of a scalar field on a mesh. / 寻找网格上标量场的临界点。
pub fn critical_points(
  values : Array[Double],
  edges : Array[(Int, Int)],
) -> Array[ReebNode] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let adj = build_adjacency(n, edges)
  let nodes : Array[ReebNode] = []
  for i in 0..<n {
    let mut lower_count = 0
    let mut upper_count = 0
    for j in adj[i] {
      if values[j] < values[i] - 0.0000000001 {
        lower_count += 1
      }
      if values[j] > values[i] + 0.0000000001 {
        upper_count += 1
      }
    }
    let crit_type = if lower_count == 0 && upper_count == 0 {
      Regular
    } else if lower_count == 0 {
      Minimum
    } else if upper_count == 0 {
      Maximum
    } else {
      let lower_components = count_components(i, adj, values, true)
      let upper_components = count_components(i, adj, values, false)
      if lower_components > 1 || upper_components > 1 {
        Saddle
      } else {
        Regular
      }
    }
    nodes.push({ vertex_idx: i, level: values[i], crit_type })
  }
  nodes
}

///|
/// Count connected components of lower/upper link. / 计算下/上链接的连通分量数。
fn count_components(
  v : Int,
  adj : Array[Array[Int]],
  values : Array[Double],
  lower : Bool,
) -> Int {
  let neighbors : Array[Int] = []
  for j in adj[v] {
    if lower && values[j] < values[v] - 0.0000000001 {
      neighbors.push(j)
    }
    if !lower && values[j] > values[v] + 0.0000000001 {
      neighbors.push(j)
    }
  }
  if neighbors.length() == 0 {
    return 0
  }
  let neighbor_set : Array[Int] = Array::make(values.length(), -1)
  for idx in 0..<neighbors.length() {
    neighbor_set[neighbors[idx]] = idx
  }
  let uf = UnionFind::new(neighbors.length())
  for a in 0..<neighbors.length() {
    for b in (a + 1)..<neighbors.length() {
      let na = neighbors[a]
      let nb = neighbors[b]
      for e in adj[na] {
        if e == nb {
          uf.union(a, b)
          break
        }
      }
    }
  }
  let mut components = 0
  for i in 0..<neighbors.length() {
    if uf.find(i) == i {
      components += 1
    }
  }
  components
}

///|
/// Union-find for component counting. / 用于分量计数的并查集。
priv struct UnionFind {
  parent : Array[Int]
  rank_ : Array[Int]
}

fn UnionFind::new(n : Int) -> UnionFind {
  let parent = Array::make(n, 0)
  let rank_ = Array::make(n, 0)
  for i in 0..<n {
    parent[i] = i
  }
  { parent, rank_ }
}

fn UnionFind::find(uf : UnionFind, x : Int) -> Int {
  let mut root = x
  while uf.parent[root] != root {
    root = uf.parent[root]
  }
  root
}

fn UnionFind::union(uf : UnionFind, x : Int, y : Int) -> Unit {
  let rx = uf.find(x)
  let ry = uf.find(y)
  if rx == ry {
    return
  }
  if uf.rank_[rx] < uf.rank_[ry] {
    uf.parent[rx] = ry
  } else if uf.rank_[rx] > uf.rank_[ry] {
    uf.parent[ry] = rx
  } else {
    uf.parent[ry] = rx
    uf.rank_[rx] += 1
  }
}

///|
/// Compute the Reeb graph of a scalar field. / 计算标量场的 Reeb 图。
pub fn reeb_graph(
  values : Array[Double],
  edges : Array[(Int, Int)],
) -> ReebGraph {
  let nodes = critical_points(values, edges)
  let n = values.length()
  if n == 0 {
    return { nodes: [], edges: [] }
  }
  let adj = build_adjacency(n, edges)
  let order = sort_by_value(values)
  let component : Array[Int] = Array::make(n, -1)
  let mut next_component = 0
  let reeb_edges : Array[ReebEdge] = []
  let comp_start : Array[Int] = Array::make(n, -1)
  for vi in order {
    let lower_comps : Array[Int] = []
    for j in adj[vi] {
      if values[j] < values[vi] - 0.0000000001 && component[j] != -1 {
        let mut found = false
        for c in lower_comps {
          if c == component[j] {
            found = true
            break
          }
        }
        if !found {
          lower_comps.push(component[j])
        }
      }
    }
    let node = nodes[vi]
    match node.crit_type {
      Minimum => {
        component[vi] = next_component
        comp_start[next_component] = vi
        next_component += 1
      }
      Maximum => {
        if lower_comps.length() > 0 {
          reeb_edges.push({ from: comp_start[lower_comps[0]], to: vi })
          component[vi] = lower_comps[0]
        }
      }
      Saddle => {
        if lower_comps.length() >= 2 {
          for c in lower_comps {
            reeb_edges.push({ from: comp_start[c], to: vi })
          }
          component[vi] = lower_comps[0]
          for j in 0..<n {
            if component[j] == lower_comps[1] {
              component[j] = lower_comps[0]
            }
          }
        } else if lower_comps.length() == 1 {
          component[vi] = lower_comps[0]
        }
      }
      Regular => {
        if lower_comps.length() == 1 {
          component[vi] = lower_comps[0]
        } else {
          component[vi] = next_component
          comp_start[next_component] = vi
          next_component += 1
        }
      }
    }
  }
  { nodes, edges: reeb_edges }
}

fn sort_by_value(values : Array[Double]) -> Array[Int] {
  let n = values.length()
  let order = Array::make(n, 0)
  for i in 0..<n {
    order[i] = i
  }
  for i in 0..<(n - 1) {
    for j in 0..<(n - 1 - i) {
      if values[order[j]] > values[order[j + 1]] {
        let tmp = order[j]
        order[j] = order[j + 1]
        order[j + 1] = tmp
      }
    }
  }
  order
}

///|
/// Count Reeb graph nodes. / 计算 Reeb 图节点数。
pub fn reeb_node_count(rg : ReebGraph) -> Int {
  rg.nodes.length()
}

///|
/// Count Reeb graph edges. / 计算 Reeb 图边数。
pub fn reeb_edge_count(rg : ReebGraph) -> Int {
  rg.edges.length()
}