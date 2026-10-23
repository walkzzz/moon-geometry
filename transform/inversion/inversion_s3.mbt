///|
/// Compute the power of a point with respect to the inversion circle. / 计算点关于反演圆的幂。
pub fn Inversion::power(inv : Inversion, p : @core.Point2D) -> Double {
  let dx = p.x() - inv.center.x()
  let dy = p.y() - inv.center.y()
  dx * dx + dy * dy - inv.radius * inv.radius
}

///|
/// Check if a point is inside the inversion circle. / 检查点是否在反演圆内。
pub fn Inversion::is_inside(inv : Inversion, p : @core.Point2D) -> Bool {
  inv.power(p) < 0.0
}
