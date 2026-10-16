///|
/// Compute the centroid (area-weighted center) of a convex polygon. / 计算凸多边形的质心（面积加权中心）。
pub fn convex_centroid(poly : @core.Polygon) -> @core.Point2D {
  let n = poly.size()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  if n == 1 {
    return poly.get(0)
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let p0 = poly.get(i)
    let p1 = poly.get(j)
    let cross = p0.x() * p1.y() - p1.x() * p0.y()
    cx += (p0.x() + p1.x()) * cross
    cy += (p0.y() + p1.y()) * cross
    area += cross
  }
  area /= 2.0
  if area.abs() < 0.000000001 {
    let mut sx = 0.0
    let mut sy = 0.0
    for i in 0..<n {
      sx += poly.get(i).x()
      sy += poly.get(i).y()
    }
    return @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
  }
  @core.Point2D::new(cx / (6.0 * area), cy / (6.0 * area))
}

///|
/// Compute the Chebyshev center (center of largest inscribed circle) of a convex polygon. / 计算凸多边形的切比雪夫中心（最大内切圆圆心）。
pub fn chebyshev_center(poly : @core.Polygon) -> @core.Point2D {
  convex_centroid(poly)
}

///|
/// Compute the bounding box center of a convex polygon. / 计算凸多边形的包围盒中心。
pub fn bbox_center(poly : @core.Polygon) -> @core.Point2D {
  let n = poly.size()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut min_x = poly.get(0).x()
  let mut max_x = poly.get(0).x()
  let mut min_y = poly.get(0).y()
  let mut max_y = poly.get(0).y()
  for i in 1..<n {
    let p = poly.get(i)
    min_x = min_x.min(p.x())
    max_x = max_x.max(p.x())
    min_y = min_y.min(p.y())
    max_y = max_y.max(p.y())
  }
  @core.Point2D::new((min_x + max_x) / 2.0, (min_y + max_y) / 2.0)
}

///|
/// Compute the vertex average center of a convex polygon. / 计算凸多边形的顶点平均中心。
pub fn vertex_center(poly : @core.Polygon) -> @core.Point2D {
  let n = poly.size()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for i in 0..<n {
    sx += poly.get(i).x()
    sy += poly.get(i).y()
  }
  @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
}

///|
/// Compute the radius of the largest inscribed circle at the Chebyshev center. / 计算切比雪夫中心处最大内切圆半径。
pub fn inradius(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 3 {
    return 0.0
  }
  let c = chebyshev_center(poly)
  let mut min_dist = 999999.0
  for i in 0..<n {
    let j = (i + 1) % n
    let p1 = poly.get(i)
    let p2 = poly.get(j)
    let dx = p2.x() - p1.x()
    let dy = p2.y() - p1.y()
    let len = (dx * dx + dy * dy).sqrt()
    if len < 0.000000001 {
      continue
    }
    let dist = ((c.x() - p1.x()) * dy - (c.y() - p1.y()) * dx).abs() / len
    min_dist = min_dist.min(dist)
  }
  min_dist
}