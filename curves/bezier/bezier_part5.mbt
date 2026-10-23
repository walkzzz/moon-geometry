///|
/// Evaluate cubic Bezier at parameter t in [0, 1].
/// B(t) = (1-t)³P0 + 3(1-t)²tP1 + 3(1-t)t²P2 + t³P3
///
/// 计算三次贝塞尔曲线在参数 t 处的值。
pub impl @core.Curve2D for Bezier3 with fn eval(self, t) {
  let u = 1.0 - t
  let a = u * u * u
  let b = 3.0 * u * u * t
  let c = 3.0 * u * t * t
  let d = t * t * t
  @core.Point2D::new(
    a * self.p0.x() + b * self.p1.x() + c * self.p2.x() + d * self.p3.x(),
    a * self.p0.y() + b * self.p1.y() + c * self.p2.y() + d * self.p3.y(),
  )
}

///|
/// Derivative of cubic Bezier at parameter t.
/// B'(t) = 3(1-t)²(P1-P0) + 6(1-t)t(P2-P1) + 3t²(P3-P2)
///
/// 三次贝塞尔曲线在参数 t 处的导数。
pub impl @core.Curve2D for Bezier3 with fn derivative(self, t) {
  let u = 1.0 - t
  let a = 3.0 * u * u
  let b = 6.0 * u * t
  let c = 3.0 * t * t
  @core.Point2D::new(
    a * (self.p1.x() - self.p0.x()) +
    b * (self.p2.x() - self.p1.x()) +
    c * (self.p3.x() - self.p2.x()),
    a * (self.p1.y() - self.p0.y()) +
    b * (self.p2.y() - self.p1.y()) +
    c * (self.p3.y() - self.p2.y()),
  )
}

///|
/// Arc length of cubic Bezier (numerical integration, 100 samples).
/// 三次贝塞尔曲线弧长（数值积分，100 个采样点）。
pub impl @core.Curve2D for Bezier3 with fn length(self) {
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
