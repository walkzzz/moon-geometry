///|
/// Compute offset polygon area (Steiner formula). / 使用 Steiner 公式计算偏移面积。
pub fn polygon_offset_area(poly : Array[Point2D], dist : Double) -> Double {
  @polygon_offset.polygon_offset_area(poly, dist)
}


///|
/// Check if offset polygon is valid. / 检查偏移多边形是否有效。
pub fn polygon_offset_valid(poly : Array[Point2D], dist : Double) -> Bool {
  @polygon_offset.polygon_offset_valid(poly, dist)
}

// ---------------------------------------------------------------------------
// polygon_holes: polygon with holes / 带孔多边形
// ---------------------------------------------------------------------------


///|
/// Polygon with holes type. / 带孔多边形类型。
pub type PolygonWithHoles = @polygon_holes.PolygonWithHoles


///|
/// Create a polygon with holes. / 创建带孔多边形。
pub fn polygon_with_holes_new(
  outer : Array[Point2D],
  holes : Array[Array[Point2D]],
) -> PolygonWithHoles {
  @polygon_holes.polygon_with_holes_new(outer, holes)
}


///|
/// Area of polygon with holes. / 带孔多边形面积。
pub fn polygon_with_holes_area(p : PolygonWithHoles) -> Double {
  @polygon_holes.polygon_with_holes_area(p)
}
