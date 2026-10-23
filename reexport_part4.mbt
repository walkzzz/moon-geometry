///|
/// Signed area of a polygon. / 多边形有符号面积。
pub fn polygon_signed_area(poly : Polygon) -> Double {
  @polygon.polygon_signed_area(poly)
}


///|
/// Absolute area of a polygon. / 多边形绝对面积。
pub fn polygon_area(poly : Polygon) -> Double {
  @polygon.polygon_area(poly)
}


///|
/// Perimeter of a polygon. / 多边形周长。
pub fn polygon_perimeter(poly : Polygon) -> Double {
  @polygon.polygon_perimeter(poly)
}


///|
/// Centroid of a polygon. / 多边形质心。
pub fn polygon_centroid(poly : Polygon) -> Point2D {
  @polygon.polygon_centroid(poly)
}


///|
/// Orientation of a polygon (CW/CCW/Collinear). / 多边形方向。
pub fn polygon_orientation(poly : Polygon) -> Orientation {
  @polygon.polygon_orientation(poly)
}


///|
/// Whether a polygon is convex. / 多边形是否为凸。
pub fn is_convex(poly : Polygon) -> Bool {
  @polygon.is_convex(poly)
}


///|
/// Point-in-polygon test (ray casting). / 点是否在多边形内。
pub fn point_in_polygon(p : Point2D, poly : Polygon) -> Bool {
  @polygon.point_in_polygon(p, poly)
}
