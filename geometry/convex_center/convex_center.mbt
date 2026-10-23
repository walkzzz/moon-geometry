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
