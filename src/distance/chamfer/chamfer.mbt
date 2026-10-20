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

///|
/// Symmetric Chamfer distance. / 对称 Chamfer 距离。
pub fn chamfer_distance(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  chamfer_directed(a, b) + chamfer_directed(b, a)
}

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

///|
/// Root mean square Chamfer distance. / 均方根 Chamfer 距离。
pub fn chamfer_rms(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  (chamfer_squared_directed(a, b) + chamfer_squared_directed(b, a)).sqrt()
}