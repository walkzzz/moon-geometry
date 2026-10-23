///|
/// Find nearest neighbor. Returns (index, distance) or None. / 最近邻搜索。
pub fn kdtree_nearest(
  nodes : Array[KDNode],
  query : @core.Point2D,
) -> (Int32, Double)? {
  if nodes.length() == 0 {
    return None
  }
  let best : Array[(Int32, Double)] = [(-1, 999999999.0)]
  kdtree_nearest_rec(nodes, nodes.length() - 1, query, best)
  let (best_idx, _) = best[0]
  if best_idx >= 0 {
    Some(best[0])
  } else {
    None
  }
}

///|
fn kdtree_range_rec(
  nodes : Array[KDNode],
  node_idx : Int32,
  rect : @core.Rectangle,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  let px = node.point.x()
  let py = node.point.y()
  if px >= rect.min_x &&
    px <= rect.max_x &&
    py >= rect.min_y &&
    py <= rect.max_y {
    result.push(node.index)
  }
  kdtree_range_rec(nodes, node.left, rect, result)
  kdtree_range_rec(nodes, node.right, rect, result)
}
