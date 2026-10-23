///|
/// Count matched points. / 计数匹配点数。
pub fn match_count(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Int {
  point_match(a, b, threshold).length()
}


///|
/// Match ratio (matched / min(|A|, |B|)). / 匹配比率。
pub fn match_ratio(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Double {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let count = match_count(a, b, threshold)
  let min_size = if n < m { n } else { m }
  count.to_double() / min_size.to_double()
}


///|
/// Unmatched points in set A. / A 中未匹配的点。
pub fn unmatched_a(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Int {
  a.length() - match_count(a, b, threshold)
}


///|
/// Unmatched points in set B. / B 中未匹配的点。
pub fn unmatched_b(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Int {
  let matches = point_match(a, b, threshold)
  b.length() - matches.length()
}