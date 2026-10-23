///|
/// Project vector v onto vector u. / 向量 v 投影到向量 u。
pub fn project(v : @core.Point2D, u : @core.Point2D) -> @core.Point2D {
  let dot = v.x() * u.x() + v.y() * u.y()
  let len_sq = u.x() * u.x() + u.y() * u.y()
  if len_sq < @core.default_eps {
    return @core.Point2D::new(0.0, 0.0)
  }
  let t = dot / len_sq
  @core.Point2D::new(t * u.x(), t * u.y())
}


///|
/// Linear interpolation between a and b. / 线性插值。
pub fn lerp(a : @core.Point2D, b : @core.Point2D, t : Double) -> @core.Point2D {
  @core.Point2D::new(a.x() + (b.x() - a.x()) * t, a.y() + (b.y() - a.y()) * t)
}


///|
/// Perpendicular vector (rotated 90° CCW). / 垂直向量（逆时针旋转90°）。
pub fn perp(v : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(-v.y(), v.x())
}
