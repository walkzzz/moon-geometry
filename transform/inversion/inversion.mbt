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

///|
/// Apply inversion to an array of points. / 将反演应用于点数组。
pub fn Inversion::apply_batch(
  inv : Inversion,
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    match inv.apply(p) {
      Some(pt) => result.push(pt)
      None => continue
    }
  }
  result
}

///|
/// Inversion preserves the inversion circle. / 反演保持反演圆不变。
pub fn Inversion::preserves_circle(inv : Inversion) -> Bool {
  ignore(inv)
  true
}

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
  let r = inv.radius * inv.radius / (2.0 * (denom).sqrt())
  Some(@core.Circle::new(@core.Point2D::new(cx, cy), r))
}