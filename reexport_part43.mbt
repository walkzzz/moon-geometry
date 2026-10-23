///|
/// Check if point is in polygon with holes. / 检查点是否在带孔多边形内。
pub fn polygon_with_holes_contains(p : PolygonWithHoles, pt : Point2D) -> Bool {
  @polygon_holes.polygon_with_holes_contains(p, pt)
}


///|
/// Perimeter of polygon with holes. / 带孔多边形周长。
pub fn polygon_with_holes_perimeter(p : PolygonWithHoles) -> Double {
  @polygon_holes.polygon_with_holes_perimeter(p)
}


///|
/// Count holes. / 计算孔数。
pub fn polygon_with_holes_count(p : PolygonWithHoles) -> Int {
  @polygon_holes.polygon_with_holes_count(p)
}

// ---------------------------------------------------------------------------
// visibility: visibility polygon / 可见性多边形
// ---------------------------------------------------------------------------


///|
/// Check if two points are mutually visible. / 检查两点是否互相可见。
pub fn is_visible(poly : Array[Point2D], from : Point2D, to : Point2D) -> Bool {
  @visibility.is_visible(poly, from, to)
}


///|
/// Visibility polygon from a point in convex polygon. / 凸多边形内一点的可见多边形。
pub fn visibility_polygon_convex(poly : Array[Point2D], pt : Point2D) -> Array[Point2D] {
  @visibility.visibility_polygon_convex(poly, pt)
}
