///|
/// Minkowski sum of a circle and a convex polygon. / 圆与凸多边形的 Minkowski 和。
pub fn minkowski_sum_circle_polygon(
  circle : Circle,
  poly : Polygon,
) -> (Array[Point2D], Double) {
  @minkowski.minkowski_sum_circle_polygon(circle, poly)
}


///|
/// Check if two convex polygons collide via Minkowski difference. / 用 Minkowski 差检查两凸多边形碰撞。
pub fn convex_polygons_collide(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @minkowski.convex_polygons_collide(poly1, poly2)
}
// ---------------------------------------------------------------------------
// rotating_calipers: rotating calipers / 旋转卡壳
// ---------------------------------------------------------------------------


///|
/// Convex polygon diameter (farthest vertex pair). / 凸多边形直径（最远顶点对）。
pub fn convex_polygon_diameter(poly : Polygon) -> (Point2D, Point2D, Double) {
  @rotating_calipers.convex_polygon_diameter(poly)
}


///|
/// Convex polygon width (min parallel supporting line distance). / 凸多边形宽度。
pub fn convex_polygon_width(poly : Polygon) -> Double {
  @rotating_calipers.convex_polygon_width(poly)
}


///|
/// Farthest point pair from a point set. / 点集最远点对。
pub fn farthest_point_pair(
  points : Array[Point2D],
) -> (Point2D, Point2D, Double)? {
  @rotating_calipers.farthest_point_pair(points)
}


///|
/// Min perimeter bounding rectangle of convex polygon. / 凸多边形最小周长包围矩形。
pub fn min_perimeter_bounding_rect(
  poly : Polygon,
) -> (Double, Double, Double, Double, Double) {
  @rotating_calipers.min_perimeter_bounding_rect(poly)
}

// ---------------------------------------------------------------------------
// ellipse: ellipse geometry / 椭圆几何
// ---------------------------------------------------------------------------
