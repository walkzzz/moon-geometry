///|
/// Unit normal at a point on the curve. / 曲线上一点处的单位法向量。
pub fn normal(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : @core.Point2D,
) -> @core.Point2D {
  let gx = fx(p.x(), p.y())
  let gy = fy(p.x(), p.y())
  let norm = (gx * gx + gy * gy).sqrt()
  if norm < 0.0000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  @core.Point2D::new(gx / norm, gy / norm)
}

///|
/// Curvature of the implicit curve at a point.
/// kappa = (fxx*fy^2 - 2*fxy*fx*fy + fyy*fx^2) / (fx^2 + fy^2)^(3/2)
/// 隐式曲线在一点处的曲率。
pub fn curvature(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  fxx : (Double, Double) -> Double,
  fxy : (Double, Double) -> Double,
  fyy : (Double, Double) -> Double,
  p : @core.Point2D,
) -> Double {
  let x = p.x()
  let y = p.y()
  let a = fx(x, y)
  let b = fy(x, y)
  let aa = fxx(x, y)
  let ab = fxy(x, y)
  let bb = fyy(x, y)
  let denom = @math.pow(a * a + b * b, 1.5)
  if denom < 0.0000000001 {
    return 0.0
  }
  (aa * b * b - 2.0 * ab * a * b + bb * a * a) / denom
}
