///|
/// # Filtered Predicates
/// # 过滤谓词
///
/// Fast approximate predicates with fallback to exact computation.
/// 快速近似谓词，必要时回退到精确计算。

///|
pub fn filtered_orientation(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D) -> Int {
  let det = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let eps = 0.000000000001 * ((b.x() - a.x()).abs() * (c.y() - a.y()).abs() + (b.y() - a.y()).abs() * (c.x() - a.x()).abs())
  if det > eps { 1 } else if det < -eps { -1 } else { 0 }
}

///|
pub fn filtered_incircle(a : @core.Point2D, b : @core.Point2D, c : @core.Point2D, d : @core.Point2D) -> Int {
  let ax = a.x() - d.x()
  let ay = a.y() - d.y()
  let bx = b.x() - d.x()
  let by = b.y() - d.y()
  let cx = c.x() - d.x()
  let cy = c.y() - d.y()
  let det = ax * (bx * (cx * cx + cy * cy) - cx * (bx * bx + by * by)) -
    ay * (by * (cx * cx + cy * cy) - cy * (bx * bx + by * by)) +
    (ax * ax + ay * ay) * (bx * cy - by * cx)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

///|
pub fn perturbation_orientation(det : Double, eps : Double) -> Int {
  if det > eps { 1 } else if det < -eps { -1 } else { 0 }
}
