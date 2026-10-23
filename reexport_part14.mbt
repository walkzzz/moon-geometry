///|
/// Derivative of quadratic Bezier at t. / 二次贝塞尔曲线在 t 处的导数。
pub fn bezier2_derivative(b : Bezier2, t : Double) -> Point2D {
  @bezier.Bezier2::derivative(b, t)
}


///|
/// Arc length of quadratic Bezier. / 二次贝塞尔曲线弧长。
pub fn bezier2_length(b : Bezier2) -> Double {
  @bezier.Bezier2::length(b)
}


///|
/// Bounding box of quadratic Bezier. / 二次贝塞尔曲线包围盒。
pub fn bezier2_bbox(b : Bezier2) -> (Double, Double, Double, Double) {
  @bezier.Bezier2::bbox(b)
}


///|
/// Subdivide quadratic Bezier at t. / 细分二次贝塞尔曲线。
pub fn bezier2_subdivide(b : Bezier2, t : Double) -> (Bezier2, Bezier2) {
  @bezier.Bezier2::subdivide(b, t)
}


///|
/// Construct a cubic Bezier curve. / 构造三次贝塞尔曲线。
pub fn bezier3_new(
  p0 : Point2D,
  p1 : Point2D,
  p2 : Point2D,
  p3 : Point2D,
) -> Bezier3 {
  @bezier.Bezier3::new(p0, p1, p2, p3)
}


///|
/// Evaluate cubic Bezier at t. / 计算三次贝塞尔曲线在 t 处的值。
pub fn bezier3_eval(b : Bezier3, t : Double) -> Point2D {
  @bezier.Bezier3::eval(b, t)
}


///|
/// Derivative of cubic Bezier at t. / 三次贝塞尔曲线在 t 处的导数。
pub fn bezier3_derivative(b : Bezier3, t : Double) -> Point2D {
  @bezier.Bezier3::derivative(b, t)
}
