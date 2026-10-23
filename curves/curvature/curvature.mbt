///|
/// Discrete curvature at middle point of three points. / 三点中间点的离散曲率。
pub fn curvature_at(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let dx1 = p2.x() - p1.x()
  let dy1 = p2.y() - p1.y()
  let dx2 = p3.x() - p2.x()
  let dy2 = p3.y() - p2.y()
  let cross = dx1 * dy2 - dy1 * dx2
  let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if len1 < 0.000000000001 || len2 < 0.000000000001 {
    return 0.0
  }
  let len3 = ((p3.x() - p1.x()) * (p3.x() - p1.x()) +
  (p3.y() - p1.y()) * (p3.y() - p1.y())).sqrt()
  if len3 < 0.000000000001 {
    return 0.0
  }
  2.0 * cross.abs() / (len1 * len2 * len3)
}
