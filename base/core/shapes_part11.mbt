///|
/// Intersection of two rectangles. Returns None if they do not overlap.
/// 两矩形交集。不重叠时返回 None。
pub fn Rectangle::intersection(
  self : Rectangle,
  other : Rectangle,
) -> Rectangle? {
  let min_x = if self.min_x > other.min_x { self.min_x } else { other.min_x }
  let min_y = if self.min_y > other.min_y { self.min_y } else { other.min_y }
  let max_x = if self.max_x < other.max_x { self.max_x } else { other.max_x }
  let max_y = if self.max_y < other.max_y { self.max_y } else { other.max_y }
  if min_x > max_x || min_y > max_y {
    None
  } else {
    Some({ min_x, min_y, max_x, max_y, })
  }
}
