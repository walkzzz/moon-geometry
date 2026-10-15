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
  { outer, holes }
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

///|
/// Compute total perimeter (outer + holes). / 计算总周长（外边界加孔边界）。
pub fn polygon_with_holes_perimeter(p : PolygonWithHoles) -> Double {
  let mut perim = 0.0
  let n = p.outer.length()
  for i in 0..<n {
    let j = (i + 1) % n
    perim += p.outer[i].dist(p.outer[j])
  }
  for hole in p.holes {
    let hn = hole.length()
    for i in 0..<hn {
      let j = (i + 1) % hn
      perim += hole[i].dist(hole[j])
    }
  }
  perim
}

///|
/// Count the number of holes. / 计算孔的数量。
pub fn polygon_with_holes_count(p : PolygonWithHoles) -> Int {
  p.holes.length()
}