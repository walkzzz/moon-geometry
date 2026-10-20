///|
/// # Trajectory Optimization | 轨迹优化
/// Optimize robot trajectories. / 机器人轨迹优化。
///|
pub fn trajectory_length(waypoints : Array[(Double, Double)]) -> Double {
  let mut len = 0.0
  for i in 1..<waypoints.length() {
    let dx = waypoints[i].0 - waypoints[i - 1].0
    let dy = waypoints[i].1 - waypoints[i - 1].1
    len += (dx * dx + dy * dy).sqrt()
  }
  len
}
///|
pub fn trajectory_smoothness(waypoints : Array[(Double, Double)]) -> Double {
  let mut sum = 0.0
  for i in 1..<(waypoints.length() - 1) {
    let ax = waypoints[i - 1].0 - 2.0 * waypoints[i].0 + waypoints[i + 1].0
    let ay = waypoints[i - 1].1 - 2.0 * waypoints[i].1 + waypoints[i + 1].1
    sum += ax * ax + ay * ay
  }
  sum
}
///|
pub fn trajectory_cost(waypoints : Array[(Double, Double)], w_len : Double, w_smooth : Double) -> Double {
  w_len * trajectory_length(waypoints) + w_smooth * trajectory_smoothness(waypoints)
}
///|
pub fn bezier_point(p0 : (Double, Double), p1 : (Double, Double), p2 : (Double, Double), t : Double) -> (Double, Double) {
  let mt = 1.0 - t
  let x = mt * mt * p0.0 + 2.0 * mt * t * p1.0 + t * t * p2.0
  let y = mt * mt * p0.1 + 2.0 * mt * t * p1.1 + t * t * p2.1
  (x, y)
}
