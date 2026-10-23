///|
/// Reject component of v along u (v - project(v, u)). / 拒绝分量。
pub fn reject(v : @core.Point2D, u : @core.Point2D) -> @core.Point2D {
  let p = project(v, u)
  @core.Point2D::new(v.x() - p.x(), v.y() - p.y())
}
