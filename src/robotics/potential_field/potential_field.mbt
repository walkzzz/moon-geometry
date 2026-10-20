///|
/// # Potential Field | 人工势场
/// Artificial potential field navigation. / 人工势场导航。
///|
pub fn attractive_force(pos : (Double, Double), goal : (Double, Double), k_att : Double) -> (Double, Double) {
  (k_att * (goal.0 - pos.0), k_att * (goal.1 - pos.1))
}
///|
pub fn repulsive_force(pos : (Double, Double), obstacle : (Double, Double), k_rep : Double, d0 : Double) -> (Double, Double) {
  let dx = pos.0 - obstacle.0; let dy = pos.1 - obstacle.1
  let d = (dx * dx + dy * dy).sqrt()
  if d > d0 { (0.0, 0.0) } else if d.abs() < 0.000000000001 { (0.0, 0.0) } else {
    let scale = k_rep * (1.0 / d - 1.0 / d0) / (d * d)
    (scale * dx / d, scale * dy / d)
  }
}
///|
pub fn total_force(att : (Double, Double), rep : (Double, Double)) -> (Double, Double) {
  (att.0 + rep.0, att.1 + rep.1)
}
///|
pub fn force_magnitude(f : (Double, Double)) -> Double {
  (f.0 * f.0 + f.1 * f.1).sqrt()
}
