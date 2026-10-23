///|
/// Estimate Gaussian curvature from angle defect. / 从角亏估计高斯曲率。
pub fn estimate_gaussian_curvature(center : @core.Point3D, neighbors : Array[@core.Point3D]) -> Double {
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
      if cos_a > 1.0 { angle_sum += 0.0 }
      else if cos_a < -1.0 { angle_sum += 3.141592653589793 }
      else { angle_sum += @math.acos(cos_a) }
    }
  }
  3.141592653589793 * 2.0 - angle_sum
}
