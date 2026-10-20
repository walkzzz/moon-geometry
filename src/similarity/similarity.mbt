///|
/// Similarity transformation: uniform scale + rotation + translation. / 相似变换：均匀缩放 + 旋转 + 平移。
pub struct Similarity {
  scale : Double
  angle : Double
  tx : Double
  ty : Double
}

///|
/// Create identity similarity transformation. / 创建单位相似变换。
pub fn Similarity::identity() -> Similarity {
  { scale: 1.0, angle: 0.0, tx: 0.0, ty: 0.0 }
}

///|
/// Create similarity from scale only. / 仅由缩放创建相似变换。
pub fn Similarity::scaling(s : Double) -> Similarity {
  { scale: s, angle: 0.0, tx: 0.0, ty: 0.0 }
}

///|
/// Create similarity from rotation only. / 仅由旋转创建相似变换。
pub fn Similarity::rotation(angle : Double) -> Similarity {
  { scale: 1.0, angle, tx: 0.0, ty: 0.0 }
}

///|
/// Create similarity from translation only. / 仅由平移创建相似变换。
pub fn Similarity::translation(tx : Double, ty : Double) -> Similarity {
  { scale: 1.0, angle: 0.0, tx, ty }
}

///|
/// Apply similarity to a point. / 将相似变换应用于点。
pub impl @core.PointTransform for Similarity with apply(s, p) {
  let c = s.scale * @math.cos(s.angle)
  let sn = s.scale * @math.sin(s.angle)
  @core.Point2D::new(c * p.x() - sn * p.y() + s.tx, sn * p.x() + c * p.y() + s.ty)
}

///|
/// Compose two similarity transformations (s1 then s2). / 组合两个相似变换（先 s1 后 s2）。
pub fn Similarity::compose(s1 : Similarity, s2 : Similarity) -> Similarity {
  let c = @math.cos(s1.angle)
  let sn = @math.sin(s1.angle)
  {
    scale: s1.scale * s2.scale,
    angle: s1.angle + s2.angle,
    tx: s1.scale * (c * s2.tx - sn * s2.ty) + s1.tx,
    ty: s1.scale * (sn * s2.tx + c * s2.ty) + s1.ty,
  }
}

///|
/// Invert similarity transformation. / 求相似变换的逆。
pub fn Similarity::inverse(s : Similarity) -> Similarity? {
  if @core.approx_eq(s.scale, 0.0, 0.000000001) {
    return None
  }
  let inv_s = 1.0 / s.scale
  let c = @math.cos(s.angle)
  let sn = @math.sin(s.angle)
  Some({
    scale: inv_s,
    angle: -s.angle,
    tx: -inv_s * (c * s.tx + sn * s.ty),
    ty: -inv_s * (-sn * s.tx + c * s.ty),
  })
}

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
  let s = { scale, angle, tx: 0.0, ty: 0.0 }
  let transformed = s.apply(src1)
  { scale, angle, tx: dst1.x() - transformed.x(), ty: dst1.y() - transformed.y() }
}