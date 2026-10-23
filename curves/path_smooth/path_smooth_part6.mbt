///|
/// Compute the maximum deviation between original and smoothed path. / 计算原始路径与平滑路径间的最大偏差。
pub fn path_max_deviation(
  original : Array[@core.Point2D],
  smoothed : Array[@core.Point2D],
) -> Double {
  let mut max_dev = 0.0
  for i in 0..<original.length() {
    let mut min_dist = 1000000000000.0
    for j in 0..<smoothed.length() {
      let d = original[i].dist(smoothed[j])
      if d < min_dist {
        min_dist = d
      }
    }
    if min_dist > max_dev {
      max_dev = min_dist
    }
  }
  max_dev
}