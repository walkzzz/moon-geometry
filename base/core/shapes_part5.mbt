///|
/// Perimeter (circumference) of the circle.
/// 圆周长。
pub impl PerimeterMeasurable for Circle with fn perimeter(self) {
  2.0 * @math.PI * self.radius
}

///|
/// Whether a point lies inside or on the circle.
/// 点是否在圆内或圆上。
pub impl Containable for Circle with fn contains(self, p) {
  self.center.dist_sq(p) <= self.radius * self.radius
}

///|
/// An axis-aligned bounding box (AABB) rectangle.
/// 轴对齐包围盒（AABB）矩形。
pub struct Rectangle {
  min_x : Double
  min_y : Double
  max_x : Double
  max_y : Double
} derive(Debug)

///|
pub extend Rectangle with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Rectangle with Measurable::{area}
