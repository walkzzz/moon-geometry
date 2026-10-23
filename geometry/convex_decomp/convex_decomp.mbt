///|
/// Check if a polygon is convex. / 检查多边形是否为凸多边形。
pub fn is_convex_polygon(poly : Array[@core.Point2D]) -> Bool {
  @polygon.is_convex(@core.Polygon::new(poly))
}
