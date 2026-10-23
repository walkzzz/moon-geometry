///|
/// Add a constraint edge to the triangulation. / 向三角剖分添加约束边。
pub fn add_constraint(
  cd : ConstrainedDelaunay,
  a : Int,
  b : Int,
) -> Unit {
  cd.constraints.push((a, b))
}


///|
/// Compute the circumcenter of a 2D triangle. / 计算二维三角形的外心。
fn circumcenter(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.0000000001 {
    return @core.Point2D::new((ax + bx + cx) / 3.0, (ay + by + cy) / 3.0)
  }
  let ux = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) +
    (cx * cx + cy * cy) * (ay - by)) / d
  let uy = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) +
    (cx * cx + cy * cy) * (bx - ax)) / d
  @core.Point2D::new(ux, uy)
}


///|
/// Check if point p is inside the circumcircle of triangle abc. / 检查点 p 是否在三角形 abc 的外接圆内。
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
