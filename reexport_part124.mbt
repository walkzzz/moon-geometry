///|
/// Count segments in a Reeds-Shepp path. / 统计 Reeds-Shepp 路径段数。
pub fn reed_shepp_segment_count(path : RSPath) -> Int {
  @reed_shepp.reed_shepp_segment_count(path)
}


///|
/// Check if a Reeds-Shepp path contains backward motion. / 检查 Reeds-Shepp 路径是否包含后退运动。
pub fn reed_shepp_has_backward(path : RSPath) -> Bool {
  @reed_shepp.reed_shepp_has_backward(path)
}

// ---------------------------------------------------------------------------
// collision_detect: Collision detection / 碰撞检测
// ---------------------------------------------------------------------------


///|
/// AABB. / 轴对齐包围盒。
pub type AABB = @collision_detect.AABB


///|
/// Collision pair. / 碰撞对。
pub type CollisionPair = @collision_detect.CollisionPair


///|
/// Construct an AABB. / 构造 AABB。
pub fn aabb_new(min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> AABB {
  @collision_detect.AABB::new(min_x, min_y, max_x, max_y)
}


///|
/// Construct an AABB from center and half-extents. / 从中心和半边长构造 AABB。
pub fn aabb_from_center(cx : Double, cy : Double, hx : Double, hy : Double) -> AABB {
  @collision_detect.AABB::from_center(cx, cy, hx, hy)
}
