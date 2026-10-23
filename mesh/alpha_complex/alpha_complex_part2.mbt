///|
/// Check if point p is inside circumcircle of triangle abc. / 检查点 p 是否在三角形 abc 的外接圆内。
fn in_circumcircle(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let center = circumcenter(a, b, c)
  let rsq = center.dist_sq(a)
  center.dist_sq(p) < rsq - 0.0000000001
}
