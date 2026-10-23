///|
/// Construct an A* graph node. / 构造 A* 图节点。
pub fn astar_graph_node_new(id : Int, x : Double, y : Double) -> AStarGraphNode {
  @a_star.AStarGraphNode::new(id, x, y)
}


///|
/// Plan path on a grid using A*. / 使用 A* 在网格上规划路径。
pub fn astar_grid(
  grid : AStarGrid,
  start : (Int, Int),
  goal : (Int, Int),
  heuristic : AStarHeuristic,
  allow_diagonal : Bool,
) -> AStarResult {
  @a_star.astar_grid(grid, start, goal, heuristic, allow_diagonal)
}


///|
/// Plan path on a graph using A*. / 使用 A* 在图上规划路径。
pub fn astar_graph(
  nodes : Array[AStarGraphNode],
  adj : Array[Array[(Int, Double)]],
  start : Int,
  goal : Int,
) -> AStarResult {
  @a_star.astar_graph(nodes, adj, start, goal)
}


///|
/// Compute path cost on a grid. / 计算网格路径代价。
pub fn astar_path_cost(path : Array[(Int, Int)]) -> Double {
  @a_star.astar_path_cost(path)
}

// ---------------------------------------------------------------------------
// dubins: Dubins curves / Dubins 曲线
// ---------------------------------------------------------------------------


///|
/// Dubins path segment type. / Dubins 路径段类型。
pub type DubinsSegmentType = @dubins.DubinsSegmentType


///|
/// Dubins path segment. / Dubins 路径段。
pub type DubinsSegment = @dubins.DubinsSegment


///|
/// Dubins path. / Dubins 路径。
pub type DubinsPath = @dubins.DubinsPath
