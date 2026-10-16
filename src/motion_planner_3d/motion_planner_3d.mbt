///|
/// # 3D Motion Planner | 3D 运动规划
/// 3D motion planning primitives. / 三维运动规划原语。
///|
pub fn dist_3d(p1 : (Double, Double, Double), p2 : (Double, Double, Double)) -> Double {
  let dx = p1.0 - p2.0; let dy = p1.1 - p2.1; let dz = p1.2 - p2.2
  (dx * dx + dy * dy + dz * dz).sqrt()
}
///|
pub fn interpolate_3d(p1 : (Double, Double, Double), p2 : (Double, Double, Double), t : Double) -> (Double, Double, Double) {
  (p1.0 + t * (p2.0 - p1.0), p1.1 + t * (p2.1 - p1.1), p1.2 + t * (p2.2 - p1.2))
}
///|
pub fn sphere_collision(pos : (Double, Double, Double), center : (Double, Double, Double), radius : Double) -> Bool {
  dist_3d(pos, center) < radius
}
///|
pub fn aabb_collision(min1 : (Double, Double, Double), max1 : (Double, Double, Double), min2 : (Double, Double, Double), max2 : (Double, Double, Double)) -> Bool {
  min1.0 < max2.0 && max1.0 > min2.0 && min1.1 < max2.1 && max1.1 > min2.1 && min1.2 < max2.2 && max1.2 > min2.2
}
///|
pub fn path_length_3d(path : Array[(Double, Double, Double)]) -> Double {
  let mut len = 0.0
  for i in 1..<path.length() { len += dist_3d(path[i - 1], path[i]) }
  len
}
