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
  start : (Int32, Int32),
  goal : (Int32, Int32),
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
  let open_set : Array[Int32] = [start_idx]
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
      let path : Array[(Int32, Int32)] = []
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
    let dirs : Array[(Int32, Int32, Double)] = if allow_diagonal {
      [
        (0, 1, 1.0),
        (0, -1, 1.0),
        (1, 0, 1.0),
        (-1, 0, 1.0),
        (1, 1, 1.4142135623730951),
        (1, -1, 1.4142135623730951),
        (-1, 1, 1.4142135623730951),
        (-1, -1, 1.4142135623730951),
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

///|
fn heuristic_val(
  x : Int32,
  y : Int32,
  gx : Int32,
  gy : Int32,
  heuristic : AStarHeuristic,
) -> Double {
  let dx = (x - gx).abs().to_double()
  let dy = (y - gy).abs().to_double()
  match heuristic {
    Manhattan => dx + dy
    Euclidean => (dx * dx + dy * dy).sqrt()
    Chebyshev => if dx > dy { dx } else { dy }
  }
}
