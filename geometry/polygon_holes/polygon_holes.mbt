///|
/// Polygon with holes: outer boundary plus inner hole boundaries. / 带孔多边形：外边界加内孔边界。
pub struct PolygonWithHoles {
  outer : Array[@core.Point2D]
  holes : Array[Array[@core.Point2D]]
}

///|
/// Create a polygon with holes. / 创建带孔多边形。
pub fn polygon_with_holes_new(
  outer : Array[@core.Point2D],
  holes : Array[Array[@core.Point2D]],
) -> PolygonWithHoles {
  { outer, holes, }
}

///|
/// Compute area of polygon with holes (outer area minus holes areas). / 计算带孔多边形面积（外面积减去孔面积）。
pub fn polygon_with_holes_area(p : PolygonWithHoles) -> Double {
  let outer_area = @polygon.polygon_area(@core.Polygon::new(p.outer))
  let mut holes_area = 0.0
  for hole in p.holes {
    holes_area += @polygon.polygon_area(@core.Polygon::new(hole)).abs()
  }
  outer_area.abs() - holes_area
}
