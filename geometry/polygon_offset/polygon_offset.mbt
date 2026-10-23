///|
/// Offset a polygon outward by a distance. / 将多边形向外偏移指定距离。
pub fn polygon_offset_outward(
  poly : Array[@core.Point2D],
  dist : Double,
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let prev = poly[(i - 1 + n) % n]
    let curr = poly[i]
    let next = poly[(i + 1) % n]
    let dx1 = curr.x() - prev.x()
    let dy1 = curr.y() - prev.y()
    let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
    let dx2 = next.x() - curr.x()
    let dy2 = next.y() - curr.y()
    let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
    if len1 < 0.000000000001 || len2 < 0.000000000001 {
      result.push(curr)
      continue
    }
    let nx1 = dy1 / len1
    let ny1 = -dx1 / len1
    let nx2 = dy2 / len2
    let ny2 = -dx2 / len2
    let nx = (nx1 + nx2) / 2.0
    let ny = (ny1 + ny2) / 2.0
    let nlen = (nx * nx + ny * ny).sqrt()
    if nlen < 0.000000000001 {
      result.push(
        @core.Point2D::new(curr.x() + nx1 * dist, curr.y() + ny1 * dist),
      )
    } else {
      let scale = dist / nlen
      result.push(
        @core.Point2D::new(curr.x() + nx * scale, curr.y() + ny * scale),
      )
    }
  }
  result
}

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

///|
/// Offset a polygon inward by a distance. / 将多边形向内偏移指定距离。
pub fn polygon_offset_inward(
  poly : Array[@core.Point2D],
  dist : Double,
) -> Array[@core.Point2D] {
  polygon_offset_outward(poly, -dist)
}
