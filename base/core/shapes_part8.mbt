///|
/// Perimeter of the rectangle.
/// 矩形周长。
pub impl PerimeterMeasurable for Rectangle with fn perimeter(self) {
  2.0 * (self.max_x - self.min_x + (self.max_y - self.min_y))
}

///|
/// Width of the rectangle.
/// 矩形宽度。
pub fn Rectangle::width(self : Rectangle) -> Double {
  self.max_x - self.min_x
}

///|
/// Height of the rectangle.
/// 矩形高度。
pub fn Rectangle::height(self : Rectangle) -> Double {
  self.max_y - self.min_y
}
