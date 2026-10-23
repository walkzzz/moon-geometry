///|
/// Check if a point is inside an AABB. / 检查点是否在 AABB 内。
pub fn aabb_contains(box : AABB, x : Double, y : Double) -> Bool {
  x >= box.min_x && x <= box.max_x && y >= box.min_y && y <= box.max_y
}
