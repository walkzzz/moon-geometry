///|
/// PRM result. / PRM 结果。
pub type PRMResult = @prm.PRMResult


///|
/// Construct PRM configuration. / 构造 PRM 配置。
pub fn prm_config_new(
  num_samples : Int,
  connection_radius : Double,
  seed : UInt,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> PRMConfig {
  @prm.PRMConfig::new(num_samples, connection_radius, seed, x_min, x_max, y_min, y_max)
}


///|
/// Build a PRM roadmap. / 构建 PRM 路线图。
pub fn prm_build(
  config : PRMConfig,
  obstacles : Array[Array[Point2D]],
) -> PRMRoadmap {
  @prm.prm_build(config, obstacles)
}


///|
/// Query shortest path on a PRM roadmap. / 在 PRM 路线图上查询最短路径。
pub fn prm_query(
  roadmap : PRMRoadmap,
  start : Point2D,
  goal : Point2D,
  obstacles : Array[Array[Point2D]],
) -> PRMResult {
  @prm.prm_query(roadmap, start, goal, obstacles)
}


///|
/// Count nodes in a PRM roadmap. / 统计 PRM 路线图节点数。
pub fn prm_node_count(roadmap : PRMRoadmap) -> Int {
  @prm.prm_node_count(roadmap)
}


///|
/// Count edges in a PRM roadmap. / 统计 PRM 路线图边数。
pub fn prm_edge_count(roadmap : PRMRoadmap) -> Int {
  @prm.prm_edge_count(roadmap)
}

// ---------------------------------------------------------------------------
// a_star: A* path planning / A* 路径规划
// ---------------------------------------------------------------------------


///|
/// A* grid. / A* 网格。
pub type AStarGrid = @a_star.AStarGrid
