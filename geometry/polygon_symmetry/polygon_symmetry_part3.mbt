///|
/// Find the order of rotational symmetry (1 = no rotational symmetry). / 求旋转对称阶（1 = 无旋转对称）。
pub fn polygon_symmetry_order(
  poly : Array[@core.Point2D],
) -> Int {
  let n = poly.length()
  if n < 3 {
    return 1
  }
  for order in [12, 8, 6, 5, 4, 3, 2] {
    if has_rotation_symmetry(poly, order) {
      return order
    }
  }
  1
}
