///|
/// # Probabilistic Roadmap (PRM)
/// # 概率路线图（PRM）
///
/// PRM construction and shortest path query for motion planning.
/// 概率路线图构建与最短路径查询。
///
/// ## Complexity: O(n²) construction + O(n² log n) query
/// ## 复杂度: 构建 O(n²) + 查询 O(n² log n)

///|
/// PRM configuration. / PRM 配置。
pub struct PRMConfig {
  num_samples : Int32
  connection_radius : Double
  seed : UInt32
  x_min : Double
  x_max : Double
  y_min : Double
  y_max : Double
}

///|
/// Construct PRM configuration. / 构造 PRM 配置。
pub fn PRMConfig::new(
  num_samples : Int32,
  connection_radius : Double,
  seed : UInt32,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> PRMConfig {
  { num_samples, connection_radius, seed, x_min, x_max, y_min, y_max, }
}

///|
/// PRM roadmap storing nodes and edges. / PRM 路线图，存储节点和边。
pub struct PRMRoadmap {
  nodes : Array[@core.Point2D]
  edges : Array[Array[(Int32, Double)]]
}

///|
/// Construct PRM roadmap. / 构造 PRM 路线图。
pub fn PRMRoadmap::new(
  nodes : Array[@core.Point2D],
  edges : Array[Array[(Int32, Double)]],
) -> PRMRoadmap {
  { nodes, edges, }
}

///|
/// PRM query result. / PRM 查询结果。
pub struct PRMResult {
  path : Array[@core.Point2D]
  success : Bool
  distance : Double
}

///|
/// Construct PRM result. / 构造 PRM 结果。
pub fn PRMResult::new(
  path : Array[@core.Point2D],
  success : Bool,
  distance : Double,
) -> PRMResult {
  { path, success, distance, }
}

///|
fn rng_next(state : UInt32) -> UInt32 {
  state * 1103515245U + 12345U
}

///|
fn rng_double(state : UInt32) -> (Double, UInt32) {
  let s = rng_next(state)
  ((s % 1000000U).to_double() / 1000000.0, s)
}

///|
fn point_dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  a.dist(b)
}

///|
fn segment_hits_obstacle(
  a : @core.Point2D,
  b : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> Bool {
  for k in 0..<obstacles.length() {
    let obs = obstacles[k]
    let m = obs.length()
    for e in 0..<m {
      if seg_cross(a, b, obs[e], obs[(e + 1) % m]) {
        return true
      }
    }
  }
  false
}

///|
fn seg_cross(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(b1, b2, a1)
  let d2 = @core.turn(b1, b2, a2)
  let d3 = @core.turn(a1, a2, b1)
  let d4 = @core.turn(a1, a2, b2)
  ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
  ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0))
}

///|
/// Build a PRM roadmap by sampling nodes and connecting neighbors. / 通过采样节点并连接邻居构建 PRM 路线图。
pub fn prm_build(
  config : PRMConfig,
  obstacles : Array[Array[@core.Point2D]],
) -> PRMRoadmap {
  let nodes : Array[@core.Point2D] = []
  let mut state = config.seed
  let mut attempts = 0
  let max_attempts = config.num_samples * 10
  while nodes.length() < config.num_samples && attempts < max_attempts {
    attempts += 1
    let (rx, s1) = rng_double(state)
    state = s1
    let (ry, s2) = rng_double(state)
    state = s2
    let p = @core.Point2D::new(
      config.x_min + rx * (config.x_max - config.x_min),
      config.y_min + ry * (config.y_max - config.y_min),
    )
    if !point_in_obstacle(p, obstacles) {
      nodes.push(p)
    }
  }
  let n = nodes.length()
  let edges : Array[Array[(Int32, Double)]] = []
  for _ in 0..<n {
    edges.push([])
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      let d = point_dist(nodes[i], nodes[j])
      if d <= config.connection_radius &&
        !segment_hits_obstacle(nodes[i], nodes[j], obstacles) {
        edges[i].push((j, d))
        edges[j].push((i, d))
      }
    }
  }
  PRMRoadmap::new(nodes, edges)
}

///|
fn point_in_obstacle(
  p : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> Bool {
  for k in 0..<obstacles.length() {
    if point_in_polygon(p, obstacles[k]) {
      return true
    }
  }
  false
}

///|
fn point_in_polygon(p : @core.Point2D, poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let yi = poly[i].y()
    let yj = poly[j].y()
    let xi = poly[i].x()
    let xj = poly[j].x()
    if (yi > p.y()) != (yj > p.y()) {
      let x_intersect = xi + (p.y() - yi) / (yj - yi) * (xj - xi)
      if p.x() < x_intersect {
        inside = !inside
      }
    }
    j = i
  }
  inside
}

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
