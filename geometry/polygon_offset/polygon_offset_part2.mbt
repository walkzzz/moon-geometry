///|
/// Compute the area of an offset polygon using Steiner formula for convex polygons. / 使用 Steiner 公式计算凸多边形偏移后的面积。
pub fn polygon_offset_area(
  poly : Array[@core.Point2D],
  dist : Double,
) -> Double {
  let n = poly.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area += poly[i].x() * poly[j].y() - poly[j].x() * poly[i].y()
  }
  area = area.abs() / 2.0
  let mut perimeter = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let dx = poly[j].x() - poly[i].x()
    let dy = poly[j].y() - poly[i].y()
    perimeter += (dx * dx + dy * dy).sqrt()
  }
  area + perimeter * dist + 3.14159265358979323846 * dist * dist
}

///|
/// Check if an offset polygon is valid (non-degenerate). / 检查偏移多边形是否有效（非退化）。
pub fn polygon_offset_valid(poly : Array[@core.Point2D], dist : Double) -> Bool {
  let offset = polygon_offset_outward(poly, dist)
  offset.length() >= 3
}
