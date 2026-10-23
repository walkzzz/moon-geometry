///|
/// Query rectangle indices containing a point. / 查询包含点的矩形索引。
pub fn bvh_query_point(nodes : Array[BVHNode], p : @core.Point2D) -> Array[Int] {
  let result : Array[Int] = []
  if nodes.length() == 0 {
    return result
  }
  bvh_point_rec(nodes, nodes.length() - 1, p, result)
  result
}


///|
/// Count leaf nodes. / 统计叶子节点数。
pub fn bvh_count_leaves(nodes : Array[BVHNode]) -> Int {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].index >= 0 {
      count += 1
    }
  }
  count
}