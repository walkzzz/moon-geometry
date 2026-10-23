///|
/// Bend energy of a closed curve: integral of kappa^2 ds.
/// 闭合曲线的弯曲能量：kappa^2 ds 积分。
pub fn bend_energy(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut energy = 0.0
  for i in 0..<n {
    let prev = points[(i - 1 + n) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let kappa = curvature_at(prev, curr, next)
    let ds = arc_length_element(prev, curr, next)
    energy += kappa * kappa * ds
  }
  energy
}

///|
/// Bend energy of an open curve (endpoints not wrapped).
/// 开放曲线的弯曲能量（端点不环绕）。
pub fn bend_energy_open(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut energy = 0.0
  for i in 1..<(n - 1) {
    let kappa = curvature_at(points[i - 1], points[i], points[i + 1])
    let ds = arc_length_element(points[i - 1], points[i], points[i + 1])
    energy += kappa * kappa * ds
  }
  energy
}
