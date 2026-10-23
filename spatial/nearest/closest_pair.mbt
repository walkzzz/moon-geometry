///|
/// Brute-force closest pair O(n^2). Used as fallback and for validation.
/// 暴力最近点对 O(n^2)。用作回退和验证。
fn closest_pair_brute(
  pts : Array[@core.Point2D],
  lo : Int32,
  hi : Int32,
) -> (@core.Point2D, @core.Point2D, Double)? {
  if hi <= lo {
    return None
  }
  let mut best = pts[lo].dist_sq(pts[lo + 1])
  let mut bi = lo
  let mut bj = lo + 1
  for i in lo..<hi {
    for j in (i + 1)..<=hi {
      let d = pts[i].dist_sq(pts[j])
      if d < best {
        best = d
        bi = i
        bj = j
      }
    }
  }
  Some((pts[bi], pts[bj], best.sqrt()))
}
