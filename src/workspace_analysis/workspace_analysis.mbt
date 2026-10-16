///|
/// # Workspace Analysis | 工作空间分析
/// Robot workspace analysis. / 机器人工作空间分析。
///|
pub fn reachability_map(joint_limits : Array[(Double, Double)], n_samples : Int) -> Int {
  let mut total = 1
  for i in 0..<joint_limits.length() {
    total *= n_samples
  }
  total
}
///|
pub fn workspace_volume(bounds : (Double, Double, Double, Double, Double, Double)) -> Double {
  (bounds.1 - bounds.0) * (bounds.3 - bounds.2) * (bounds.5 - bounds.4)
}
///|
pub fn dexterity_index(jacobian_det : Double, max_det : Double) -> Double {
  if max_det.abs() < 0.000000000001 { 0.0 } else { jacobian_det.abs() / max_det }
}
///|
pub fn condition_number(j11 : Double, j12 : Double, j21 : Double, j22 : Double) -> Double {
  let det = j11 * j22 - j12 * j21
  let trace = j11 * j11 + j12 * j12 + j21 * j21 + j22 * j22
  if det.abs() < 0.000000000001 { 999999.0 } else {
    let sigma_max_sq = (trace + (trace * trace - 4.0 * det * det).sqrt()) / 2.0
    let sigma_min_sq = (trace - (trace * trace - 4.0 * det * det).sqrt()) / 2.0
    if sigma_min_sq < 0.000000000001 { 999999.0 } else { (sigma_max_sq / sigma_min_sq).sqrt() }
  }
}
