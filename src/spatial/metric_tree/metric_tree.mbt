///|
/// Metric tree node for nearest neighbor search in metric spaces. / 度量树节点，用于度量空间最近邻搜索。
pub struct MetricNode {
  point : @core.Point2D
  radius : Double
  left : MetricNode?
  right : MetricNode?
}

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

///|
/// Range query in metric tree (points within radius of query). / 度量树范围查询（查询点半径内的点）。
pub fn metric_tree_query(
  node : MetricNode?,
  query : @core.Point2D,
  radius : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  metric_tree_query_helper(node, query, radius, result)
  result
}

fn metric_tree_query_helper(
  node : MetricNode?,
  query : @core.Point2D,
  radius : Double,
  result : Array[@core.Point2D],
) -> Unit {
  match node {
    Some(n) => {
      let d = n.point.dist(query)
      if d <= radius {
        result.push(n.point)
      }
      if d - n.radius <= radius {
        metric_tree_query_helper(n.left, query, radius, result)
      }
      if d + n.radius >= 0.0 {
        metric_tree_query_helper(n.right, query, radius, result)
      }
    }
    None => ()
  }
}

///|
/// Count nodes in metric tree. / 度量树节点数。
pub fn metric_tree_count(node : MetricNode?) -> Int {
  match node {
    Some(n) => 1 + metric_tree_count(n.left) + metric_tree_count(n.right)
    None => 0
  }
}

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