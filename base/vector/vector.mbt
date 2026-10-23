///|
/// Normalize a 2D vector to unit length. / 2D向量归一化。
pub fn normalize(v : @core.Point2D) -> @core.Point2D {
  let len = (v.x() * v.x() + v.y() * v.y()).sqrt()
  if len < @core.default_eps {
    return @core.Point2D::new(0.0, 0.0)
  }
  @core.Point2D::new(v.x() / len, v.y() / len)
}


///|
/// Reflect vector v across normal n. / 向量 v 关于法线 n 反射。
pub fn reflect(v : @core.Point2D, n : @core.Point2D) -> @core.Point2D {
  let dot = v.x() * n.x() + v.y() * n.y()
  @core.Point2D::new(v.x() - 2.0 * dot * n.x(), v.y() - 2.0 * dot * n.y())
}
