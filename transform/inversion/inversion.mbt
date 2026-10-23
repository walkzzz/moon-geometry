///|
/// Geometric inversion through a circle. / 通过圆的几何反演。
pub struct Inversion {
  center : @core.Point2D
  radius : Double
}


///|
/// Create an inversion with given center and radius. / 创建以给定圆心和半径的反演。
pub fn Inversion::new(
  center : @core.Point2D,
  radius : Double,
) -> Inversion {
  { center, radius }
}


///|
/// Apply inversion to a point. / 将反演应用于点。
pub fn Inversion::apply(
  inv : Inversion,
  p : @core.Point2D,
) -> @core.Point2D? {
  let dx = p.x() - inv.center.x()
  let dy = p.y() - inv.center.y()
  let d2 = dx * dx + dy * dy
  if @core.approx_eq(d2, 0.0, 0.000000001) {
    return None
  }
  let r2 = inv.radius * inv.radius
  let factor = r2 / d2
  Some(@core.Point2D::new(inv.center.x() + factor * dx, inv.center.y() + factor * dy))
}
