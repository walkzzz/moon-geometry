///|
/// Check collision between a polygon and a circle using GJK. / 使用 GJK 检测多边形与圆碰撞。
pub fn gjk_collide_polygon_circle(
  poly : Array[Point2D],
  center : Point2D,
  radius : Double,
) -> GJKResult {
  @gjk.gjk_collide_polygon_circle(poly, center, radius)
}


///|
/// Check if a point is inside a convex polygon using GJK. / 使用 GJK 检测点是否在凸多边形内。
pub fn gjk_point_in_polygon(p : Point2D, poly : Array[Point2D]) -> GJKResult {
  @gjk.gjk_point_in_polygon(p, poly)
}

// ---------------------------------------------------------------------------
// sat: SAT collision detection / SAT 碰撞检测
// ---------------------------------------------------------------------------


///|
/// SAT collision result. / SAT 碰撞结果。
pub type SATResult = @sat.SATResult


///|
/// Check collision between two convex polygons using SAT. / 使用 SAT 检测两凸多边形碰撞。
pub fn sat_collide_polygons(
  poly1 : Array[Point2D],
  poly2 : Array[Point2D],
) -> SATResult {
  @sat.sat_collide_polygons(poly1, poly2)
}


///|
/// Check if a convex polygon contains a point using SAT. / 使用 SAT 检测凸多边形是否包含点。
pub fn sat_contains_point(poly : Array[Point2D], p : Point2D) -> Bool {
  @sat.sat_contains_point(poly, p)
}
