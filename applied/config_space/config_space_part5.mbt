///|
/// Check if a configuration point is valid (not inside any C-space obstacle). / 检查配置点是否有效（不在任何配置空间障碍物内）。
pub fn cspace_point_valid(
  q : @core.Point2D,
  cspace_obstacles : Array[CSpaceObstacle],
) -> Bool {
  for i in 0..<cspace_obstacles.length() {
    if point_in_polygon(q, cspace_obstacles[i].vertices) {
      return false
    }
  }
  true
}
