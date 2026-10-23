///|
/// Find parameter t for a given arc length. / 给定弧长，求参数 t。
pub fn arc_length_to_param(points : Array[@core.Point2D], s : Double) -> Double {
  let total = arc_length(points)
  if total < 0.000000000001 {
    return 0.0
  }
  s / total
}
