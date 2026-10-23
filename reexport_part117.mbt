///|
/// Reeb graph edge. / Reeb 图边。
pub type ReebEdge = @reeb_graph.ReebEdge


///|
/// Reeb graph. / Reeb 图。
pub type ReebGraph = @reeb_graph.ReebGraph

pub fn reeb_node_new(
  vertex_idx : Int,
  level : Double,
  crit_type : CriticalType,
) -> ReebNode {
  @reeb_graph.ReebNode::new(vertex_idx, level, crit_type)
}

pub fn reeb_edge_new(from : Int, to : Int) -> ReebEdge {
  @reeb_graph.ReebEdge::new(from, to)
}

pub fn reeb_graph_new() -> ReebGraph {
  @reeb_graph.ReebGraph::new()
}

pub fn reeb_graph_node_count(rg : ReebGraph) -> Int {
  @reeb_graph.ReebGraph::node_count(rg)
}

pub fn reeb_graph_edge_count(rg : ReebGraph) -> Int {
  @reeb_graph.ReebGraph::edge_count(rg)
}

pub fn critical_points(values : Array[Double], edges : Array[(Int, Int)]) -> Array[ReebNode] {
  @reeb_graph.critical_points(values, edges)
}

pub fn reeb_graph(values : Array[Double], edges : Array[(Int, Int)]) -> ReebGraph {
  @reeb_graph.reeb_graph(values, edges)
}

pub fn reeb_node_count(rg : ReebGraph) -> Int {
  @reeb_graph.reeb_node_count(rg)
}

pub fn reeb_edge_count(rg : ReebGraph) -> Int {
  @reeb_graph.reeb_edge_count(rg)
}

// ---------------------------------------------------------------------------
// morse_complex: Morse complex / Morse 复形
// ---------------------------------------------------------------------------








// ---------------------------------------------------------------------------
// rrt: Rapidly-exploring Random Trees / 快速探索随机树
// ---------------------------------------------------------------------------


///|
/// RRT node. / RRT 节点。
pub type RRTNode = @rrt.RRTNode


///|
/// RRT configuration. / RRT 配置。
pub type RRTConfig = @rrt.RRTConfig


///|
/// RRT result. / RRT 结果。
pub type RRTResult = @rrt.RRTResult


///|
/// Construct an RRT node. / 构造 RRT 节点。
pub fn rrt_node_new(point : Point2D, parent : Int) -> RRTNode {
  @rrt.RRTNode::new(point, parent)
}


///|
/// Construct RRT configuration. / 构造 RRT 配置。
pub fn rrt_config_new(
  step_size : Double,
  max_iterations : Int,
  goal_bias : Double,
  goal_radius : Double,
  seed : UInt,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> RRTConfig {
  @rrt.RRTConfig::new(step_size, max_iterations, goal_bias, goal_radius, seed, x_min, x_max, y_min, y_max)
}
