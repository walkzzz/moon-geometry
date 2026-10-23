///|
/// Check if two AABBs overlap. / 检查两个 AABB 是否重叠。
pub fn aabb_overlap(a : AABB, b : AABB) -> Bool {
  @collision_detect.aabb_overlap(a, b)
}


///|
/// Check if a point is inside an AABB. / 检查点是否在 AABB 内。
pub fn aabb_contains(box : AABB, x : Double, y : Double) -> Bool {
  @collision_detect.aabb_contains(box, x, y)
}


///|
/// Compute the AABB of a polygon. / 计算多边形的 AABB。
pub fn aabb_from_polygon(poly : Array[Point2D]) -> AABB {
  @collision_detect.aabb_from_polygon(poly)
}


///|
/// Broad phase collision detection. / 宽相碰撞检测。
pub fn broad_phase_aabb(boxes : Array[AABB]) -> Array[CollisionPair] {
  @collision_detect.broad_phase_aabb(boxes)
}


///|
/// Segment-segment collision. / 线段-线段碰撞。
pub fn segment_segment_collide(
  a1 : Point2D,
  a2 : Point2D,
  b1 : Point2D,
  b2 : Point2D,
) -> Bool {
  @collision_detect.segment_segment_collide(a1, a2, b1, b2)
}
