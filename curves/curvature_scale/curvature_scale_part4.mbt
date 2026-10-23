///|
/// Inflection point indices (curvature zero crossings) at given sigma.
/// 给定 sigma 下的拐点索引（曲率过零点）。
pub fn css_inflection_points(
  points : Array[@core.Point2D],
  sigma : Double,
) -> Array[Int32] {
  let kappa = css_curvature(points, sigma)
  let n = kappa.length()
  let result : Array[Int32] = []
  for i in 0..<n {
    let j = (i + 1) % n
    if kappa[i] * kappa[j] < 0.0 {
      if kappa[i].abs() < kappa[j].abs() {
        result.push(i)
      } else {
        result.push(j)
      }
    }
  }
  result
}
