///|
/// # Configuration Space
/// # 配置空间
///
/// Configuration space obstacle expansion for motion planning.
/// 运动规划的配置空间障碍物膨胀。
///
/// ## Complexity: O(n) for circle expansion, O(n*m) for polygon expansion
/// ## 复杂度: 圆膨胀 O(n)，多边形膨胀 O(n*m)


///|
/// C-space obstacle (expanded obstacle in configuration space). / 配置空间障碍物。
pub struct CSpaceObstacle {
  vertices : Array[@core.Point2D]
}


///|
/// Construct a C-space obstacle. / 构造配置空间障碍物。
pub fn CSpaceObstacle::new(vertices : Array[@core.Point2D]) -> CSpaceObstacle {
  { vertices, }
}


///|
/// Number of vertices in the C-space obstacle. / 配置空间障碍物顶点数。
pub fn CSpaceObstacle::size(self : CSpaceObstacle) -> Int {
  self.vertices.length()
}
