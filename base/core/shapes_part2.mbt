///|
pub extend Triangle with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Triangle with Measurable::{area}

///|
/// Construct a triangle.
/// 构造三角形。
pub fn Triangle::new(a : Point2D, b : Point2D, c : Point2D) -> Triangle {
  { a, b, c, }
}

///|
/// Signed area of the triangle (positive if CCW).
/// 三角形有符号面积（逆时针为正）。
pub fn Triangle::signed_area(self : Triangle) -> Double {
  (
    (self.b.x - self.a.x) * (self.c.y - self.a.y) -
    (self.c.x - self.a.x) * (self.b.y - self.a.y)
  ) /
  2.0
}

///|
/// Absolute area of the triangle.
/// 三角形绝对面积。
pub impl Measurable for Triangle with fn area(self) {
  self.signed_area().abs()
}
