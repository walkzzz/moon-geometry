///|
/// Support point of a circle in a direction. / 圆在方向上的支持点。
pub fn support_circle(
  center : @core.Point2D,
  radius : Double,
  dir : @core.Point2D,
) -> @core.Point2D {
  let dlen = (dir.x() * dir.x() + dir.y() * dir.y()).sqrt()
  if dlen < 0.000000000001 {
    return center
  }
  @core.Point2D::new(
    center.x() + radius * dir.x() / dlen,
    center.y() + radius * dir.y() / dlen,
  )
}
