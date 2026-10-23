///|
/// Check if a point is inside the AABB. / 检查点是否在 AABB 内。
pub fn AABB3D::contains_point(b : AABB3D, p : @core.Point3D) -> Bool {
  p.x >= b.min_x &&
  p.x <= b.max_x &&
  p.y >= b.min_y &&
  p.y <= b.max_y &&
  p.z >= b.min_z &&
  p.z <= b.max_z
}
