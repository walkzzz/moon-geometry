///|
/// Compute AABB union. / 计算 AABB 并集。
pub fn aabb_union(a : AABB, b : AABB) -> AABB {
  let min_x = if a.min_x < b.min_x {
    a.min_x
  } else {
    b.min_x
  }
  let min_y = if a.min_y < b.min_y {
    a.min_y
  } else {
    b.min_y
  }
  let max_x = if a.max_x > b.max_x {
    a.max_x
  } else {
    b.max_x
  }
  let max_y = if a.max_y > b.max_y {
    a.max_y
  } else {
    b.max_y
  }
  AABB::new(min_x, min_y, max_x, max_y)
}


///|
/// Compute AABB area. / 计算 AABB 面积。
pub fn aabb_area(box : AABB) -> Double {
  (box.max_x - box.min_x) * (box.max_y - box.min_y)
}