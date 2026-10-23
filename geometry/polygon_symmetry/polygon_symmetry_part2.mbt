///|
/// Check if a polygon has rotational symmetry of given order. / 检查多边形是否具有给定阶的旋转对称性。
pub fn has_rotation_symmetry(
  poly : Array[@core.Point2D],
  order : Int,
) -> Bool {
  let n = poly.length()
  if n < 3 || order < 2 {
    return false
  }
  let eps = 0.0001
  let mut cx = 0.0
  let mut cy = 0.0
  for p in poly {
    cx += p.x()
    cy += p.y()
  }
  cx = cx / n.to_double()
  cy = cy / n.to_double()
  let angle = 2.0 * 3.14159265358979323846 / order.to_double()
  let cos_a = @math.cos(angle)
  let sin_a = @math.sin(angle)
  for p in poly {
    let dx = p.x() - cx
    let dy = p.y() - cy
    let rx = cx + dx * cos_a - dy * sin_a
    let ry = cy + dx * sin_a + dy * cos_a
    let rotated = @core.Point2D::new(rx, ry)
    let mut found = false
    for q in poly {
      if (q.x() - rotated.x()).abs() < eps && (q.y() - rotated.y()).abs() < eps {
        found = true
        break
      }
    }
    if !found {
      return false
    }
  }
  true
}
