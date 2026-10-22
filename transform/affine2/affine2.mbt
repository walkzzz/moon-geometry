///|
/// 2D affine transformation: [a b tx; c d ty; 0 0 1]. / 二维仿射变换：[a b tx; c d ty; 0 0 1]。
pub struct Affine2 {
  a : Double
  b : Double
  tx : Double
  c : Double
  d : Double
  ty : Double
}

///|
/// Create identity affine transformation. / 创建单位仿射变换。
pub fn Affine2::identity() -> Affine2 {
  { a: 1.0, b: 0.0, tx: 0.0, c: 0.0, d: 1.0, ty: 0.0 }
}

///|
/// Create affine from translation. / 由平移创建仿射变换。
pub fn Affine2::translation(tx : Double, ty : Double) -> Affine2 {
  { a: 1.0, b: 0.0, tx, c: 0.0, d: 1.0, ty }
}

///|
/// Create affine from scaling. / 由缩放创建仿射变换。
pub fn Affine2::scale(sx : Double, sy : Double) -> Affine2 {
  { a: sx, b: 0.0, tx: 0.0, c: 0.0, d: sy, ty: 0.0 }
}

///|
/// Create affine from shear. / 由剪切创建仿射变换。
pub fn Affine2::shear(shx : Double, shy : Double) -> Affine2 {
  { a: 1.0, b: shx, tx: 0.0, c: shy, d: 1.0, ty: 0.0 }
}

///|
/// Apply affine to a point. / 将仿射变换应用于点。
pub impl @core.PointTransform for Affine2 with apply(m, p) {
  @core.Point2D::new(m.a * p.x() + m.b * p.y() + m.tx, m.c * p.x() + m.d * p.y() + m.ty)
}

///|
pub extend Affine2 with @core.PointTransform::{apply, apply_batch}

///|
/// Compose two affine transformations (self after other). / 组合两个仿射变换（先 other 后 self）。
pub impl @core.Composable for Affine2 with compose(self, other) {
  {
    a: self.a * other.a + self.b * other.c,
    b: self.a * other.b + self.b * other.d,
    tx: self.a * other.tx + self.b * other.ty + self.tx,
    c: self.c * other.a + self.d * other.c,
    d: self.c * other.b + self.d * other.d,
    ty: self.c * other.tx + self.d * other.ty + self.ty,
  }
}

///|
pub extend Affine2 with @core.Composable::{compose}

///|
/// Compute determinant of affine. / 计算仿射变换行列式。
pub fn Affine2::determinant(m : Affine2) -> Double {
  m.a * m.d - m.b * m.c
}

///|
/// Invert affine transformation. / 求仿射变换的逆。
pub fn Affine2::inverse(m : Affine2) -> Affine2? {
  let det = m.a * m.d - m.b * m.c
  if @core.approx_eq(det, 0.0, 0.000000001) {
    return None
  }
  let inv_det = 1.0 / det
  let inv_a = m.d * inv_det
  let inv_b = -m.b * inv_det
  let inv_c = -m.c * inv_det
  let inv_d = m.a * inv_det
  Some({
    a: inv_a,
    b: inv_b,
    tx: -(inv_a * m.tx + inv_b * m.ty),
    c: inv_c,
    d: inv_d,
    ty: -(inv_c * m.tx + inv_d * m.ty),
  })
}

