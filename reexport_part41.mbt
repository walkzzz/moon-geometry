///|
/// Width in a direction. / 方向宽度。
pub fn width_in_direction(points : Array[Point2D], dir : Point2D) -> Double {
  @support.width_in_direction(points, dir)
}

// ---------------------------------------------------------------------------
// separating: separating axis / 分离轴
// ---------------------------------------------------------------------------


///|
/// Find separating axis. / 寻找分离轴。
pub fn find_separating_axis(poly1 : Polygon, poly2 : Polygon) -> Line? {
  @separating.find_separating_axis(poly1, poly2)
}


///|
/// Separating distance. / 分离距离。
pub fn separating_distance(poly1 : Polygon, poly2 : Polygon) -> Double {
  @separating.separating_distance(poly1, poly2)
}


///|
/// Check if two convex polygons are separated. / 检查两凸多边形是否分离。
pub fn are_separated(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @separating.are_separated(poly1, poly2)
}
// ---------------------------------------------------------------------------
// polygon_offset: polygon offset / 多边形偏移
// ---------------------------------------------------------------------------


///|
/// Offset a polygon outward by a distance. / 将多边形向外偏移指定距离。
pub fn polygon_offset_outward(poly : Array[Point2D], dist : Double) -> Array[Point2D] {
  @polygon_offset.polygon_offset_outward(poly, dist)
}


///|
/// Offset a polygon inward by a distance. / 将多边形向内偏移指定距离。
pub fn polygon_offset_inward(poly : Array[Point2D], dist : Double) -> Array[Point2D] {
  @polygon_offset.polygon_offset_inward(poly, dist)
}
