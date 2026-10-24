///|
/// Ellipse defined by center, semi-major axis a, semi-minor axis b,
/// and rotation angle (radians) of the major axis.
///
/// 椭圆：由中心、半长轴 a、半短轴 b、长轴旋转角度（弧度）定义。
pub struct Ellipse {
  center : @core.Point2D
  a : Double
  b : Double
  angle : Double
} derive(Debug)

///|
pub extend Ellipse with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Ellipse with @core.Measurable::{area}

///|
pub extend Ellipse with @core.PerimeterMeasurable::{perimeter}

///|
pub extend Ellipse with @core.Containable::{contains}

///|
/// Construct an ellipse. / 构造椭圆。
pub fn Ellipse::new(
  center : @core.Point2D,
  a : Double,
  b : Double,
  angle : Double,
) -> Ellipse {
  { center, a, b, angle, }
}

///|
/// Area of the ellipse: π * a * b. / 椭圆面积：π * a * b。
pub impl @core.Measurable for Ellipse with fn area(self) {
  3.141592653589793 * self.a * self.b
}

///|
/// Perimeter of the ellipse (Ramanujan's second approximation).
/// 椭圆周长（Ramanujan 第二近似公式）。
pub impl @core.PerimeterMeasurable for Ellipse with fn perimeter(self) {
  let a = self.a
  let b = self.b
  let h = (a - b) * (a - b) / ((a + b) * (a + b))
  3.141592653589793 *
  (a + b) *
  (1.0 + 3.0 * h / (10.0 + (4.0 - 3.0 * h).sqrt()))
}

///|
/// Eccentricity of the ellipse: e = sqrt(1 - b²/a²).
/// 椭圆离心率：e = sqrt(1 - b²/a²)。
pub fn Ellipse::eccentricity(self : Ellipse) -> Double {
  if self.a <= self.b {
    return 0.0
  }
  (1.0 - self.b * self.b / (self.a * self.a)).sqrt()
}

///|
/// Transform a point from world coordinates to the ellipse's local
/// coordinates (centered, axis-aligned). / 将点从世界坐标变换到椭圆局部坐标。
fn Ellipse::to_local(self : Ellipse, p : @core.Point2D) -> @core.Point2D {
  let dx = p.x() - self.center.x()
  let dy = p.y() - self.center.y()
  let c = @math.cos(-self.angle)
  let s = @math.sin(-self.angle)
  @core.Point2D::new(dx * c - dy * s, dx * s + dy * c)
}

///|
/// Check if a point is inside the ellipse. / 检查点是否在椭圆内。
pub impl @core.Containable for Ellipse with fn contains(self, p) {
  let lp = self.to_local(p)
  let val = lp.x() * lp.x() / (self.a * self.a) +
    lp.y() * lp.y() / (self.b * self.b)
  val <= 1.0
}

///|
/// Check if a point is on the ellipse boundary (within epsilon).
/// 检查点是否在椭圆边界上（容差范围内）。
pub fn Ellipse::on_boundary(
  self : Ellipse,
  p : @core.Point2D,
  eps : Double,
) -> Bool {
  let lp = self.to_local(p)
  let val = lp.x() * lp.x() / (self.a * self.a) +
    lp.y() * lp.y() / (self.b * self.b)
  @core.approx_eq(val, 1.0, eps)
}

///|
/// Intersection of the ellipse with a line (a*x + b*y + c = 0).
/// Returns 0, 1, or 2 intersection points.
/// 椭圆与直线交点（0/1/2 个）。
pub fn Ellipse::line_intersect(
  self : Ellipse,
  line : @core.Line,
) -> Array[@core.Point2D] {
  let c = @math.cos(self.angle)
  let s = @math.sin(self.angle)
  let la = line.a
  let lb = line.b
  let lc = line.c
  let cx = self.center.x()
  let cy = self.center.y()
  let a = self.a
  let b = self.b
  let la_rot = la * c + lb * s
  let lb_rot = -la * s + lb * c
  let lc_rot = la * cx + lb * cy + lc
  let a_sq = a * a
  let b_sq = b * b
  let result : Array[@core.Point2D] = []
  let eps = 0.000000000000001
  if la_rot.abs() < eps && lb_rot.abs() < eps {
    return result
  }
  if la_rot.abs() < eps {
    let y_local = -lc_rot / lb_rot
    let val = 1.0 - y_local * y_local / b_sq
    if val < 0.0 {
      return result
    }
    let x_local = a * val.sqrt()
    let wx1 = x_local * c - y_local * s + cx
    let wy1 = x_local * s + y_local * c + cy
    result.push(@core.Point2D::new(wx1, wy1))
    if val > eps {
      let wx2 = -x_local * c - y_local * s + cx
      let wy2 = -x_local * s + y_local * c + cy
      result.push(@core.Point2D::new(wx2, wy2))
    }
    return result
  }
  if lb_rot.abs() < eps {
    let x_local = -lc_rot / la_rot
    let val = 1.0 - x_local * x_local / a_sq
    if val < 0.0 {
      return result
    }
    let y_local = b * val.sqrt()
    let wx1 = x_local * c - y_local * s + cx
    let wy1 = x_local * s + y_local * c + cy
    result.push(@core.Point2D::new(wx1, wy1))
    if val > eps {
      let wx2 = x_local * c + y_local * s + cx
      let wy2 = x_local * s - y_local * c + cy
      result.push(@core.Point2D::new(wx2, wy2))
    }
    return result
  }
  let aa = la_rot * la_rot * a_sq + lb_rot * lb_rot * b_sq
  let bb = 2.0 * la_rot * lc_rot * a_sq
  let cc = a_sq * lc_rot * lc_rot - a_sq * lb_rot * lb_rot * b_sq
  let disc = bb * bb - 4.0 * aa * cc
  if disc < 0.0 {
    return result
  }
  let sqrt_disc = disc.sqrt()
  let x1 = (-bb + sqrt_disc) / (2.0 * aa)
  let x2 = (-bb - sqrt_disc) / (2.0 * aa)
  let y1 = -(la_rot * x1 + lc_rot) / lb_rot
  let y2 = -(la_rot * x2 + lc_rot) / lb_rot
  let wx1 = x1 * c - y1 * s + cx
  let wy1 = x1 * s + y1 * c + cy
  result.push(@core.Point2D::new(wx1, wy1))
  if (x1 - x2).abs() > eps || (y1 - y2).abs() > eps {
    let wx2 = x2 * c - y2 * s + cx
    let wy2 = x2 * s + y2 * c + cy
    result.push(@core.Point2D::new(wx2, wy2))
  }
  result
}

///|
/// Focal points of the ellipse. Returns (f1, f2).
/// 椭圆焦点，返回 (f1, f2)。
pub fn Ellipse::foci(self : Ellipse) -> (@core.Point2D, @core.Point2D) {
  let c_val = (self.a * self.a - self.b * self.b).sqrt()
  let dx = c_val * @math.cos(self.angle)
  let dy = c_val * @math.sin(self.angle)
  (
    @core.Point2D::new(self.center.x() + dx, self.center.y() + dy),
    @core.Point2D::new(self.center.x() - dx, self.center.y() - dy),
  )
}
