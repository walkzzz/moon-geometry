///|
/// Compute intersection point of segments a1-a2 and b1-b2. / 计算线段 a1-a2 与 b1-b2 的交点。
pub fn robust_segment_intersect(
  a1x : Double,
  a1y : Double,
  a2x : Double,
  a2y : Double,
  b1x : Double,
  b1y : Double,
  b2x : Double,
  b2y : Double,
) -> (Double, Double, Bool) {
  let d1x = a2x - a1x
  let d1y = a2y - a1y
  let d2x = b2x - b1x
  let d2y = b2y - b1y
  let det = d1x * d2y - d2x * d1y
  if det.abs() < 1.0e-15 {
    (0.0, 0.0, false)
  } else {
    let t = ((b1x - a1x) * d2y - (b1y - a1y) * d2x) / det
    (a1x + t * d1x, a1y + t * d1y, true)
  }
}
