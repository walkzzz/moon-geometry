///|
/// Plan path on a graph using A*. / 使用 A* 在图上规划路径。
///
/// # Arguments / 参数
/// - `nodes`: graph nodes with positions / 图节点（含位置）
/// - `adj`: adjacency list (neighbor_id, edge_weight) / 邻接表
/// - `start`: start node id / 起始节点 ID
/// - `goal`: goal node id / 目标节点 ID
pub fn astar_graph(
  nodes : Array[AStarGraphNode],
  adj : Array[Array[(Int, Double)]],
  start : Int,
  goal : Int,
) -> AStarResult {
  let n = nodes.length()
  if start < 0 || start >= n || goal < 0 || goal >= n {
    return AStarResult::new([], false, -1.0)
  }
  let g_score = Array::make(n, 1000000000000.0)
  let f_score = Array::make(n, 1000000000000.0)
  let came_from = Array::make(n, -1)
  let closed = Array::make(n, false)
  g_score[start] = 0.0
  let goal_x = nodes[goal].x
  let goal_y = nodes[goal].y
  f_score[start] = euclidean_heuristic(nodes[start].x, nodes[start].y, goal_x, goal_y)
  let open_set : Array[Int] = [start]
  while open_set.length() > 0 {
    let mut best_i = 0
    let mut best_f = f_score[open_set[0]]
    for i in 1..<open_set.length() {
      let f = f_score[open_set[i]]
      if f < best_f {
        best_f = f
        best_i = i
      }
    }
    let current = open_set[best_i]
    if current == goal {
      let path : Array[(Int, Int)] = []
      let mut cur = current
      while cur != -1 {
        path.insert(0, (cur, 0))
        cur = came_from[cur]
      }
      return AStarResult::new(path, true, g_score[goal])
    }
    open_set.remove(best_i) |> ignore
    closed[current] = true
    for j in 0..<adj[current].length() {
      let (neighbor, weight) = adj[current][j]
      if neighbor < 0 || neighbor >= n || closed[neighbor] {
        continue
      }
      let tentative_g = g_score[current] + weight
      if tentative_g < g_score[neighbor] {
        came_from[neighbor] = current
        g_score[neighbor] = tentative_g
        f_score[neighbor] = tentative_g + euclidean_heuristic(nodes[neighbor].x, nodes[neighbor].y, goal_x, goal_y)
        let mut found = false
        for i in 0..<open_set.length() {
          if open_set[i] == neighbor {
            found = true
            break
          }
        }
        if !found {
          open_set.push(neighbor)
        }
      }
    }
  }
  AStarResult::new([], false, -1.0)
}

fn euclidean_heuristic(x1 : Double, y1 : Double, x2 : Double, y2 : Double) -> Double {
  ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)).sqrt()
}
