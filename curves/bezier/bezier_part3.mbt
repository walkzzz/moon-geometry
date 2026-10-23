///|
/// Derivative of quadratic Bezier at parameter t.
/// B'(t) = 2(1-t)(P1-P0) + 2t(P2-P1)
///
/// 二次贝塞尔曲线在参数 t 处的导数。
pub impl @core.Curve2D for Bezier2 with derivative(self, t) {
  let u = 1.0 - t
  @core.Point2D::new(
    2.0 * u * (self.p1.x() - self.p0.x()) +
    2.0 * t * (self.p2.x() - self.p1.x()),
    2.0 * u * (self.p1.y() - self.p0.y()) +
    2.0 * t * (self.p2.y() - self.p1.y()),
  )
}


///|
/// Arc length of quadratic Bezier (numerical integration, 100 samples).
/// 二次贝塞尔曲线弧长（数值积分，100 个采样点）。
pub impl @core.Curve2D for Bezier2 with length(self) {
  let n = 100
  let dt = 1.0 / n.to_double()
  let mut total = 0.0
  for i in 0..<n {
    let t = i.to_double() * dt
    let d = self.derivative(t)
    total += (d.x() * d.x() + d.y() * d.y()).sqrt() * dt
  }
  total
}
