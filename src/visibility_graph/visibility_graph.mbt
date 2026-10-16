/// |
/// # Visibility Graph
/// # 可见性图
///
/// Build a visibility graph for motion planning among polygonal obstacles.
/// 为多边形障碍物中的运动规划构建可见性图。
///
/// ## Complexity: O(n³) where n = total vertices
/// ## 复杂度: O(n³)，n = 总顶点数

/// |
/// Build visibility graph from obstacle vertices.
/// 从障碍物顶点构建可见性图。
///
/// # Arguments / 参数
/// - `obstacles`: array of obstacle polygons / 障碍物多边形数组
/// - `start`: start point / 起始点
/// - `goal`: goal point / 目标点
///
/// Returns adjacency list with Euclidean weights.
/// 返回带欧氏权重的邻接表。
pub fn build_visibility_graph(
  obstacles : Array[Array[@core.Point2D]],
  start : @core.Point2D,
  goal : @core.Point2D,
) -> Array[Array[(Int, Double)]] {
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
  adj
}

/// |
/// Get all vertices of the visibility graph.
/// 获取可见性图的所有顶点。
pub fn visibility_vertices(
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
  vertices
}

/// |
/// Count edges in the visibility graph.
/// 计算可见性图中的边数。
pub fn visibility_edge_count(
  obstacles : Array[Array[@core.Point2D]],
  start : @core.Point2D,
  goal : @core.Point2D,
) -> Int {
  let adj = build_visibility_graph(obstacles, start, goal)
  let mut count = 0
  for i in 0..<adj.length() {
    count += adj[i].length()
  }
  count / 2
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
      let p1 = obs[e]
      let p2 = obs[(e + 1) % m]
      if segments_cross(a, b, p1, p2) {
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
  let d1 = cross3(b1, b2, a1)
  let d2 = cross3(b1, b2, a2)
  let d3 = cross3(a1, a2, b1)
  let d4 = cross3(a1, a2, b2)
  ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
    ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0))
}

fn cross3(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Double {
  (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
}