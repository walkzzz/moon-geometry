///|
/// Plan a path using basic RRT. / 使用基本 RRT 规划路径。
pub fn rrt_plan(
  config : RRTConfig,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> RRTResult {
  @rrt.rrt_plan(config, start, goal, obstacles)
}


///|
/// Plan a path using RRT*. / 使用 RRT* 规划路径。
pub fn rrt_star_plan(
  config : RRTConfig,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> RRTResult {
  @rrt.rrt_star_plan(config, start, goal, obstacles)
}


///|
/// Plan a path using bidirectional RRT. / 使用双向 RRT 规划路径。
pub fn rrt_connect_plan(
  config : RRTConfig,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> RRTResult {
  @rrt.rrt_connect_plan(config, start, goal, obstacles)
}


///|
/// Compute the total length of an RRT path. / 计算 RRT 路径总长度。
pub fn rrt_path_length(path : Array[Point2D]) -> Double {
  @rrt.rrt_path_length(path)
}


///|
/// Count nodes in an RRT tree. / 统计 RRT 树中节点数。
pub fn rrt_node_count(nodes : Array[RRTNode]) -> Int {
  @rrt.rrt_node_count(nodes)
}

// ---------------------------------------------------------------------------
// prm: Probabilistic Roadmap / 概率路线图
// ---------------------------------------------------------------------------


///|
/// PRM configuration. / PRM 配置。
pub type PRMConfig = @prm.PRMConfig


///|
/// PRM roadmap. / PRM 路线图。
pub type PRMRoadmap = @prm.PRMRoadmap
