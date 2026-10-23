///|
/// Check collision between two circles using SAT. / 使用 SAT 检测两圆碰撞。
pub fn sat_collide_circles(
  c1 : Point2D,
  r1 : Double,
  c2 : Point2D,
  r2 : Double,
) -> SATResult {
  @sat.sat_collide_circles(c1, r1, c2, r2)
}


///|
/// Check collision between a polygon and a circle using SAT. / 使用 SAT 检测多边形与圆碰撞。
pub fn sat_collide_polygon_circle(
  poly : Array[Point2D],
  center : Point2D,
  radius : Double,
) -> SATResult {
  @sat.sat_collide_polygon_circle(poly, center, radius)
}


///|
/// Get the minimum translation vector. / 获取最小平移向量。
pub fn sat_mtv(result : SATResult) -> Point2D {
  @sat.sat_mtv(result)
}


///|
/// Get the separating axis direction. / 获取分离轴方向。
pub fn sat_separating_axis(result : SATResult) -> Point2D {
  @sat.sat_separating_axis(result)
}

// ---------------------------------------------------------------------------
// config_space: Configuration space / 配置空间
// ---------------------------------------------------------------------------


///|
/// C-space obstacle. / 配置空间障碍物。
pub type CSpaceObstacle = @config_space.CSpaceObstacle


///|
/// Construct a C-space obstacle. / 构造配置空间障碍物。
pub fn cspace_obstacle_new(vertices : Array[Point2D]) -> CSpaceObstacle {
  @config_space.CSpaceObstacle::new(vertices)
}


///|
/// Expand a polygonal obstacle by a circular robot radius. / 用圆形机器人半径膨胀多边形障碍物。
pub fn cspace_expand_circle(
  obstacle : Array[Point2D],
  radius : Double,
  num_arc_samples : Int,
) -> CSpaceObstacle {
  @config_space.cspace_expand_circle(obstacle, radius, num_arc_samples)
}
