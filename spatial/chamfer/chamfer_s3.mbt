///|
/// Squared Chamfer distance (directed). / 平方 Chamfer 距离（有向）。
pub fn chamfer_squared_directed(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  if a.length() == 0 || b.length() == 0 {
    return 0.0
  }
  let mut total = 0.0
  for pa in a {
    let mut min_sq = pa.dist_sq(b[0])
    for pb in b {
      let d = pa.dist_sq(pb)
      if d < min_sq {
        min_sq = d
      }
    }
    total += min_sq
  }
  total / a.length().to_double()
}
