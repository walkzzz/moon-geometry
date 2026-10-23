///|
/// Minkowski difference support function. / 闵可夫斯基差支撑函数。
pub fn minkowski_support(
  support_a : (Double, Double) -> @core.Point2D,
  support_b : (Double, Double) -> @core.Point2D,
  dx : Double,
  dy : Double,
) -> @core.Point2D {
  let pa = support_a(dx, dy)
  let pb = support_b(-dx, -dy)
  @core.Point2D::new(pa.x() - pb.x(), pa.y() - pb.y())
}
