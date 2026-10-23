///|
/// Partial Hausdorff distance (k-th largest directed distance). / 部分 Hausdorff 距离（第 k 大有向距离）。
pub fn partial_hausdorff(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  k : Int32,
) -> Double {
  if a.length() == 0 || b.length() == 0 {
    return 0.0
  }
  let dists : Array[Double] = []
  for pa in a {
    dists.push(@core.min_dist_to_set(pa, b))
  }
  dists.sort()
  let idx = if k < dists.length() { k } else { dists.length() - 1 }
  dists[idx]
}
