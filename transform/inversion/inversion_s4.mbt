///|
/// Check if a point is on the inversion circle. / 检查点是否在反演圆上。
pub fn Inversion::is_on_circle(inv : Inversion, p : @core.Point2D) -> Bool {
  @core.approx_eq(inv.power(p), 0.0, 0.0001)
}

///|
/// Invert a line (not passing through center) to a circle. / 将不过圆心的直线反演为圆。
pub fn Inversion::invert_line(
  inv : Inversion,
  a : Double,
  b : Double,
  c : Double,
) -> @core.Circle? {
  ignore(c)
  let denom = a * a + b * b
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return None
  }
  let cx = inv.center.x() - a * inv.radius * inv.radius / (2.0 * denom)
  let cy = inv.center.y() - b * inv.radius * inv.radius / (2.0 * denom)
  let r = inv.radius * inv.radius / (2.0 * denom.sqrt())
  Some(@core.Circle::new(@core.Point2D::new(cx, cy), r))
}
