///|
/// # A* Path Planning
/// # A* 路径规划
///
/// A* algorithm for grid-based and graph-based path planning with heuristics.
/// 基于网格和图的 A* 启发式路径规划算法。
///
/// ## Complexity: O(b^d) worst case, much better with good heuristic
/// ## 复杂度: 最坏 O(b^d)，好的启发式下显著更优

///|
/// A* grid for path planning. / A* 路径规划网格。
pub struct AStarGrid {
  width : Int
  height : Int
  blocked : Array[Bool]
}

///|
/// Construct an A* grid. / 构造 A* 网格。
pub fn AStarGrid::new(width : Int, height : Int) -> AStarGrid {
  { width, height, blocked: Array::make(width * height, false) }
}

///|
/// Mark a cell as blocked. / 标记格子为障碍。
pub fn AStarGrid::set_blocked(self : AStarGrid, x : Int, y : Int) -> Unit {
  if x >= 0 && x < self.width && y >= 0 && y < self.height {
    self.blocked[y * self.width + x] = true
  }
}

///|
/// Check if a cell is blocked. / 检查格子是否为障碍。
pub fn AStarGrid::is_blocked(self : AStarGrid, x : Int, y : Int) -> Bool {
  if x < 0 || x >= self.width || y < 0 || y >= self.height {
    return true
  }
  self.blocked[y * self.width + x]
}

///|
/// A* path planning result. / A* 路径规划结果。
pub struct AStarResult {
  path : Array[(Int, Int)]
  success : Bool
  cost : Double
}

///|
/// Construct A* result. / 构造 A* 结果。
pub fn AStarResult::new(
  path : Array[(Int, Int)],
  success : Bool,
  cost : Double,
) -> AStarResult {
  { path, success, cost }
}

///|
/// Heuristic type for A* search. / A* 搜索启发式类型。
pub(all) enum AStarHeuristic {
  Manhattan
  Euclidean
  Chebyshev
}

///|
/// Plan path on a grid using A*. / 使用 A* 在网格上规划路径。
///
/// # Arguments / 参数
/// - `grid`: the grid / 网格
/// - `start`: start cell (x, y) / 起始格
/// - `goal`: goal cell (x, y) / 目标格
/// - `heuristic`: heuristic type / 启发式类型
/// - `allow_diagonal`: allow 8-connected movement / 允许八连通移动
pub fn astar_grid(
  grid : AStarGrid,
  start : (Int, Int),
  goal : (Int, Int),
  heuristic : AStarHeuristic,
  allow_diagonal : Bool,
) -> AStarResult {
  let (sx, sy) = start
  let (gx, gy) = goal
  if grid.is_blocked(sx, sy) || grid.is_blocked(gx, gy) {
    return AStarResult::new([], false, -1.0)
  }
  let n = grid.width * grid.height
  let g_score = Array::make(n, 1000000000000.0)
  let f_score = Array::make(n, 1000000000000.0)
  let came_from = Array::make(n, -1)
  let closed = Array::make(n, false)
  let start_idx = sy * grid.width + sx
  let goal_idx = gy * grid.width + gx
  g_score[start_idx] = 0.0
  f_score[start_idx] = heuristic_val(sx, sy, gx, gy, heuristic)
  let open_set : Array[Int] = [start_idx]
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
    if current == goal_idx {
      let path : Array[(Int, Int)] = []
      let mut cur = current
      while cur != -1 {
        let cx = cur % grid.width
        let cy = cur / grid.width
        path.insert(0, (cx, cy))
        cur = came_from[cur]
      }
      return AStarResult::new(path, true, g_score[goal_idx])
    }
    open_set.remove(best_i) |> ignore
    closed[current] = true
    let cx = current % grid.width
    let cy = current / grid.width
    let dirs : Array[(Int, Int, Double)] = if allow_diagonal {
      [
        (0, 1, 1.0), (0, -1, 1.0), (1, 0, 1.0), (-1, 0, 1.0),
        (1, 1, 1.4142135623730951), (1, -1, 1.4142135623730951),
        (-1, 1, 1.4142135623730951), (-1, -1, 1.4142135623730951),
      ]
    } else {
      [(0, 1, 1.0), (0, -1, 1.0), (1, 0, 1.0), (-1, 0, 1.0)]
    }
    for d in 0..<dirs.length() {
      let (dx, dy, cost) = dirs[d]
      let nx = cx + dx
      let ny = cy + dy
      if grid.is_blocked(nx, ny) {
        continue
      }
      let nidx = ny * grid.width + nx
      if closed[nidx] {
        continue
      }
      let tentative_g = g_score[current] + cost
      if tentative_g < g_score[nidx] {
        came_from[nidx] = current
        g_score[nidx] = tentative_g
        f_score[nidx] = tentative_g + heuristic_val(nx, ny, gx, gy, heuristic)
        let mut found = false
        for i in 0..<open_set.length() {
          if open_set[i] == nidx {
            found = true
            break
          }
        }
        if !found {
          open_set.push(nidx)
        }
      }
    }
  }
  AStarResult::new([], false, -1.0)
}

fn heuristic_val(
  x : Int,
  y : Int,
  gx : Int,
  gy : Int,
  heuristic : AStarHeuristic,
) -> Double {
  let dx = (x - gx).abs().to_double()
  let dy = (y - gy).abs().to_double()
  match heuristic {
    Manhattan => dx + dy
    Euclidean => (dx * dx + dy * dy).sqrt()
    Chebyshev => if dx > dy {
      dx
    } else {
      dy
    }
  }
}

///|
/// A* graph node for graph-based search. / 图搜索的 A* 图节点。
pub struct AStarGraphNode {
  id : Int
  x : Double
  y : Double
}

///|
/// Construct an A* graph node. / 构造 A* 图节点。
pub fn AStarGraphNode::new(id : Int, x : Double, y : Double) -> AStarGraphNode {
  { id, x, y }
}

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

///|
/// Compute path cost on a grid. / 计算网格路径代价。
pub fn astar_path_cost(path : Array[(Int, Int)]) -> Double {
  let mut cost = 0.0
  for i in 1..<path.length() {
    let (x1, y1) = path[i - 1]
    let (x2, y2) = path[i]
    let dx = (x2 - x1).to_double()
    let dy = (y2 - y1).to_double()
    cost += (dx * dx + dy * dy).sqrt()
  }
  cost
}