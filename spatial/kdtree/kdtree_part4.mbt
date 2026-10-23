///|
/// Range query: find all point indices within a rectangle. / 范围查询。
pub fn kdtree_range_query(
  nodes : Array[KDNode],
  rect : @core.Rectangle,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  kdtree_range_rec(nodes, nodes.length() - 1, rect, result)
  result
}
