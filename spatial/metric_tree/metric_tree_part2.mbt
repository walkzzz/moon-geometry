///|
/// Build a metric tree from points. / 由点集构建度量树。
pub fn build_metric_tree(
  points : Array[@core.Point2D],
) -> MetricNode? {
  if points.length() == 0 {
    return None
  }
  build_metric_tree_helper(points, 0, points.length() - 1)
}

fn build_metric_tree_helper(
  points : Array[@core.Point2D],
  lo : Int,
  hi : Int,
) -> MetricNode? {
  if lo > hi {
    return None
  }
  if lo == hi {
    return Some({ point: points[lo], radius: 0.0, left: None, right: None })
  }
  let center = points[lo]
  let mut max_d = 0.0
  for i in (lo + 1)..=hi {
    let d = center.dist(points[i])
    if d > max_d {
      max_d = d
    }
  }
  let mid = (lo + hi) / 2
  let left = build_metric_tree_helper(points, lo + 1, mid)
  let right = build_metric_tree_helper(points, mid + 1, hi)
  Some({ point: center, radius: max_d, left, right })
}
