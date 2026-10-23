///|
/// Evaluate cubic Hermite spline at t. / 计算三次 Hermite 样条在 t 处的值。
pub fn hermite_eval(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  m0 : @core.Point2D,
  m1 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let t3 = t2 * t
  let h00 = 2.0 * t3 - 3.0 * t2 + 1.0
  let h10 = t3 - 2.0 * t2 + t
  let h01 = -2.0 * t3 + 3.0 * t2
  let h11 = t3 - t2
  @core.Point2D::new(
    h00 * p0.x() + h10 * m0.x() + h01 * p1.x() + h11 * m1.x(),
    h00 * p0.y() + h10 * m0.y() + h01 * p1.y() + h11 * m1.y(),
  )
}
