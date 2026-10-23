///|
/// Minimum distance between two segments. / 两线段最小距离。
pub fn segment_to_segment_distance(s1 : Segment, s2 : Segment) -> Double {
  @distance.segment_to_segment_distance(s1, s2)
}


///|
/// Minimum distance between two polygons. / 两多边形最小距离。
pub fn polygon_to_polygon_distance(p1 : Polygon, p2 : Polygon) -> Double {
  @distance.polygon_to_polygon_distance(p1, p2)
}


///|
/// Distance from a point to a line. / 点到直线距离。
pub fn point_to_line_distance(p : Point2D, line : Line) -> Double {
  @distance.point_to_line_distance(p, line)
}

// ---------------------------------------------------------------------------
// bounding: bounding volumes / 包围体
// ---------------------------------------------------------------------------


///|
/// Axis-aligned bounding box of points. / 点集轴对齐包围盒。
pub fn aabb(points : Array[Point2D]) -> Rectangle {
  @bounding.aabb(points)
}


///|
/// Axis-aligned bounding box of a polygon. / 多边形轴对齐包围盒。
pub fn aabb_polygon(poly : Polygon) -> Rectangle {
  @bounding.aabb_polygon(poly)
}


///|
/// Minimum-area bounding rectangle (rotating calipers). / 最小面积包围矩形。
pub fn min_area_bounding_rect(
  points : Array[Point2D],
) -> (Double, Double, Double, Double, Double) {
  @bounding.min_area_bounding_rect(points)
}


///|
/// Bounding circle (centroid + max distance). / 包围圆。
pub fn bounding_circle(points : Array[Point2D]) -> (Point2D, Double) {
  @bounding.bounding_circle(points)
}
// ---------------------------------------------------------------------------
// circle_ops: circle intersection / 圆相交
// ---------------------------------------------------------------------------
