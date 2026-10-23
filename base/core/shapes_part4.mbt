///|
pub extend Circle with Measurable::{area}


///|
pub extend Circle with PerimeterMeasurable::{perimeter}


///|
pub extend Circle with Containable::{contains}


///|
/// Construct a circle.
/// 构造圆。
pub fn Circle::new(center : Point2D, radius : Double) -> Circle {
  { center, radius, }
}


///|
/// Area of the circle.
/// 圆面积。
pub impl Measurable for Circle with area(self) {
  @math.PI * self.radius * self.radius
}
