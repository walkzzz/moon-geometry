///|
/// Euler tour of a planar graph (traversal visiting every edge twice). / 平面图的欧拉回路（遍历每条边两次）。
pub struct EulerTour {
  tour : Array[Int32]
  depth : Array[Int32]
}

///|
/// Compute the Euler tour of a tree represented by adjacency list. / 计算以邻接表表示的树的欧拉回路。
pub fn build_euler_tour(
  n : Int32,
  adj : Array[Array[Int32]],
  root : Int32,
) -> EulerTour {
  let tour : Array[Int32] = []
  let depth : Array[Int32] = []
  let visited = Array::make(n, false)
  euler_dfs(root, 0, adj, visited, tour, depth)
  { tour, depth, }
}

///|
fn euler_dfs(
  v : Int32,
  d : Int32,
  adj : Array[Array[Int32]],
  visited : Array[Bool],
  tour : Array[Int32],
  depth : Array[Int32],
) -> Unit {
  visited[v] = true
  tour.push(v)
  depth.push(d)
  for u in adj[v] {
    if !visited[u] {
      euler_dfs(u, d + 1, adj, visited, tour, depth)
      tour.push(v)
      depth.push(d)
    }
  }
}

///|
/// Get the tour sequence. / 获取回路序列。
pub fn euler_tour_sequence(tour : EulerTour) -> Array[Int32] {
  tour.tour
}

///|
/// Get the depth sequence. / 获取深度序列。
pub fn euler_tour_depths(tour : EulerTour) -> Array[Int32] {
  tour.depth
}

///|
/// Get the tour length. / 获取回路长度。
pub fn euler_tour_length(tour : EulerTour) -> Int32 {
  tour.tour.length()
}

///|
/// Find the first occurrence of a vertex in the tour. / 在回路中查找顶点的首次出现位置。
pub fn euler_tour_first_occurrence(tour : EulerTour, v : Int32) -> Int32 {
  for i in 0..<tour.tour.length() {
    if tour.tour[i] == v {
      return i
    }
  }
  -1
}

///|
/// Compute LCA (Lowest Common Ancestor) using the Euler tour + RMQ. / 使用欧拉回路 + RMQ 计算最近公共祖先。
pub fn euler_tour_lca(tour : EulerTour, u : Int32, v : Int32) -> Int32 {
  let pu = euler_tour_first_occurrence(tour, u)
  let pv = euler_tour_first_occurrence(tour, v)
  if pu == -1 || pv == -1 {
    return -1
  }
  let lo = if pu < pv { pu } else { pv }
  let hi = if pu > pv { pu } else { pv }
  let mut min_depth = tour.depth[lo]
  let mut min_idx = lo
  for i in (lo + 1)..<=hi {
    if tour.depth[i] < min_depth {
      min_depth = tour.depth[i]
      min_idx = i
    }
  }
  tour.tour[min_idx]
}

///|
/// Check if the Euler tour is valid (starts and ends at root). / 检查欧拉回路是否有效（起点和终点为根）。
pub fn euler_tour_is_valid(tour : EulerTour) -> Bool {
  tour.tour.length() > 0 && tour.tour[0] == tour.tour[tour.tour.length() - 1]
}
