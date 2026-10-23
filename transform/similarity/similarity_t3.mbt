///|
/// Apply similarity to a point. / 将相似变换应用于点。
pub impl @core.PointTransform for Similarity with apply(s, p) {
  let c = s.scale * @math.cos(s.angle)
  let sn = s.scale * @math.sin(s.angle)
  @core.Point2D::new(c * p.x() - sn * p.y() + s.tx, sn * p.x() + c * p.y() + s.ty)
}


///|
pub extend Similarity with @core.PointTransform::{apply, apply_batch}
