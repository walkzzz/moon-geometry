///|
/// Average segment length. / 平均线段长度。
pub fn arc_length_average(points : Array[@core.Point2D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  arc_length_total(points) / (n - 1).to_double()
}
