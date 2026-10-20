/// |
/// # Motion Planning
/// # 运动规划
///
/// Motion planning using visibility graph + Dijkstra.
/// 使用可见性图 + Dijkstra 的运动规划。
///
/// ## Complexity: O(n³) for graph construction + O(n² log n) for shortest path
/// ## 复杂度: 图构建 O(n³) + 最短路径 O(n² log n)

/// |
/// Plan a path from start to goal avoiding obstacles.
/// 规划从起点到终点避开障碍物的路径。
///
/// # Arguments / 参数
/// - `obstacles`: polygonal obstacles / 多边形障碍物
/// - `start`: start point / 起始点
/// - `goal`: goal point / 目标点
///
/// Returns the path as a sequence of points, or empty if no path exists.
/// 返回路径点序列，无路径则返回空数组。
pub fn plan_path(
  obstacles : Array[Array[@core.Point2D]],
  start : @core.Point2D,
  goal : @core.Point2D,
) -> Array[@core.Point2D] {
  let vertices : Array[@core.Point2D] = [start, goal]
  for i in 0..<obstacles.length() {
    for j in 0..<obstacles[i].length() {
      vertices.push(obstacles[i][j])
    }
  }
  let n = vertices.length()
  let adj : Array[Array[(Int, Double)]] = []
  for _ in 0..<n {
    adj.push([])
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      if is_visible(vertices, obstacles, i, j) {
        let d = dist(vertices[i], vertices[j])
        adj[i].push((j, d))
        adj[j].push((i, d))
      }
    }
  }
  let path_indices = dijkstra_path(n, adj, 0, 1)
  let result : Array[@core.Point2D] = []
  for i in 0..<path_indices.length() {
    result.push(vertices[path_indices[i]])
  }
  result
}

/// |
/// Compute the length of the planned path.
/// 计算规划路径的长度。
pub fn path_length(path : Array[@core.Point2D]) -> Double {
  let mut sum = 0.0
  for i in 1..<path.length() {
    sum += dist(path[i - 1], path[i])
  }
  sum
}

/// |
/// Check if a path is collision-free.
/// 检查路径是否无碰撞。
pub fn is_path_valid(
  path : Array[@core.Point2D],
  obstacles : Array[Array[@core.Point2D]],
) -> Bool {
  for i in 1..<path.length() {
    for k in 0..<obstacles.length() {
      let obs = obstacles[k]
      let m = obs.length()
      for e in 0..<m {
        if segments_cross(path[i - 1], path[i], obs[e], obs[(e + 1) % m]) {
          return false
        }
      }
    }
  }
  true
}

fn dijkstra_path(
  n : Int,
  adj : Array[Array[(Int, Double)]],
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
      let (to, w) = adj[u][j]
      if !visited[to] && dist[u] + w < dist[to] {
        dist[to] = dist[u] + w
        prev[to] = u
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

fn is_visible(
  vertices : Array[@core.Point2D],
  obstacles : Array[Array[@core.Point2D]],
  i : Int,
  j : Int,
) -> Bool {
  let a = vertices[i]
  let b = vertices[j]
  for k in 0..<obstacles.length() {
    let obs = obstacles[k]
    let m = obs.length()
    for e in 0..<m {
      if segments_cross(a, b, obs[e], obs[(e + 1) % m]) {
        return false
      }
    }
  }
  true
}

fn dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  ((a.x() - b.x()) * (a.x() - b.x()) + (a.y() - b.y()) * (a.y() - b.y())).sqrt()
}

fn segments_cross(
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

