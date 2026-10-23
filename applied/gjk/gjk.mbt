///|
/// # GJK Collision Detection
/// # GJK 碰撞检测
///
/// Gilbert-Johnson-Keerthi algorithm using support mappings for convex shapes.
/// 使用支撑映射的 GJK 算法检测凸体碰撞。
///
/// ## Complexity: O(1) per iteration, typically converges in < 20 iterations
/// ## 复杂度: 每次迭代 O(1)，通常 < 20 次迭代收敛


///|
/// GJK result. / GJK 结果。
pub struct GJKResult {
  collides : Bool
  iterations : Int
}


///|
/// Construct a GJK result. / 构造 GJK 结果。
pub fn GJKResult::new(collides : Bool, iterations : Int) -> GJKResult {
  { collides, iterations }
}
