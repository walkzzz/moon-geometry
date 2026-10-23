///|
/// Oblique projection with angles alpha and beta. / 以角度 alpha 和 beta 的斜投影。
pub fn oblique(
  p : @core.Point3D,
  alpha : Double,
  beta : Double,
) -> @core.Point2D {
  @core.Point2D::new(p.x + p.z * @math.cos(alpha), p.y + p.z * @math.sin(beta))
}