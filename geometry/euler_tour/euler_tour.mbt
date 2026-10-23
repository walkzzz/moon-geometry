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
