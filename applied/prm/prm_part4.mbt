///|
/// Query shortest path on a PRM roadmap. / 在 PRM 路线图上查询最短路径。
pub fn prm_query(
  roadmap : PRMRoadmap,
  start : @core.Point2D,
  goal : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> PRMResult {
  let n = roadmap.nodes.length()
  let start_neighbors : Array[(Int32, Double)] = []
  let goal_neighbors : Array[(Int32, Double)] = []
  for i in 0..<n {
    let ds = point_dist(start, roadmap.nodes[i])
    if !segment_hits_obstacle(start, roadmap.nodes[i], obstacles) {
      start_neighbors.push((i, ds))
    }
    let dg = point_dist(goal, roadmap.nodes[i])
    if !segment_hits_obstacle(goal, roadmap.nodes[i], obstacles) {
      goal_neighbors.push((i, dg))
    }
  }
  let total_n = n + 2
  let start_idx = n
  let goal_idx = n + 1
  let adj : Array[Array[(Int32, Double)]] = []
  for i in 0..<n {
    adj.push(roadmap.edges[i])
  }
  adj.push(start_neighbors)
  adj.push(goal_neighbors)
  for i in 0..<start_neighbors.length() {
    let (to, w) = start_neighbors[i]
    adj[to].push((start_idx, w))
  }
  for i in 0..<goal_neighbors.length() {
    let (to, w) = goal_neighbors[i]
    adj[to].push((goal_idx, w))
  }
  let direct_ok = !segment_hits_obstacle(start, goal, obstacles)
  if direct_ok {
    adj[start_idx].push((goal_idx, point_dist(start, goal)))
    adj[goal_idx].push((start_idx, point_dist(start, goal)))
  }
  let (dist_arr, prev_arr) = dijkstra_full(total_n, adj, start_idx)
  if dist_arr[goal_idx] >= 1000000000000000000.0 {
    return PRMResult::new([], false, -1.0)
  }
  let path_indices : Array[Int32] = []
  let mut cur = goal_idx
  while cur != -1 {
    path_indices.insert(0, cur)
    cur = prev_arr[cur]
  }
  let path : Array[@core.Point2D] = []
  for i in 0..<path_indices.length() {
    let idx = path_indices[i]
    if idx == start_idx {
      path.push(start)
    } else if idx == goal_idx {
      path.push(goal)
    } else {
      path.push(roadmap.nodes[idx])
    }
  }
  PRMResult::new(path, true, dist_arr[goal_idx])
}

///|
fn dijkstra_full(
  n : Int32,
  adj : Array[Array[(Int32, Double)]],
  src : Int32,
) -> (Array[Double], Array[Int32]) {
  let dist : Array[Double] = []
  let prev : Array[Int32] = []
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
      let (to, w) = adj[u][j]
      if !visited[to] && dist[u] + w < dist[to] {
        dist[to] = dist[u] + w
        prev[to] = u
      }
    }
  }
  (dist, prev)
}
