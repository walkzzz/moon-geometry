///|
/// # Curvature Estimation
/// # 曲率估计
///
/// Estimate principal, Gaussian, and mean curvatures from point clouds.
/// 从点云估计主曲率、高斯曲率和平均曲率。

///|
/// Estimate Gaussian curvature from angle defect. / 从角亏估计高斯曲率。
pub fn estimate_gaussian_curvature(
  center : @core.Point3D,
  neighbors : Array[@core.Point3D],
) -> Double {
  let n = neighbors.length()
  if n < 3 {
    return 0.0
  }
  let mut angle_sum = 0.0
  for i in 0..<n {
    let v1 = neighbors[i]
    let v2 = neighbors[(i + 1) % n]
    let e1x = v1.x - center.x
    let e1y = v1.y - center.y
    let e1z = v1.z - center.z
    let e2x = v2.x - center.x
    let e2y = v2.y - center.y
    let e2z = v2.z - center.z
    let dot = e1x * e2x + e1y * e2y + e1z * e2z
    let l1 = (e1x * e1x + e1y * e1y + e1z * e1z).sqrt()
    let l2 = (e2x * e2x + e2y * e2y + e2z * e2z).sqrt()
    if l1 > 0.000000000001 && l2 > 0.000000000001 {
      let cos_a = dot / (l1 * l2)
      if cos_a > 1.0 {
        angle_sum += 0.0
      } else if cos_a < -1.0 {
        angle_sum += 3.141592653589793
      } else {
        angle_sum += @math.acos(cos_a)
      }
    }
  }
  3.141592653589793 * 2.0 - angle_sum
}

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

///|
/// Principal curvatures from Gaussian (K) and mean (H). / 从高斯曲率K和平均曲率H求主曲率。
pub fn principal_curvatures(
  k_gaussian : Double,
  k_mean : Double,
) -> (Double, Double) {
  let disc = k_mean * k_mean - k_gaussian
  if disc < 0.0 {
    return (k_mean, k_mean)
  }
  let s = disc.sqrt()
  (k_mean + s, k_mean - s)
}
