///|
/// Quadratic Bezier curve with 3 control points.
/// 二次贝塞尔曲线，3 个控制点。
pub struct Bezier2 {
  p0 : @core.Point2D
  p1 : @core.Point2D
  p2 : @core.Point2D
} derive(Debug)

///|
pub extend Bezier2 with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Bezier2 with @core.Curve2D::{eval, derivative, length}

///|
pub extend Bezier2 with @core.Bounded2D::{bbox}

///|
pub extend Bezier2 with @core.Subdivisible::{subdivide}

///|
/// Cubic Bezier curve with 4 control points.
/// 三次贝塞尔曲线，4 个控制点。
pub struct Bezier3 {
  p0 : @core.Point2D
  p1 : @core.Point2D
  p2 : @core.Point2D
  p3 : @core.Point2D
} derive(Debug)

///|
pub extend Bezier3 with @moonbitlang/core/debug.Debug::{to_repr}

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

///|
/// Derivative of quadratic Bezier at parameter t.
/// B'(t) = 2(1-t)(P1-P0) + 2t(P2-P1)
///
/// 二次贝塞尔曲线在参数 t 处的导数。
pub impl @core.Curve2D for Bezier2 with fn derivative(self, t) {
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
pub impl @core.Curve2D for Bezier2 with fn length(self) {
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

///|
/// Bounding box of quadratic Bezier. Returns (min_x, min_y, max_x, max_y).
/// 二次贝塞尔曲线包围盒，返回 (min_x, min_y, max_x, max_y)。
pub impl @core.Bounded2D for Bezier2 with fn bbox(self) {
  let mut min_x = self.p0.x()
  let mut max_x = min_x
  let mut min_y = self.p0.y()
  let mut max_y = min_y
  let dx = self.p0.x() - 2.0 * self.p1.x() + self.p2.x()
  if dx.abs() > @core.default_eps {
    let t = (self.p0.x() - self.p1.x()) / dx
    if t > 0.0 && t < 1.0 {
      let x = self.eval(t).x()
      if x < min_x {
        min_x = x
      }
      if x > max_x {
        max_x = x
      }
    }
  }
  let dy = self.p0.y() - 2.0 * self.p1.y() + self.p2.y()
  if dy.abs() > @core.default_eps {
    let t = (self.p0.y() - self.p1.y()) / dy
    if t > 0.0 && t < 1.0 {
      let y = self.eval(t).y()
      if y < min_y {
        min_y = y
      }
      if y > max_y {
        max_y = y
      }
    }
  }
  for p in [self.p2] {
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  (min_x, min_y, max_x, max_y)
}

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

///|
/// Bounding box of cubic Bezier. Returns (min_x, min_y, max_x, max_y).
/// 三次贝塞尔曲线包围盒，返回 (min_x, min_y, max_x, max_y)。
pub impl @core.Bounded2D for Bezier3 with fn bbox(self) {
  let samples = 200
  let mut min_x = self.p0.x()
  let mut max_x = min_x
  let mut min_y = self.p0.y()
  let mut max_y = min_y
  for i in 0..<=samples {
    let t = i.to_double() / samples.to_double()
    let p = self.eval(t)
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  (min_x, min_y, max_x, max_y)
}

///|
/// Subdivide a quadratic Bezier at parameter t into two curves.
/// Returns (left, right). / 在参数 t 处将二次贝塞尔曲线细分为两条。
pub impl @core.Subdivisible for Bezier2 with fn subdivide(self, t) {
  let u = 1.0 - t
  let q0 = @core.Point2D::new(
    u * self.p0.x() + t * self.p1.x(),
    u * self.p0.y() + t * self.p1.y(),
  )
  let q1 = @core.Point2D::new(
    u * self.p1.x() + t * self.p2.x(),
    u * self.p1.y() + t * self.p2.y(),
  )
  let r = @core.Point2D::new(u * q0.x() + t * q1.x(), u * q0.y() + t * q1.y())
  (Bezier2::new(self.p0, q0, r), Bezier2::new(r, q1, self.p2))
}

///|
/// Subdivide a cubic Bezier at parameter t into two curves.
/// Returns (left, right). / 在参数 t 处将三次贝塞尔曲线细分为两条。
pub impl @core.Subdivisible for Bezier3 with fn subdivide(self, t) {
  let u = 1.0 - t
  let q0 = @core.Point2D::new(
    u * self.p0.x() + t * self.p1.x(),
    u * self.p0.y() + t * self.p1.y(),
  )
  let q1 = @core.Point2D::new(
    u * self.p1.x() + t * self.p2.x(),
    u * self.p1.y() + t * self.p2.y(),
  )
  let q2 = @core.Point2D::new(
    u * self.p2.x() + t * self.p3.x(),
    u * self.p2.y() + t * self.p3.y(),
  )
  let r0 = @core.Point2D::new(u * q0.x() + t * q1.x(), u * q0.y() + t * q1.y())
  let r1 = @core.Point2D::new(u * q1.x() + t * q2.x(), u * q1.y() + t * q2.y())
  let s = @core.Point2D::new(u * r0.x() + t * r1.x(), u * r0.y() + t * r1.y())
  (Bezier3::new(self.p0, q0, r0, s), Bezier3::new(s, r1, q2, self.p3))
}
