///|
/// Check if a point is inside the polygon with holes. / 检查点是否在带孔多边形内。
pub fn polygon_with_holes_contains(
  p : PolygonWithHoles,
  pt : @core.Point2D,
) -> Bool {
  if !@polygon.point_in_polygon(pt, @core.Polygon::new(p.outer)) {
    return false
  }
  for hole in p.holes {
    if @polygon.point_in_polygon(pt, @core.Polygon::new(hole)) {
      return false
    }
  }
  true
}
