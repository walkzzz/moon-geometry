///|
/// Check if two AABBs overlap. / 检查两个 AABB 是否重叠。
pub fn aabb_overlap(a : AABB, b : AABB) -> Bool {
  a.min_x <= b.max_x && a.max_x >= b.min_x && a.min_y <= b.max_y && a.max_y >= b.min_y
}
