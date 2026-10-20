///|
/// # PRM Planner | PRM 路径规划
/// Probabilistic roadmap path planning. / 概率路线图路径规划。
///|
pub fn prm_sample_free(x_min : Double, x_max : Double, y_min : Double, y_max : Double) -> (Double, Double) {
  ((x_min + x_max) / 2.0, (y_min + y_max) / 2.0)
}
///|
pub fn prm_connection_radius(n : Int, d : Int, volume : Double) -> Double {
  let gamma = @math.pow(2.0 * (1.0 + 1.0 / d.to_double()) * volume, 1.0 / d.to_double())
  gamma * @math.pow(@math.ln(n.to_double()) / n.to_double(), 1.0 / d.to_double())
}
///|
pub fn prm_edge_valid(p1 : (Double, Double), p2 : (Double, Double), obstacles : Array[(Double, Double, Double)]) -> Bool {
  for i in 0..<obstacles.length() {
    let cx = obstacles[i].0; let cy = obstacles[i].1; let r = obstacles[i].2
    let mx = (p1.0 + p2.0) / 2.0; let my = (p1.1 + p2.1) / 2.0
    let dx = mx - cx; let dy = my - cy
    if (dx * dx + dy * dy).sqrt() < r { return false }
  }
  true
}
///|
pub fn prm_shortest_path(adj : Array[Array[Double]], start : Int, goal : Int) -> Double {
  let n = adj.length()
  let dist = Array::make(n, 999999.0)
  let visited = Array::make(n, false)
  dist[start] = 0.0
  for _ in 0..<n {
    let mut min_d = 999999.0; let mut min_idx = 0
    for k in 0..<n {
      if !visited[k] && dist[k] < min_d { min_d = dist[k]; min_idx = k }
    }
    visited[min_idx] = true
    for k in 0..<n {
      if adj[min_idx][k] < 999999.0 {
        let nd = dist[min_idx] + adj[min_idx][k]
        if nd < dist[k] { dist[k] = nd }
      }
    }
  }
  dist[goal]
}
