///|
/// Locate which trapezoid contains a query point. / 定位包含查询点的梯形。
pub fn trapezoidal_locate(
  map : TrapezoidalMap,
  p : @core.Point2D,
) -> Int {
  for i in 0..<map.trapezoids.length() {
    let t = map.trapezoids[i]
    if p.x() >= t.left && p.x() <= t.right {
      return i
    }
  }
  -1
}
