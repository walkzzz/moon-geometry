///|
/// Bottleneck distance: min over all matchings of max pairwise distance. / 瓶颈距离：所有匹配中最大配对距离的最小值。
pub fn bottleneck_distance(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let dists : Array[Double] = []
  for pa in a {
    for pb in b {
      dists.push(pa.dist(pb))
    }
  }
  dists.sort()
  let k = if n < m { n } else { m }
  dists[k - 1]
}
