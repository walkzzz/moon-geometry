///|
/// Directed Hausdorff distance from set A to set B. / 从集合 A 到集合 B 的有向 Hausdorff 距离。
pub fn hausdorff_directed(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  if a.length() == 0 {
    return 0.0
  }
  if b.length() == 0 {
    return 1.0 / 0.000000000001
  }
  let mut max_min = 0.0
  for pa in a {
    let min_dist = @core.min_dist_to_set(pa, b)
    if min_dist > max_min {
      max_min = min_dist
    }
  }
  max_min
}
