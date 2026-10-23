///|
/// Construct a ray from two points. / 由两点构造射线。
pub fn ray_from_points(origin : Point2D, through : Point2D) -> Ray {
  @ray.Ray::from_points(origin, through)
}


///|
/// Evaluate ray at parameter t. / 计算射线上参数 t 处的点。
pub fn ray_eval(r : Ray, t : Double) -> Point2D {
  @ray.Ray::eval(r, t)
}


///|
/// Ray-segment intersection. / 射线与线段交点。
pub fn ray_segment_intersect(r : Ray, seg : Segment) -> Point2D? {
  @ray.ray_segment_intersect(r, seg)
}


///|
/// Ray-line intersection. / 射线与直线交点。
pub fn ray_line_intersect(r : Ray, line : Line) -> Point2D? {
  @ray.ray_line_intersect(r, line)
}


///|
/// Ray-polygon boundary intersections. / 射线与多边形边界交点。
pub fn ray_polygon_intersect(r : Ray, poly : Polygon) -> Array[Point2D] {
  @ray.ray_polygon_intersect(r, poly)
}


///|
/// Check if ray origin is inside polygon. / 检查射线起点是否在多边形内。
pub fn ray_polygon_contains(r : Ray, poly : Polygon) -> Bool {
  @ray.ray_polygon_contains(r, poly)
}

// ---------------------------------------------------------------------------
// plane: 3D plane operations / 三维平面
// ---------------------------------------------------------------------------
