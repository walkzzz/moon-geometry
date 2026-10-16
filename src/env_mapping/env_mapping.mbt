///|
/// # Environment Mapping | 环境映射
/// Cube and sphere environment mapping. / 立方体和球面环境映射。
///|
pub fn cube_map_face(dir : (Double, Double, Double)) -> Int {
  let ax = dir.0.abs(); let ay = dir.1.abs(); let az = dir.2.abs()
  if ax >= ay && ax >= az { if dir.0 > 0.0 { 0 } else { 1 } }
  else if ay >= az { if dir.1 > 0.0 { 2 } else { 3 } }
  else { if dir.2 > 0.0 { 4 } else { 5 } }
}
///|
pub fn cube_map_uv(dir : (Double, Double, Double), face : Int) -> (Double, Double) {
  let ax = dir.0.abs(); let ay = dir.1.abs(); let az = dir.2.abs()
  let max_a = if ax >= ay && ax >= az { ax } else { if ay >= az { ay } else { az } }
  if max_a.abs() < 0.000000000001 { (0.0, 0.0) } else {
    match face {
      0 => (dir.2 / max_a, -dir.1 / max_a)
      1 => (-dir.2 / max_a, -dir.1 / max_a)
      2 => (-dir.0 / max_a, -dir.2 / max_a)
      3 => (-dir.0 / max_a, dir.2 / max_a)
      4 => (dir.0 / max_a, -dir.1 / max_a)
      _ => (-dir.0 / max_a, -dir.1 / max_a)
    }
  }
}
///|
pub fn sphere_map_uv(normal : (Double, Double, Double), view : (Double, Double, Double)) -> (Double, Double) {
  let rx = 2.0 * (normal.0 * view.0 + normal.1 * view.1 + normal.2 * view.2) * normal.0 - view.0
  let ry = 2.0 * (normal.0 * view.0 + normal.1 * view.1 + normal.2 * view.2) * normal.1 - view.1
  let rz = 2.0 * (normal.0 * view.0 + normal.1 * view.1 + normal.2 * view.2) * normal.2 - view.2
  let z = rz + 1.0
  if z.abs() < 0.000000000001 { (0.0, 0.0) } else { (rx / z * 0.5 + 0.5, ry / z * 0.5 + 0.5) }
}
