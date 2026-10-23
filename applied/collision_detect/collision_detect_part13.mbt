///|
/// Compute AABB intersection (returns None if no overlap). / 计算 AABB 交集（无重叠返回 None）。
pub fn aabb_intersection(a : AABB, b : AABB) -> AABB? {
  if !aabb_overlap(a, b) {
    return None
  }
  let min_x = if a.min_x > b.min_x {
    a.min_x
  } else {
    b.min_x
  }
  let min_y = if a.min_y > b.min_y {
    a.min_y
  } else {
    b.min_y
  }
  let max_x = if a.max_x < b.max_x {
    a.max_x
  } else {
    b.max_x
  }
  let max_y = if a.max_y < b.max_y {
    a.max_y
  } else {
    b.max_y
  }
  Some(AABB::new(min_x, min_y, max_x, max_y))
}
