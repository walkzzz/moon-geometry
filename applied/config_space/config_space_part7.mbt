///|
/// Build C-space obstacles from multiple polygonal obstacles and a circular robot. / 从多个多边形障碍物和圆形机器人构建配置空间障碍物。
pub fn cspace_build(
  obstacles : Array[Array[@core.Point2D]],
  robot_radius : Double,
  num_arc_samples : Int32,
) -> Array[CSpaceObstacle] {
  let result : Array[CSpaceObstacle] = []
  for i in 0..<obstacles.length() {
    result.push(
      cspace_expand_circle(obstacles[i], robot_radius, num_arc_samples),
    )
  }
  result
}
