///|
/// Check if a point is on the ellipse boundary. / 检查点是否在椭圆边界上。
pub fn ellipse_on_boundary(e : Ellipse, p : Point2D, eps : Double) -> Bool {
  @ellipse.Ellipse::on_boundary(e, p, eps)
}


///|
/// Focal points of the ellipse. / 椭圆焦点。
pub fn ellipse_foci(e : Ellipse) -> (Point2D, Point2D) {
  @ellipse.Ellipse::foci(e)
}

// ---------------------------------------------------------------------------
// bezier: Bezier curves / 贝塞尔曲线
// ---------------------------------------------------------------------------


///|
/// Quadratic Bezier curve type. / 二次贝塞尔曲线类型。
pub type Bezier2 = @bezier.Bezier2


///|
/// Cubic Bezier curve type. / 三次贝塞尔曲线类型。
pub type Bezier3 = @bezier.Bezier3


///|
/// Construct a quadratic Bezier curve. / 构造二次贝塞尔曲线。
pub fn bezier2_new(p0 : Point2D, p1 : Point2D, p2 : Point2D) -> Bezier2 {
  @bezier.Bezier2::new(p0, p1, p2)
}


///|
/// Evaluate quadratic Bezier at t. / 计算二次贝塞尔曲线在 t 处的值。
pub fn bezier2_eval(b : Bezier2, t : Double) -> Point2D {
  @bezier.Bezier2::eval(b, t)
}
