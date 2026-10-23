///|
/// O(log n) point-in-convex-polygon test.
/// Uses binary search on the fan triangulation from vertex 0.
/// Polygon must be convex and CCW.
///
/// O(log n) 凸多边形点包含检测。多边形必须为凸且 CCW。
pub fn point_in_convex_polygon(poly : @core.Polygon, p : @core.Point2D) -> Bool {
  let n = poly.size()
  if n == 0 {
    return false
  }
  if n == 1 {
    return @core.approx_eq(poly.get(0).x(), p.x(), 0.0000000001) &&
      @core.approx_eq(poly.get(0).y(), p.y(), 0.0000000001)
  }
  let p0 = poly.get(0)
  if @core.turn(p0, poly.get(1), p) < 0.0 {
    return false
  }
  if @core.turn(p0, poly.get(n - 1), p) > 0.0 {
    return false
  }
  let mut lo = 1
  let mut hi = n - 1
  while hi - lo > 1 {
    let mid = (lo + hi) / 2
    if @core.turn(p0, poly.get(mid), p) > 0.0 {
      lo = mid
    } else {
      hi = mid
    }
  }
  @core.turn(poly.get(lo), poly.get(hi), p) >= 0.0
}
