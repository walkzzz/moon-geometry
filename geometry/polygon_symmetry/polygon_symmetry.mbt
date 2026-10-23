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

///|
/// Check if a polygon has rotational symmetry of given order. / 检查多边形是否具有给定阶的旋转对称性。
pub fn has_rotation_symmetry(
  poly : Array[@core.Point2D],
  order : Int32,
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

///|
/// Find the order of rotational symmetry (1 = no rotational symmetry). / 求旋转对称阶（1 = 无旋转对称）。
pub fn polygon_symmetry_order(poly : Array[@core.Point2D]) -> Int32 {
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
