///|
/// Estimate similarity from two point correspondences. / 将相似变换应用于点对。
pub fn Similarity::from_correspondence(
  src1 : @core.Point2D,
  dst1 : @core.Point2D,
  src2 : @core.Point2D,
  dst2 : @core.Point2D,
) -> Similarity {
  let src_len = src1.dist(src2)
  let dst_len = dst1.dist(dst2)
  let scale = if src_len > 0.0 { dst_len / src_len } else { 1.0 }
  let src_angle = @math.atan2(src2.y() - src1.y(), src2.x() - src1.x())
  let dst_angle = @math.atan2(dst2.y() - dst1.y(), dst2.x() - dst1.x())
  let angle = dst_angle - src_angle
  let s = { scale, angle, tx: 0.0, ty: 0.0, }
  let transformed = s.apply(src1)
  {
    scale,
    angle,
    tx: dst1.x() - transformed.x(),
    ty: dst1.y() - transformed.y(),
  }
}
