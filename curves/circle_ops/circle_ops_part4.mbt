///|
/// Intersection points of a circle and a polygon boundary (0/1/2+ points).
/// Checks each edge of the polygon for circle intersection.
/// 圆与多边形边界的交点（0/1/2+ 个）。
/// 检查多边形每条边与圆的交点。
pub fn circle_polygon_intersect(
  circle : @core.Circle,
  poly : @core.Polygon,
) -> Array[@core.Point2D] {
  let n = poly.size()
  let result : Array[@core.Point2D] = []
  if n < 2 {
    return result
  }
  for i in 0..<n {
    let seg = @core.Segment::new(poly.get(i), poly.get((i + 1) % n))
    let pts = circle_segment_intersect(circle, seg)
    for p in pts {
      result.push(p)
    }
  }
  result
}
