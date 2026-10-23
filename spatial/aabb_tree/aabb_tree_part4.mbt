///|
/// Query all rectangle indices containing the point. / 查询所有包含点的矩形索引。
pub fn query_point_aabb(
  nodes : Array[AABBNode],
  p : @core.Point2D,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  query_point_recursive(nodes, nodes.length() - 1, p, result)
  result
}

///|
/// Count leaf nodes in the tree. / 统计树中叶子节点数。
pub fn count_leaves(nodes : Array[AABBNode]) -> Int32 {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].index >= 0 {
      count += 1
    }
  }
  count
}
