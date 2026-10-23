///|
/// Whether point p is on the inside (left side) of CCW edge a->b.
/// 点 p 是否在 CCW 边 a->b 的内侧（左侧）。
fn is_inside_edge(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Bool {
  @core.turn(a, b, p) >= 0.0
}

///|
/// Intersection point of segment (p1,p2) with line through (p3,p4).
/// 线段 (p1,p2) 与过 (p3,p4) 直线的交点。
fn line_intersect_pt(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> @core.Point2D? {
  let r = p2.sub(p1)
  let s = p4.sub(p3)
  let rxs = r.cross(s)
  if rxs == 0.0 {
    return None
  }
  let t = p3.sub(p1).cross(s) / rxs
  Some(@core.Point2D::new(p1.x + t * r.x, p1.y + t * r.y))
}

///|
/// Clip a polygon by an axis-aligned rectangle (Sutherland-Hodgman).
/// Returns the clipped polygon vertices (possibly empty).
/// 返回裁剪后的多边形顶点（可能为空）。
pub fn clip_polygon(
  poly : @core.Polygon,
  clip_rect : @core.Rectangle,
) -> Array[@core.Point2D] {
  let clip = [
    @core.Point2D::new(clip_rect.min_x, clip_rect.min_y),
    @core.Point2D::new(clip_rect.max_x, clip_rect.min_y),
    @core.Point2D::new(clip_rect.max_x, clip_rect.max_y),
    @core.Point2D::new(clip_rect.min_x, clip_rect.max_y),
  ]
  sutherland_hodgman(poly.vertices, clip)
}

///|
/// Intersection of two polygons. Uses Sutherland-Hodgman; requires `clip`
/// (the second polygon) to be convex. Returns None if no overlap.
/// 两多边形交集。使用 Sutherland-Hodgman 算法；要求 `clip`
/// （第二个多边形）为凸。无重叠时返回 None。
pub fn polygon_intersection(
  subject : @core.Polygon,
  clip : @core.Polygon,
) -> @core.Polygon? {
  let result = sutherland_hodgman(subject.vertices, clip.vertices)
  if result.length() < 3 {
    None
  } else {
    Some(@core.Polygon::new(result))
  }
}
