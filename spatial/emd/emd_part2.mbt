///|
/// EMD for uniform point distributions (using x-coordinates). / 均匀点分布的 EMD（使用 x 坐标）。
pub fn emd_uniform(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let xs_a : Array[Double] = []
  let xs_b : Array[Double] = []
  for p in a {
    xs_a.push(p.x())
  }
  for p in b {
    xs_b.push(p.x())
  }
  emd_1d(xs_a, xs_b)
}
