///|
/// Directed Chamfer distance from A to B (average nearest neighbor). / 从 A 到 B 的有向 Chamfer 距离。
pub fn chamfer_directed(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  if a.length() == 0 || b.length() == 0 {
    return 0.0
  }
  let mut total = 0.0
  for pa in a {
    total += @core.min_dist_to_set(pa, b)
  }
  total / a.length().to_double()
}
