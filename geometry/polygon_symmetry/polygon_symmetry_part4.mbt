///|
/// Check if a polygon has any symmetry (reflection or rotation). / 检查多边形是否有任何对称性。
pub fn has_any_symmetry(poly : Array[@core.Point2D]) -> Bool {
  if has_reflection_symmetry(poly, 0.0) {
    return true
  }
  if has_reflection_symmetry(poly, 3.14159265358979323846 / 2.0) {
    return true
  }
  polygon_symmetry_order(poly) > 1
}
