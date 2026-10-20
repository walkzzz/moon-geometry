///|
/// Rigid transformation: rotation + translation (preserves distances). / 刚体变换：旋转 + 平移（保持距离）。
pub struct Rigid {
  angle : Double
  tx : Double
  ty : Double
}

///|
/// Create identity rigid transformation. / 创建单位刚体变换。
pub fn Rigid::identity() -> Rigid {
  { angle: 0.0, tx: 0.0, ty: 0.0 }
}

///|
/// Create rigid from translation only. / 仅由平移创建刚体变换。
pub fn Rigid::translation(tx : Double, ty : Double) -> Rigid {
  { angle: 0.0, tx, ty }
}

///|
/// Create rigid from rotation only. / 仅由旋转创建刚体变换。
pub fn Rigid::rotation(angle : Double) -> Rigid {
  { angle, tx: 0.0, ty: 0.0 }
}

///|
/// Apply rigid transformation to a point. / 将刚体变换应用于点。
pub impl @core.PointTransform for Rigid with apply(r, p) {
  let c = @math.cos(r.angle)
  let s = @math.sin(r.angle)
  @core.Point2D::new(c * p.x() - s * p.y() + r.tx, s * p.x() + c * p.y() + r.ty)
}

///|
pub extend Rigid with @core.PointTransform::{apply, apply_batch}

///|
/// Compose two rigid transformations (r1 then r2). / 组合两个刚体变换（先 r1 后 r2）。
pub fn Rigid::compose(r1 : Rigid, r2 : Rigid) -> Rigid {
  let c = @math.cos(r1.angle)
  let s = @math.sin(r1.angle)
  {
    angle: r1.angle + r2.angle,
    tx: c * r2.tx - s * r2.ty + r1.tx,
    ty: s * r2.tx + c * r2.ty + r1.ty,
  }
}

///|
/// Invert rigid transformation. / 求刚体变换的逆。
pub fn Rigid::inverse(r : Rigid) -> Rigid {
  let c = @math.cos(r.angle)
  let s = @math.sin(r.angle)
  {
    angle: -r.angle,
    tx: -(c * r.tx + s * r.ty),
    ty: -(-s * r.tx + c * r.ty),
  }
}

///|

/// Estimate rigid transform from two point correspondences. / 由两对对应点估计刚体变换。
pub fn Rigid::from_correspondence(
  src1 : @core.Point2D,
  dst1 : @core.Point2D,
  src2 : @core.Point2D,
  dst2 : @core.Point2D,
) -> Rigid {
  let src_angle = @math.atan2(src2.y() - src1.y(), src2.x() - src1.x())
  let dst_angle = @math.atan2(dst2.y() - dst1.y(), dst2.x() - dst1.x())
  let angle = dst_angle - src_angle
  let r = Rigid::rotation(angle)
  let transformed = r.apply(src1)
  { angle, tx: dst1.x() - transformed.x(), ty: dst1.y() - transformed.y() }
}