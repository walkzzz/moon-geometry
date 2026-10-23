///|
/// Construct a rectangle from two opposite corners.
/// 从两个对角构造矩形。
pub fn Rectangle::from_corners(p1 : Point2D, p2 : Point2D) -> Rectangle {
  {
    min_x: if p1.x < p2.x {
      p1.x
    } else {
      p2.x
    },
    min_y: if p1.y < p2.y {
      p1.y
    } else {
      p2.y
    },
    max_x: if p1.x > p2.x {
      p1.x
    } else {
      p2.x
    },
    max_y: if p1.y > p2.y {
      p1.y
    } else {
      p2.y
    },
  }
}


///|
/// Area of the rectangle.
/// 矩形面积。
pub impl Measurable for Rectangle with area(self) {
  (self.max_x - self.min_x) * (self.max_y - self.min_y)
}
