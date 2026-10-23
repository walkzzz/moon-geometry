///|
/// A* graph node for graph-based search. / 图搜索的 A* 图节点。
pub struct AStarGraphNode {
  id : Int
  x : Double
  y : Double
}


///|
/// Construct an A* graph node. / 构造 A* 图节点。
pub fn AStarGraphNode::new(id : Int, x : Double, y : Double) -> AStarGraphNode {
  { id, x, y }
}
