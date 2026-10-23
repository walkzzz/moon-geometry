///|
/// # SAT Collision Detection
/// # SAT 碰撞检测
///
/// Separating Axis Theorem for convex polygon collision detection.
/// 分离轴定理检测凸多边形碰撞。
///
/// ## Complexity: O(n + m) where n, m are vertex counts
/// ## 复杂度: O(n + m)，n, m 为顶点数


///|
/// SAT collision result. / SAT 碰撞结果。
pub struct SATResult {
  collides : Bool
  overlap : Double
  axis_x : Double
  axis_y : Double
}


///|
/// Construct a SAT result. / 构造 SAT 结果。
pub fn SATResult::new(
  collides : Bool,
  overlap : Double,
  axis_x : Double,
  axis_y : Double,
) -> SATResult {
  { collides, overlap, axis_x, axis_y }
}
