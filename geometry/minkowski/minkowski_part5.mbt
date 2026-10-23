///|
/// Minkowski difference of two convex polygons: A ⊖ B = A ⊕ (-B).
/// Returns the result as an array of points (CCW).
/// / 两个凸多边形的 Minkowski 差：A ⊖ B = A ⊕ (-B)，返回 CCW 点数组。
pub fn minkowski_difference_convex(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Array[@core.Point2D] {
  let n2 = poly2.size()
  if n2 == 0 {
    return []
  }
  let neg_pts : Array[@core.Point2D] = []
  for i in 0..<n2 {
    let p = poly2.get(i)
    neg_pts.push(@core.Point2D::new(-p.x(), -p.y()))
  }
  let neg_poly = @core.Polygon::new(neg_pts)
  minkowski_sum_convex(poly1, neg_poly)
}

///|
/// Minkowski sum of a circle and a convex polygon (rounded polygon).
/// Returns (polygon vertices, radius) representing the rounded result.
/// / 圆与凸多边形的 Minkowski 和（圆角多边形），返回 (多边形顶点, 半径)。
pub fn minkowski_sum_circle_polygon(
  circle : @core.Circle,
  poly : @core.Polygon,
) -> (Array[@core.Point2D], Double) {
  let n = poly.size()
  if n == 0 {
    return ([], circle.radius)
  }
  let pts = ensure_ccw(poly)
  let r = circle.radius
  let cx = circle.center.x()
  let cy = circle.center.y()
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    result.push(@core.Point2D::new(pts[i].x() + cx, pts[i].y() + cy))
  }
  (result, r)
}
