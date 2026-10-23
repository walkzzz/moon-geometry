///|
/// Expand a polygonal obstacle by a polygonal robot. / 用多边形机器人膨胀多边形障碍物。
pub fn cspace_expand_polygon(
  obstacle : Array[Point2D],
  robot : Array[Point2D],
) -> CSpaceObstacle {
  @config_space.cspace_expand_polygon(obstacle, robot)
}


///|
/// Check if a configuration point is valid. / 检查配置点是否有效。
pub fn cspace_point_valid(
  q : Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  @config_space.cspace_point_valid(q, cspace_obstacles)
}


///|
/// Check if a configuration space segment is valid. / 检查配置空间线段是否有效。
pub fn cspace_segment_valid(
  q1 : Point2D,
  q2 : Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  @config_space.cspace_segment_valid(q1, q2, cspace_obstacles)
}


///|
/// Build C-space obstacles. / 构建配置空间障碍物。
pub fn cspace_build(
  obstacles : Array[Array[Point2D]],
  robot_radius : Double,
  num_arc_samples : Int,
) -> Array[CSpaceObstacle] {
  @config_space.cspace_build(obstacles, robot_radius, num_arc_samples)
}

// ---------------------------------------------------------------------------
// path_smooth: Path smoothing / 路径平滑
// ---------------------------------------------------------------------------


///|
/// Smoothing configuration. / 平滑配置。
pub type SmoothConfig = @path_smooth.SmoothConfig
