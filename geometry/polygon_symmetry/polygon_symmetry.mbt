///|
/// Check if a polygon has reflection symmetry along a given axis. / 检查多边形是否关于给定轴对称。
pub fn has_reflection_symmetry(
  poly : Array[@core.Point2D],
  axis_angle : Double,
) -> Bool {
  let n = poly.length()
  if n < 3 {
    return false
  }
  let eps = 0.0001
  let cos_a = @math.cos(axis_angle)
  let sin_a = @math.sin(axis_angle)
  let mut cx = 0.0
  let mut cy = 0.0
  for p in poly {
    cx += p.x()
    cy += p.y()
  }
  cx = cx / n.to_double()
  cy = cy / n.to_double()
  for p in poly {
    let dx = p.x() - cx
    let dy = p.y() - cy
    let dot = dx * cos_a + dy * sin_a
    let perp_x = dx - 2.0 * dot * cos_a
    let perp_y = dy - 2.0 * dot * sin_a
    let reflected = @core.Point2D::new(cx + perp_x, cy + perp_y)
    let mut found = false
    for q in poly {
      if (q.x() - reflected.x()).abs() < eps &&
        (q.y() - reflected.y()).abs() < eps {
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
