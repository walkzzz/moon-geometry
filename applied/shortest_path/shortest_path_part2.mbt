///| Create a new graph edge with target and weight. / 用目标和权重创建新图边。
pub fn GraphEdge::new(to : Int, weight : Double) -> GraphEdge {
  { to, weight }
}

/// |
/// Find shortest path from source to all vertices.
/// 从源点到所有顶点的最短路径。
///
/// # Arguments / 参数
/// - `n`: number of vertices / 顶点数
/// - `adj`: adjacency list / 邻接表
/// - `src`: source vertex / 源点
///
/// Returns array of distances (infinity = 1e18 if unreachable).
/// 返回距离数组（不可达 = 1e18）。
pub fn dijkstra(
  n : Int,
  adj : Array[Array[GraphEdge]],
  src : Int,
) -> Array[Double] {
  let dist : Array[Double] = []
  let visited : Array[Bool] = []
  for _ in 0..<n {
    dist.push(1000000000000000000.0)
    visited.push(false)
  }
  dist[src] = 0.0
  for _ in 0..<n {
    let mut u = -1
    let mut min_d = 1000000000000000000.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_d {
        min_d = dist[i]
        u = i
      }
    }
    if u == -1 {
      break
    }
    visited[u] = true
    for j in 0..<adj[u].length() {
      let e = adj[u][j]
      if !visited[e.to] && dist[u] + e.weight < dist[e.to] {
        dist[e.to] = dist[u] + e.weight
      }
    }
  }
  dist
}

/// |
/// Find shortest path from source to target.
/// 从源点到目标点的最短路径。
///
/// Returns the distance, or -1 if unreachable.
/// 返回距离，不可达返回 -1。
pub fn shortest_path_dist(
  n : Int,
  adj : Array[Array[GraphEdge]],
  src : Int,
  dst : Int,
) -> Double {
  let dist = dijkstra(n, adj, src)
  if dist[dst] >= 1000000000000000000.0 {
    -1.0
  } else {
    dist[dst]
  }
}

/// |
/// Reconstruct the shortest path as a sequence of vertices.
/// 重构最短路径为顶点序列。
pub fn shortest_path_vertices(
  n : Int,
  adj : Array[Array[GraphEdge]],
  src : Int,
  dst : Int,
) -> Array[Int] {
  let dist : Array[Double] = []
  let prev : Array[Int] = []
  let visited : Array[Bool] = []
  for _ in 0..<n {
    dist.push(1000000000000000000.0)
    prev.push(-1)
    visited.push(false)
  }
  dist[src] = 0.0
  for _ in 0..<n {
    let mut u = -1
    let mut min_d = 1000000000000000000.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_d {
        min_d = dist[i]
        u = i
      }
    }
    if u == -1 {
      break
    }
    visited[u] = true
    for j in 0..<adj[u].length() {
      let e = adj[u][j]
      if !visited[e.to] && dist[u] + e.weight < dist[e.to] {
        dist[e.to] = dist[u] + e.weight
        prev[e.to] = u
      }
    }
  }
  if dist[dst] >= 1000000000000000000.0 {
    return []
  }
  let path : Array[Int] = []
  let mut cur = dst
  while cur != -1 {
    path.insert(0, cur)
    cur = prev[cur]
  }
  path
}