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

///|
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
pub fn metric_tree_count(node : MetricNode?) -> Int32 {
  match node {
    Some(n) => 1 + metric_tree_count(n.left) + metric_tree_count(n.right)
    None => 0
  }
}
