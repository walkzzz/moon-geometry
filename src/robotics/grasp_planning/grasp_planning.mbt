///|
/// # Grasp Planning | 抓取规划
/// Grasp planning geometry. / 抓取规划几何。
///|
pub fn grasp_contact_normal(object_center : (Double, Double, Double), contact_point : (Double, Double, Double)) -> (Double, Double, Double) {
  let dx = contact_point.0 - object_center.0
  let dy = contact_point.1 - object_center.1
  let dz = contact_point.2 - object_center.2
  let norm = (dx * dx + dy * dy + dz * dz).sqrt()
  if norm < 0.000000000001 { (0.0, 0.0, 0.0) } else { (dx / norm, dy / norm, dz / norm) }
}
///|
pub fn grasp_force_closure(forces : Array[(Double, Double, Double)], _normals_ : Array[(Double, Double, Double)]) -> Bool {
  let mut fx = 0.0; let mut fy = 0.0; let mut fz = 0.0
  for i in 0..<forces.length() {
    fx += forces[i].0; fy += forces[i].1; fz += forces[i].2
  }
  fx.abs() < 0.001 && fy.abs() < 0.001 && fz.abs() < 0.001
}
///|
pub fn grasp_quality(forces : Array[(Double, Double, Double)], _ : (Double, Double, Double)) -> Double {
  let mut min_dist = 999999.0
  for i in 0..<forces.length() {
    let d = (forces[i].0 * forces[i].0 + forces[i].1 * forces[i].1 + forces[i].2 * forces[i].2).sqrt()
    if d < min_dist { min_dist = d }
  }
  min_dist
}
