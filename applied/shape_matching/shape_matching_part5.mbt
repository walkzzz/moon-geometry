///|
/// Apply 2D rigid transform (angle, tx, ty) to a point.
/// 对点应用 2D 刚体变换（角度, tx, ty）。
fn apply_rigid(
  p : @core.Point2D,
  angle : Double,
  tx : Double,
  ty : Double,
) -> @core.Point2D {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  @core.Point2D::new(c * p.x() - s * p.y() + tx, s * p.x() + c * p.y() + ty)
}
