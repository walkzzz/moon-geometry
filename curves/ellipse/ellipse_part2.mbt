///|
/// Area of the ellipse: π * a * b. / 椭圆面积：π * a * b。
pub impl @core.Measurable for Ellipse with area(self) {
  3.141592653589793 * self.a * self.b
}


///|
/// Perimeter of the ellipse (Ramanujan's second approximation).
/// 椭圆周长（Ramanujan 第二近似公式）。
pub impl @core.PerimeterMeasurable for Ellipse with perimeter(self) {
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
