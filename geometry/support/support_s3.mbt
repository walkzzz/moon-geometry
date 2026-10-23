///|
/// Support value (max dot product) for a point set. / 点集的支持值。
pub fn support_value(
  points : Array[@core.Point2D],
  dir : @core.Point2D,
) -> Double? {
  match support_point_set(points, dir) {
    Some(idx) => Some(points[idx].x() * dir.x() + points[idx].y() * dir.y())
    None => None
  }
}
