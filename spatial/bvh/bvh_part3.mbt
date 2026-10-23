///|
/// Query overlapping rectangle indices. / 查询重叠矩形索引。
pub fn bvh_query(
  nodes : Array[BVHNode],
  rect : @core.Rectangle,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  bvh_query_rec(nodes, nodes.length() - 1, rect, result)
  result
}

///|
fn bvh_point_rec(
  nodes : Array[BVHNode],
  node_idx : Int32,
  p : @core.Point2D,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if p.x() < node.bounds.min_x ||
    p.x() > node.bounds.max_x ||
    p.y() < node.bounds.min_y ||
    p.y() > node.bounds.max_y {
    return
  }
  if node.index >= 0 {
    result.push(node.index)
    return
  }
  bvh_point_rec(nodes, node.left, p, result)
  bvh_point_rec(nodes, node.right, p, result)
}
