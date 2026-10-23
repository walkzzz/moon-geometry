///|
/// Build a k-d tree from points. / 由点集构建 k-d 树。
pub fn build_kdtree(points : Array[@core.Point2D]) -> Array[KDNode] {
  if points.length() == 0 {
    return []
  }
  let nodes : Array[KDNode] = []
  let indices : Array[Int] = []
  for i in 0..<points.length() {
    indices.push(i)
  }
  ignore(kdtree_build_rec(points, indices, 0, nodes))
  nodes
}

fn kdtree_nearest_rec(
  nodes : Array[KDNode],
  node_idx : Int,
  query : @core.Point2D,
  best : Array[(Int, Double)],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  let dx = node.point.x() - query.x()
  let dy = node.point.y() - query.y()
  let dist = (dx * dx + dy * dy).sqrt()
  let (_, cur_dist) = best[0]
  if cur_dist > dist {
    best[0] = (node.index, dist)
  }
  let diff = if node.axis == 0 {
    query.x() - node.point.x()
  } else {
    query.y() - node.point.y()
  }
  let (near, far) = if diff < 0.0 {
    (node.left, node.right)
  } else {
    (node.right, node.left)
  }
  kdtree_nearest_rec(nodes, near, query, best)
  let (_, cur_dist2) = best[0]
  if diff.abs() < cur_dist2 {
    kdtree_nearest_rec(nodes, far, query, best)
  }
}
