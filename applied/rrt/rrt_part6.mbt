///|
/// Compute the total length of an RRT path. / 计算 RRT 路径总长度。
pub fn rrt_path_length(path : Array[@core.Point2D]) -> Double {
  let mut sum = 0.0
  for i in 1..<path.length() {
    sum += point_dist(path[i - 1], path[i])
  }
  sum
}


///|
/// Count nodes in an RRT tree. / 统计 RRT 树中节点数。
pub fn rrt_node_count(nodes : Array[RRTNode]) -> Int {
  nodes.length()
}