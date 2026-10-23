///|
/// Nearest neighbor in metric tree. / 度量树最近邻。
pub fn metric_tree_nearest(
  node : MetricNode?,
  query : @core.Point2D,
) -> @core.Point2D? {
  let candidates = metric_tree_query(node, query, 1000000.0)
  if candidates.length() == 0 {
    return None
  }
  let mut best = candidates[0]
  let mut best_d = query.dist(best)
  for p in candidates {
    let d = query.dist(p)
    if d < best_d {
      best_d = d
      best = p
    }
  }
  Some(best)
}
