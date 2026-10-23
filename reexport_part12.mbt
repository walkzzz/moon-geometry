///|
/// Ellipse type. / 椭圆类型。
pub type Ellipse = @ellipse.Ellipse


///|
/// Construct an ellipse. / 构造椭圆。
pub fn ellipse_new(
  center : Point2D,
  a : Double,
  b : Double,
  angle : Double,
) -> Ellipse {
  @ellipse.Ellipse::new(center, a, b, angle)
}


///|
/// Area of the ellipse. / 椭圆面积。
pub fn ellipse_area(e : Ellipse) -> Double {
  @ellipse.Ellipse::area(e)
}


///|
/// Perimeter of the ellipse (Ramanujan approximation). / 椭圆周长。
pub fn ellipse_perimeter(e : Ellipse) -> Double {
  @ellipse.Ellipse::perimeter(e)
}


///|
/// Eccentricity of the ellipse. / 椭圆离心率。
pub fn ellipse_eccentricity(e : Ellipse) -> Double {
  @ellipse.Ellipse::eccentricity(e)
}


///|
/// Check if a point is inside the ellipse. / 检查点是否在椭圆内。
pub fn ellipse_contains(e : Ellipse, p : Point2D) -> Bool {
  @ellipse.Ellipse::contains(e, p)
}
