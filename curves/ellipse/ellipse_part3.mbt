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
