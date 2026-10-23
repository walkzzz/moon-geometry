///|
/// Whether a point lies inside or on the rectangle.
/// 点是否在矩形内或矩形上。
pub impl Containable for Rectangle with fn contains(self, p) {
  p.x >= self.min_x &&
  p.x <= self.max_x &&
  p.y >= self.min_y &&
  p.y <= self.max_y
}
