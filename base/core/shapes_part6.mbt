///|
pub extend Rectangle with PerimeterMeasurable::{perimeter}


///|
pub extend Rectangle with Containable::{contains}


///|
/// Construct a rectangle from corner coordinates.
/// 从角坐标构造矩形。
pub fn Rectangle::new(
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
) -> Rectangle {
  { min_x, min_y, max_x, max_y, }
}
