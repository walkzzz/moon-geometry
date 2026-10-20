///|
/// # 3D Collision Detection | 3D 碰撞检测
/// 3D collision detection algorithms. / 三维碰撞检测算法。
///|
pub fn sphere_sphere_dist(c1 : (Double, Double, Double), r1 : Double, c2 : (Double, Double, Double), r2 : Double) -> Double {
  let dx = c1.0 - c2.0; let dy = c1.1 - c2.1; let dz = c1.2 - c2.2
  (dx * dx + dy * dy + dz * dz).sqrt() - r1 - r2
}
///|
pub fn ray_sphere_intersect(origin : (Double, Double, Double), dir : (Double, Double, Double), center : (Double, Double, Double), radius : Double) -> Double {
  let ox = origin.0 - center.0; let oy = origin.1 - center.1; let oz = origin.2 - center.2
  let a = dir.0 * dir.0 + dir.1 * dir.1 + dir.2 * dir.2
  let b = 2.0 * (ox * dir.0 + oy * dir.1 + oz * dir.2)
  let c = ox * ox + oy * oy + oz * oz - radius * radius
  let disc = b * b - 4.0 * a * c
  if disc < 0.0 { -1.0 } else {
    let t = (-b - disc.sqrt()) / (2.0 * a)
    if t < 0.0 { (-b + disc.sqrt()) / (2.0 * a) } else { t }
  }
}
///|
pub fn point_in_tetrahedron(p : (Double, Double, Double), v0 : (Double, Double, Double), v1 : (Double, Double, Double), v2 : (Double, Double, Double), v3 : (Double, Double, Double)) -> Bool {
  let eps = 0.0000000001
  let d0 = (v1.0 - v0.0, v1.1 - v0.1, v1.2 - v0.2)
  let d1 = (v2.0 - v0.0, v2.1 - v0.1, v2.2 - v0.2)
  let d2 = (v3.0 - v0.0, v3.1 - v0.1, v3.2 - v0.2)
  let d3 = (p.0 - v0.0, p.1 - v0.1, p.2 - v0.2)
  let det = d0.0 * (d1.1 * d2.2 - d1.2 * d2.1) - d0.1 * (d1.0 * d2.2 - d1.2 * d2.0) + d0.2 * (d1.0 * d2.1 - d1.1 * d2.0)
  if det.abs() < eps { return false }
  let inv_det = 1.0 / det
  let u = inv_det * (d3.0 * (d1.1 * d2.2 - d1.2 * d2.1) - d3.1 * (d1.0 * d2.2 - d1.2 * d2.0) + d3.2 * (d1.0 * d2.1 - d1.1 * d2.0))
  let v = inv_det * (d0.0 * (d3.1 * d2.2 - d3.2 * d2.1) - d0.1 * (d3.0 * d2.2 - d3.2 * d2.0) + d0.2 * (d3.0 * d2.1 - d3.1 * d2.0))
  let w = inv_det * (d0.0 * (d1.1 * d3.2 - d1.2 * d3.1) - d0.1 * (d1.0 * d3.2 - d1.2 * d3.0) + d0.2 * (d1.0 * d3.1 - d1.1 * d3.0))
  u >= -eps && v >= -eps && w >= -eps && u + v + w <= 1.0 + eps
}
