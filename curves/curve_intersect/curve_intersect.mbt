///|
/// Check if two line segments intersect. / 检查两条线段是否相交。
pub fn segments_cross(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> Bool {
  let eps = 0.000000000001
  let d1x = p2.x() - p1.x()
  let d1y = p2.y() - p1.y()
  let d2x = p4.x() - p3.x()
  let d2y = p4.y() - p3.y()
  let denom = d1x * d2y - d1y * d2x
  if denom.abs() < eps {
    return false
  }
  let t = ((p3.x() - p1.x()) * d2y - (p3.y() - p1.y()) * d2x) / denom
  let s = ((p3.x() - p1.x()) * d1y - (p3.y() - p1.y()) * d1x) / denom
  t > eps && t < 1.0 - eps && s > eps && s < 1.0 - eps
}
