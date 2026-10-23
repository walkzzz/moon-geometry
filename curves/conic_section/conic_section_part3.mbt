///|
/// Center of the conic (ellipse / hyperbola). Returns None for parabola.
/// 圆锥曲线中心（椭圆 / 双曲线），抛物线返回 None。
pub fn Conic::center(conic : Conic) -> @core.Point2D? {
  let eps = 0.0000000001
  let det = 4.0 * conic.a * conic.c - conic.b * conic.b
  if det.abs() < eps {
    return None
  }
  let cx = (conic.b * conic.e - 2.0 * conic.c * conic.d) / det
  let cy = (conic.b * conic.d - 2.0 * conic.a * conic.e) / det
  Some(@core.Point2D::new(cx, cy))
}


///|
/// Tangent line at a point on the conic. / 圆锥曲线上一点处的切线。
/// Returns line coefficients (a, b, c) for a*x + b*y + c = 0.
/// 返回直线系数 (a, b, c)，满足 a*x + b*y + c = 0。
pub fn Conic::tangent_at(conic : Conic, p : @core.Point2D) -> (Double, Double, Double) {
  let x0 = p.x()
  let y0 = p.y()
  let la = 2.0 * conic.a * x0 + conic.b * y0 + conic.d
  let lb = conic.b * x0 + 2.0 * conic.c * y0 + conic.e
  let lc = conic.d * x0 + conic.e * y0 + 2.0 * conic.f
  (la, lb, lc)
}
