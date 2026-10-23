///|
/// Query all rectangle indices overlapping the query rectangle. / 查询所有与查询矩形重叠的矩形索引。
pub fn query_aabb(
  nodes : Array[AABBNode],
  query : @core.Rectangle,
) -> Array[Int] {
  let result : Array[Int] = []
  if nodes.length() == 0 {
    return result
  }
  query_recursive(nodes, nodes.length() - 1, query, result)
  result
}

fn query_point_recursive(
  nodes : Array[AABBNode],
  node_idx : Int,
  p : @core.Point2D,
  result : Array[Int],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if !rect_contains_point(node.bounds, p) {
    return
  }
  if node.index >= 0 {
    result.push(node.index)
    return
  }
  query_point_recursive(nodes, node.left, p, result)
  query_point_recursive(nodes, node.right, p, result)
}
