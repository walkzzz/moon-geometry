///|
/// # RRT* | RRT* 最优路径规划
/// Optimal rapidly-exploring random tree. / 最优快速探索随机树。
///|
pub fn rrt_distance(p1 : (Double, Double), p2 : (Double, Double)) -> Double {
  let dx = p1.0 - p2.0; let dy = p1.1 - p2.1
  (dx * dx + dy * dy).sqrt()
}
///|
pub fn rrt_nearest(tree : Array[(Double, Double)], sample : (Double, Double)) -> Int {
  let mut min_d = 999999.0; let mut min_idx = 0
  for i in 0..<tree.length() {
    let d = rrt_distance(tree[i], sample)
    if d < min_d { min_d = d; min_idx = i }
  }
  min_idx
}
///|
pub fn rrt_steer(from : (Double, Double), to : (Double, Double), step : Double) -> (Double, Double) {
  let d = rrt_distance(from, to)
  if d.abs() < 0.000000000001 { from } else {
    let t = if d < step { 1.0 } else { step / d }
    (from.0 + t * (to.0 - from.0), from.1 + t * (to.1 - from.1))
  }
}
///|
pub fn rrt_cost(parent_cost : Double, parent : (Double, Double), node : (Double, Double)) -> Double {
  parent_cost + rrt_distance(parent, node)
}
///|
pub fn rrt_rewire_radius(n : Int, d : Int, area : Double) -> Double {
  let gamma = @math.pow(2.0 * (1.0 + 1.0 / d.to_double()) * area, 1.0 / d.to_double())
  gamma * @math.pow(@math.ln(n.to_double()) / n.to_double(), 1.0 / d.to_double())
}
