///|
/// Estimate mean curvature from normal variation. / 从法线变化估计平均曲率。
pub fn estimate_mean_curvature(
  center : @core.Point3D,
  neighbors : Array[@core.Point3D],
  normals : Array[@core.Point3D],
  center_normal : @core.Point3D,
) -> Double {
  let n = neighbors.length()
  if n == 0 || normals.length() != n {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<n {
    let dx = neighbors[i].x - center.x
    let dy = neighbors[i].y - center.y
    let dz = neighbors[i].z - center.z
    let dist = (dx * dx + dy * dy + dz * dz).sqrt()
    if dist < 0.000000000001 {
      continue
    }
    let dn_x = normals[i].x - center_normal.x
    let dn_y = normals[i].y - center_normal.y
    let dn_z = normals[i].z - center_normal.z
    let dn_len = (dn_x * dn_x + dn_y * dn_y + dn_z * dn_z).sqrt()
    total += dn_len / dist
  }
  total / (2.0 * n.to_double())
}
