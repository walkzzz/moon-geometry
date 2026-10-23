///|
/// Union (smallest enclosing AABB) of two rectangles.
/// 两矩形的并集（最小包围 AABB）。
pub fn Rectangle::union(self : Rectangle, other : Rectangle) -> Rectangle {
  {
    min_x: if self.min_x < other.min_x {
      self.min_x
    } else {
      other.min_x
    },
    min_y: if self.min_y < other.min_y {
      self.min_y
    } else {
      other.min_y
    },
    max_x: if self.max_x > other.max_x {
      self.max_x
    } else {
      other.max_x
    },
    max_y: if self.max_y > other.max_y {
      self.max_y
    } else {
      other.max_y
    },
  }
}
