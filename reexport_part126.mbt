///|
/// Point in polygon test. / 点在多边形内测试。
pub fn point_in_polygon_arr(p : Point2D, poly : Array[Point2D]) -> Bool {
  @collision_detect.point_in_polygon(p, poly)
}


///|
/// Circle-circle collision. / 圆-圆碰撞。
pub fn circle_circle_collide(
  c1 : Point2D,
  r1 : Double,
  c2 : Point2D,
  r2 : Double,
) -> Bool {
  @collision_detect.circle_circle_collide(c1, r1, c2, r2)
}


///|
/// Segment-polygon collision. / 线段-多边形碰撞。
pub fn segment_polygon_collide(
  a : Point2D,
  b : Point2D,
  poly : Array[Point2D],
) -> Bool {
  @collision_detect.segment_polygon_collide(a, b, poly)
}


///|
/// Polygon-polygon collision. / 多边形-多边形碰撞。
pub fn polygon_polygon_collide(
  poly1 : Array[Point2D],
  poly2 : Array[Point2D],
) -> Bool {
  @collision_detect.polygon_polygon_collide(poly1, poly2)
}


///|
/// Circle-polygon collision. / 圆-多边形碰撞。
pub fn circle_polygon_collide(
  center : Point2D,
  radius : Double,
  poly : Array[Point2D],
) -> Bool {
  @collision_detect.circle_polygon_collide(center, radius, poly)
}


///|
/// AABB-polygon collision. / AABB-多边形碰撞。
pub fn aabb_polygon_collide(box : AABB, poly : Array[Point2D]) -> Bool {
  @collision_detect.aabb_polygon_collide(box, poly)
}


///|
/// Compute AABB intersection. / 计算 AABB 交集。
pub fn aabb_intersection(a : AABB, b : AABB) -> AABB? {
  @collision_detect.aabb_intersection(a, b)
}
