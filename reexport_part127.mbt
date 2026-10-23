///|
/// Compute AABB union. / 计算 AABB 并集。
pub fn aabb_union(a : AABB, b : AABB) -> AABB {
  @collision_detect.aabb_union(a, b)
}


///|
/// Compute AABB area. / 计算 AABB 面积。
pub fn aabb_area(box : AABB) -> Double {
  @collision_detect.aabb_area(box)
}

// ---------------------------------------------------------------------------
// gjk: GJK collision detection / GJK 碰撞检测
// ---------------------------------------------------------------------------


///|
/// GJK result. / GJK 结果。
pub type GJKResult = @gjk.GJKResult


///|
/// Polygon support function. / 多边形支撑函数。
pub fn polygon_support(poly : Array[Point2D], dx : Double, dy : Double) -> Point2D {
  @gjk.polygon_support(poly, dx, dy)
}


///|
/// Circle support function. / 圆支撑函数。
pub fn circle_support(center : Point2D, radius : Double, dx : Double, dy : Double) -> Point2D {
  @gjk.circle_support(center, radius, dx, dy)
}


///|
/// Check collision between two convex polygons using GJK. / 使用 GJK 检测两凸多边形碰撞。
pub fn gjk_collide_polygons(
  poly1 : Array[Point2D],
  poly2 : Array[Point2D],
) -> GJKResult {
  @gjk.gjk_collide_polygons(poly1, poly2)
}


///|
/// Check collision between two circles using GJK. / 使用 GJK 检测两圆碰撞。
pub fn gjk_collide_circles(
  c1 : Point2D,
  r1 : Double,
  c2 : Point2D,
  r2 : Double,
) -> GJKResult {
  @gjk.gjk_collide_circles(c1, r1, c2, r2)
}
