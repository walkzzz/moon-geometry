///|
/// Ensure a polygon is counter-clockwise oriented.
/// Returns a CCW vertex array. / 确保多边形为逆时针方向，返回 CCW 顶点数组。
fn ensure_ccw(poly : @core.Polygon) -> Array[@core.Point2D] {
  let n = poly.size()
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  if n < 3 {
    return pts
  }
  let area = @polygon.polygon_signed_area(poly)
  if area < 0.0 {
    let reversed : Array[@core.Point2D] = []
    for i in 0..<n {
      reversed.push(pts[n - 1 - i])
    }
    return reversed
  }
  pts
}
