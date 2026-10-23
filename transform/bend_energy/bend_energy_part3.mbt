///|
/// Total absolute curvature: integral of |kappa| ds.
/// 总绝对曲率：|kappa| ds 积分。
pub fn total_curvature_energy(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<n {
    let prev = points[(i - 1 + n) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let kappa = curvature_at(prev, curr, next)
    let ds = arc_length_element(prev, curr, next)
    total += kappa.abs() * ds
  }
  total
}


///|
/// Elastic energy: bend + tension (stretch) energy.
/// 弹性能量：弯曲 + 张力（拉伸）能量。
///
/// E = integral(kappa^2 ds) + tension * integral(ds).
/// E = kappa^2 ds 积分 + tension * ds 积分。
pub fn elastic_energy(
  points : Array[@core.Point2D],
  tension : Double,
) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut bend = 0.0
  let mut length = 0.0
  for i in 0..<n {
    let prev = points[(i - 1 + n) % n]
    let curr = points[i]
    let next = points[(i + 1) % n]
    let kappa = curvature_at(prev, curr, next)
    let ds = arc_length_element(prev, curr, next)
    bend += kappa * kappa * ds
    length += ds
  }
  bend + tension * length
}
