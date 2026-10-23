///|
/// Check collision between two convex polygons using GJK. / 使用 GJK 检测两凸多边形碰撞。
pub fn gjk_collide_polygons(
  poly1 : Array[@core.Point2D],
  poly2 : Array[@core.Point2D],
) -> GJKResult {
  let sa = fn(dx, dy) { polygon_support(poly1, dx, dy) }
  let sb = fn(dx, dy) { polygon_support(poly2, dx, dy) }
  gjk_collide(sa, sb, 100)
}

///|
/// Check collision between two circles using GJK. / 使用 GJK 检测两圆碰撞。
pub fn gjk_collide_circles(
  c1 : @core.Point2D,
  r1 : Double,
  c2 : @core.Point2D,
  r2 : Double,
) -> GJKResult {
  let sa = fn(dx, dy) { circle_support(c1, r1, dx, dy) }
  let sb = fn(dx, dy) { circle_support(c2, r2, dx, dy) }
  gjk_collide(sa, sb, 100)
}

///|
/// Check collision between a convex polygon and a circle using GJK. / 使用 GJK 检测凸多边形与圆碰撞。
pub fn gjk_collide_polygon_circle(
  poly : Array[@core.Point2D],
  center : @core.Point2D,
  radius : Double,
) -> GJKResult {
  let sa = fn(dx, dy) { polygon_support(poly, dx, dy) }
  let sb = fn(dx, dy) { circle_support(center, radius, dx, dy) }
  gjk_collide(sa, sb, 100)
}

///|
/// Check if a point is inside a convex polygon using GJK. / 使用 GJK 检测点是否在凸多边形内。
pub fn gjk_point_in_polygon(
  p : @core.Point2D,
  poly : Array[@core.Point2D],
) -> GJKResult {
  let sa = fn(dx, dy) { polygon_support(poly, dx, dy) }
  let sb = fn(_dx, _dy) { p }
  gjk_collide(sa, sb, 100)
}
