///|
/// Compute holonomy modulo 2π from turning angles. / 由转角计算模 2π 的和乐。
pub fn holonomy(angles : Array[Double]) -> Double {
  let mut total = 0.0
  for a in angles {
    total += a
  }
  total % (2.0 * @math.PI)
}

///|
/// Parallel transport a 2D vector by a rotation angle. / 按旋转角平行移动二维向量。
pub fn parallel_transport(
  vx : Double,
  vy : Double,
  angle : Double,
) -> (Double, Double) {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  (vx * c - vy * s, vx * s + vy * c)
}
