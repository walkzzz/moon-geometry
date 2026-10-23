///|
/// Compute visibility polygon from a point inside a convex polygon. / 计算凸多边形内一点的可见多边形。
pub fn visibility_polygon_convex(
  poly : Array[@core.Point2D],
  pt : @core.Point2D,
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    if is_visible(poly, pt, poly[i]) {
      result.push(poly[i])
    }
  }
  result
}
