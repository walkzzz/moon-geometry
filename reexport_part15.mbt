///|
/// Arc length of cubic Bezier. / 三次贝塞尔曲线弧长。
pub fn bezier3_length(b : Bezier3) -> Double {
  @bezier.Bezier3::length(b)
}


///|
/// Bounding box of cubic Bezier. / 三次贝塞尔曲线包围盒。
pub fn bezier3_bbox(b : Bezier3) -> (Double, Double, Double, Double) {
  @bezier.Bezier3::bbox(b)
}


///|
/// Subdivide cubic Bezier at t. / 细分三次贝塞尔曲线。
pub fn bezier3_subdivide(b : Bezier3, t : Double) -> (Bezier3, Bezier3) {
  @bezier.Bezier3::subdivide(b, t)
}
// ---------------------------------------------------------------------------
// fitting: geometric fitting / 几何拟合
// ---------------------------------------------------------------------------


///|
/// Line fit result. / 直线拟合结果。
pub type LineFit = @fitting.LineFit


///|
/// Circle fit result. / 圆拟合结果。
pub type CircleFit = @fitting.CircleFit


///|
/// Least-squares line fit. / 最小二乘直线拟合。
pub fn fit_line(points : Array[Point2D]) -> LineFit? {
  @fitting.fit_line(points)
}


///|
/// Orthogonal distance regression line fit. / 正交距离回归直线拟合。
pub fn fit_line_orthogonal(
  points : Array[Point2D],
) -> (Double, Double, Double)? {
  @fitting.fit_line_orthogonal(points)
}
