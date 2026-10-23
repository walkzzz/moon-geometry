///|
pub extend Bezier3 with @core.Curve2D::{eval, derivative, length}

///|
pub extend Bezier3 with @core.Bounded2D::{bbox}

///|
pub extend Bezier3 with @core.Subdivisible::{subdivide}

///|
/// Construct a quadratic Bezier curve. / 构造二次贝塞尔曲线。
pub fn Bezier2::new(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
) -> Bezier2 {
  { p0, p1, p2, }
}

///|
/// Construct a cubic Bezier curve. / 构造三次贝塞尔曲线。
pub fn Bezier3::new(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Bezier3 {
  { p0, p1, p2, p3, }
}

///|
/// Evaluate quadratic Bezier at parameter t in [0, 1].
/// B(t) = (1-t)²P0 + 2(1-t)tP1 + t²P2
///
/// 计算二次贝塞尔曲线在参数 t 处的值。
pub impl @core.Curve2D for Bezier2 with fn eval(self, t) {
  let u = 1.0 - t
  let a = u * u
  let b = 2.0 * u * t
  let c = t * t
  @core.Point2D::new(
    a * self.p0.x() + b * self.p1.x() + c * self.p2.x(),
    a * self.p0.y() + b * self.p1.y() + c * self.p2.y(),
  )
}
