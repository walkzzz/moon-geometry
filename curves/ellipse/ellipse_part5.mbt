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
