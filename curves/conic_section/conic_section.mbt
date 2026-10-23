///|
/// # Conic Sections
/// # 圆锥曲线
///
/// General second-degree curve Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0.
/// Classification via discriminant B^2 - 4AC into ellipse / parabola / hyperbola.
/// 一般二次曲线 Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0，
/// 通过判别式 B^2 - 4AC 分类为椭圆 / 抛物线 / 双曲线。


///|
/// Conic section type. / 圆锥曲线类型。
pub(all) enum ConicType {
  Ellipse
  Hyperbola
  Parabola
  Degenerate
}


///|
/// Conic section coefficients Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0.
/// 圆锥曲线系数 Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0。
pub struct Conic {
  a : Double
  b : Double
  c : Double
  d : Double
  e : Double
  f : Double
}


///|
/// Construct a conic from coefficients. / 由系数构造圆锥曲线。
pub fn Conic::new(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
) -> Conic {
  { a, b, c, d, e, f }
}


///|
/// Evaluate the conic polynomial at a point. / 在一点求值圆锥曲线多项式。
pub fn Conic::eval(conic : Conic, p : @core.Point2D) -> Double {
  let x = p.x()
  let y = p.y()
  conic.a * x * x +
  conic.b * x * y +
  conic.c * y * y +
  conic.d * x +
  conic.e * y +
  conic.f
}


///|
/// Check if a point lies on the conic. / 检查点是否在圆锥曲线上。
pub fn Conic::on_curve(conic : Conic, p : @core.Point2D, eps : Double) -> Bool {
  Conic::eval(conic, p).abs() <= eps
}
