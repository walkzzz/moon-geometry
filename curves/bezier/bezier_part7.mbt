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
