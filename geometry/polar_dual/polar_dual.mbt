///|
/// Polar dual of a point (assuming origin inside). / 点的极对偶。
pub fn polar_dual_point(p : @core.Point2D) -> @core.Point2D {
  let d = p.x() * p.x() + p.y() * p.y()
  if d < 0.000000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  @core.Point2D::new(p.x() / d, p.y() / d)
}

///|
/// Polar dual of a convex polygon (assuming origin inside). / 凸多边形的极对偶。
pub fn polar_dual(poly : @core.Polygon) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.vertices.length()
  for i in 0..<n {
    result.push(polar_dual_point(poly.vertices[i]))
  }
  result
}
