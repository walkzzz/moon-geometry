///|
/// Newton correction along the gradient to bring a point onto the curve.
/// 沿梯度牛顿校正将点拉回曲线上。
pub fn newton_correct(
  f : (Double, Double) -> Double,
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : @core.Point2D,
  max_iter : Int32,
) -> @core.Point2D {
  let mut x = p.x()
  let mut y = p.y()
  for _ in 0..<max_iter {
    let val = f(x, y)
    if val.abs() < 0.0000000001 {
      return @core.Point2D::new(x, y)
    }
    let gx = fx(x, y)
    let gy = fy(x, y)
    let grad_sq = gx * gx + gy * gy
    if grad_sq < 0.0000000001 {
      return @core.Point2D::new(x, y)
    }
    let lambda = val / grad_sq
    x -= lambda * gx
    y -= lambda * gy
  }
  @core.Point2D::new(x, y)
}

///|
/// Tangent direction at a point on the curve. / 曲线上一点处的切线方向。
pub fn tangent(
  fx : (Double, Double) -> Double,
  fy : (Double, Double) -> Double,
  p : @core.Point2D,
) -> @core.Point2D {
  let gx = fx(p.x(), p.y())
  let gy = fy(p.x(), p.y())
  let norm = (gx * gx + gy * gy).sqrt()
  if norm < 0.0000000001 {
    return @core.Point2D::new(1.0, 0.0)
  }
  @core.Point2D::new(-gy / norm, gx / norm)
}
