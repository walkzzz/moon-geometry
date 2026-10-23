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
