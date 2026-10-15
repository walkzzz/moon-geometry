///|
/// Intersection points of a circle and a line segment (0/1/2 points).
/// Returns 0, 1, or 2 intersection points.
/// 圆与线段的交点（0/1/2 个）。
/// 返回 0、1 或 2 个交点。
pub fn circle_segment_intersect(
  circle : @core.Circle,
  seg : @core.Segment
) -> Array[@core.Point2D] {
  let cx = circle.center.x
  let cy = circle.center.y
  let r = circle.radius
  let ax = seg.start.x
  let ay = seg.start.y
  let bx = seg.end.x
  let by = seg.end.y
  let dx = bx - ax
  let dy = by - ay
  let fx = ax - cx
  let fy = ay - cy
  let a = dx * dx + dy * dy
  let b = 2.0 * (fx * dx + fy * dy)
  let c = fx * fx + fy * fy - r * r
  let disc = b * b - 4.0 * a * c
  let result : Array[@core.Point2D] = []
  if disc < 0.0 || a == 0.0 {
    return result
  }
  let sq = disc.sqrt()
  let t1 = (-b - sq) / (2.0 * a)
  let t2 = (-b + sq) / (2.0 * a)
  if t1 >= 0.0 && t1 <= 1.0 {
    result.push(@core.Point2D::new(ax + t1 * dx, ay + t1 * dy))
  }
  if t2 >= 0.0 && t2 <= 1.0 {
    result.push(@core.Point2D::new(ax + t2 * dx, ay + t2 * dy))
  }
  result
}

///|
/// Intersection points of two circles (0/1/2 points).
/// Returns 0, 1, or 2 intersection points.
/// 两圆交点（0/1/2 个）。
/// 返回 0、1 或 2 个交点。
pub fn circle_circle_intersect(
  c1 : @core.Circle,
  c2 : @core.Circle
) -> Array[@core.Point2D] {
  let dx = c2.center.x - c1.center.x
  let dy = c2.center.y - c1.center.y
  let d = (dx * dx + dy * dy).sqrt()
  let result : Array[@core.Point2D] = []
  if d == 0.0 {
    return result
  }
  if d > c1.radius + c2.radius {
    return result
  }
  if d < (c1.radius - c2.radius).abs() {
    return result
  }
  let a = (c1.radius * c1.radius - c2.radius * c2.radius + d * d) / (2.0 * d)
  let h_sq = c1.radius * c1.radius - a * a
  let px = c1.center.x + a * dx / d
  let py = c1.center.y + a * dy / d
  if h_sq <= 0.0 {
    result.push(@core.Point2D::new(px, py))
    return result
  }
  let h = h_sq.sqrt()
  let rx = -dy * h / d
  let ry = dx * h / d
  result.push(@core.Point2D::new(px + rx, py + ry))
  result.push(@core.Point2D::new(px - rx, py - ry))
  result
}

///|
/// Intersection points of a circle and an infinite line (0/1/2 points).
/// Returns 0, 1, or 2 intersection points.
/// 圆与无限直线的交点（0/1/2 个）。
/// 返回 0、1 或 2 个交点。
pub fn circle_line_intersect(
  circle : @core.Circle,
  line : @core.Line
) -> Array[@core.Point2D] {
  let cx = circle.center.x
  let cy = circle.center.y
  let r = circle.radius
  let a = line.a
  let b = line.b
  let c = line.c
  let denom = a * a + b * b
  let result : Array[@core.Point2D] = []
  if denom == 0.0 {
    return result
  }
  let dist = (a * cx + b * cy + c).abs() / denom.sqrt()
  if dist > r {
    return result
  }
  let x0 = (b * (b * cx - a * cy) - a * c) / denom
  let y0 = (a * (-b * cx + a * cy) - b * c) / denom
  if dist == r {
    result.push(@core.Point2D::new(x0, y0))
    return result
  }
  let offset = (r * r - dist * dist).sqrt() / denom.sqrt()
  let dx = -b * offset
  let dy = a * offset
  result.push(@core.Point2D::new(x0 + dx, y0 + dy))
  result.push(@core.Point2D::new(x0 - dx, y0 - dy))
  result
}

///|
/// Intersection points of a circle and a polygon boundary (0/1/2+ points).
/// Checks each edge of the polygon for circle intersection.
/// 圆与多边形边界的交点（0/1/2+ 个）。
/// 检查多边形每条边与圆的交点。
pub fn circle_polygon_intersect(
  circle : @core.Circle,
  poly : @core.Polygon
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