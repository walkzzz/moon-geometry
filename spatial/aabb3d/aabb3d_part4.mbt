///|
/// Check if two AABBs intersect. / 检查两个 AABB 是否相交。
pub fn AABB3D::intersects(a : AABB3D, b : AABB3D) -> Bool {
  !(
    a.max_x < b.min_x ||
    a.min_x > b.max_x ||
    a.max_y < b.min_y ||
    a.min_y > b.max_y ||
    a.max_z < b.min_z ||
    a.min_z > b.max_z
  )
}
