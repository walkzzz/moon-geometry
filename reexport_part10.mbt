///|
/// Circle-segment intersection points (0/1/2). / 圆与线段交点。
pub fn circle_segment_intersect(
  circle : Circle,
  seg : Segment,
) -> Array[Point2D] {
  @circle_ops.circle_segment_intersect(circle, seg)
}


///|
/// Circle-circle intersection points (0/1/2). / 两圆交点。
pub fn circle_circle_intersect(c1 : Circle, c2 : Circle) -> Array[Point2D] {
  @circle_ops.circle_circle_intersect(c1, c2)
}


///|
/// Circle-line intersection points (0/1/2). / 圆与直线交点。
pub fn circle_line_intersect(circle : Circle, line : Line) -> Array[Point2D] {
  @circle_ops.circle_line_intersect(circle, line)
}


///|
/// Circle-polygon boundary intersection points. / 圆与多边形边界交点。
pub fn circle_polygon_intersect(
  circle : Circle,
  poly : Polygon,
) -> Array[Point2D] {
  @circle_ops.circle_polygon_intersect(circle, poly)
}
// ---------------------------------------------------------------------------
// triangulate: polygon triangulation / 多边形三角剖分
// ---------------------------------------------------------------------------


///|
/// Triangulate a simple polygon via ear clipping.
/// Returns vertex index triples. / 简单多边形三角剖分（ear clipping），返回顶点索引三元组。
pub fn triangulate_polygon(poly : Polygon) -> Array[(Int, Int, Int)] {
  @triangulate.triangulate_polygon(poly)
}
// ---------------------------------------------------------------------------
// minkowski: Minkowski operations / Minkowski 运算
// ---------------------------------------------------------------------------


///|
/// Minkowski sum of two convex polygons. / 两个凸多边形的 Minkowski 和。
pub fn minkowski_sum_convex(poly1 : Polygon, poly2 : Polygon) -> Array[Point2D] {
  @minkowski.minkowski_sum_convex(poly1, poly2)
}


///|
/// Minkowski difference of two convex polygons. / 两个凸多边形的 Minkowski 差。
pub fn minkowski_difference_convex(
  poly1 : Polygon,
  poly2 : Polygon,
) -> Array[Point2D] {
  @minkowski.minkowski_difference_convex(poly1, poly2)
}
