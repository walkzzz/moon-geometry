///|
/// Compute path cost on a grid. / 计算网格路径代价。
pub fn astar_path_cost(path : Array[(Int32, Int32)]) -> Double {
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
