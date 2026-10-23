///|
/// Check if two convex polygons collide (intersect) using Minkowski difference.
/// They collide iff origin is inside (A ⊖ B). / 用 Minkowski 差检查两凸多边形是否碰撞。
pub fn convex_polygons_collide(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Bool {
  let diff = minkowski_difference_convex(poly1, poly2)
  if diff.length() < 3 {
    return false
  }
  let origin = @core.Point2D::new(0.0, 0.0)
  let diff_poly = @core.Polygon::new(diff)
  @polygon.point_in_polygon(origin, diff_poly)
}
