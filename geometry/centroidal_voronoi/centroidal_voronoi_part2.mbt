///|
/// Compute the centroid of a polygon. / 计算多边形的质心。
pub fn compute_centroid(poly : Array[@core.Point2D]) -> @core.Point2D {
  let n = poly.length()
  if n < 3 {
    if n == 0 {
      return @core.Point2D::new(0.0, 0.0)
    }
    let mut cx = 0.0
    let mut cy = 0.0
    for p in poly {
      cx += p.x()
      cy += p.y()
    }
    return @core.Point2D::new(cx / n.to_double(), cy / n.to_double())
  }
  let mut area = 0.0
  let mut cx = 0.0
  let mut cy = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let cross = poly[i].x() * poly[j].y() - poly[j].x() * poly[i].y()
    area += cross
    cx += (poly[i].x() + poly[j].x()) * cross
    cy += (poly[i].y() + poly[j].y()) * cross
  }
  area *= 0.5
  if area.abs() < 0.0000000001 {
    let mut mx = 0.0
    let mut my = 0.0
    for p in poly {
      mx += p.x()
      my += p.y()
    }
    return @core.Point2D::new(mx / n.to_double(), my / n.to_double())
  }
  @core.Point2D::new(cx / (6.0 * area), cy / (6.0 * area))
}
