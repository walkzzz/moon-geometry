///|
/// Maximum pairwise distance in bottleneck matching. / 瓶颈匹配中最大配对距离。
pub fn bottleneck_max(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let pairs = bottleneck_match(a, b)
  let mut max_d = 0.0
  for (_, _, d) in pairs {
    if d > max_d {
      max_d = d
    }
  }
  max_d
}
