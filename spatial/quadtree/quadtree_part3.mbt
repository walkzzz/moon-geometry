///|
/// Range query in quadtree. / 四叉树范围查询。
pub fn quadtree_range_query(
  nodes : Array[QuadNode],
  rect : @core.Rectangle,
) -> Array[Int] {
  let result : Array[Int] = []
  if nodes.length() == 0 {
    return result
  }
  quad_range_rec(nodes, 0, rect, result)
  result
}


///|
/// Count points in the quadtree. / 统计四叉树中的点数。
pub fn quadtree_count(nodes : Array[QuadNode]) -> Int {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].has_point {
      count += 1
    }
  }
  count
}