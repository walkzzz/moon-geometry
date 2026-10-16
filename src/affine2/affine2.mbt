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
pub fn Affine2::apply(m : Affine2, p : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(m.a * p.x() + m.b * p.y() + m.tx, m.c * p.x() + m.d * p.y() + m.ty)
}

///|
/// Compose two affine transformations (m1 then m2). / 组合两个仿射变换（先 m1 后 m2）。
pub fn Affine2::compose(m1 : Affine2, m2 : Affine2) -> Affine2 {
  {
    a: m1.a * m2.a + m1.b * m2.c,
    b: m1.a * m2.b + m1.b * m2.d,
    tx: m1.a * m2.tx + m1.b * m2.ty + m1.tx,
    c: m1.c * m2.a + m1.d * m2.c,
    d: m1.c * m2.b + m1.d * m2.d,
    ty: m1.c * m2.tx + m1.d * m2.ty + m1.ty,
  }
}

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

///|
/// Apply affine to an array of points. / 将仿射变换应用于点数组。
pub fn Affine2::apply_batch(
  m : Affine2,
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    result.push(m.apply(p))
  }
  result
}