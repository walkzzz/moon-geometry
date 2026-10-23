///|
/// # Exact Geometric Predicates
/// # 精确几何谓词
///
/// Exact orientation and incircle predicates using determinant computation.
/// 精确定向和圆内谓词，使用行列式计算。

///|
/// Exact incircle test: returns +1 if d inside circle(a,b,c), -1 if outside, 0 if on.
/// 精确圆内测试：d在圆内返回+1，圆外返回-1，圆上返回0。
pub fn exact_incircle(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  d : @core.Point2D,
) -> Int32 {
  let ax = a.x() - d.x()
  let ay = a.y() - d.y()
  let bx = b.x() - d.x()
  let by = b.y() - d.y()
  let cx = c.x() - d.x()
  let cy = c.y() - d.y()
  let det = ax * (bx * (cx * cx + cy * cy) - cx * (bx * bx + by * by)) -
    ay * (by * (cx * cx + cy * cy) - cy * (bx * bx + by * by)) +
    (ax * ax + ay * ay) * (bx * cy - by * cx)
  if det > 0.0 {
    1
  } else if det < 0.0 {
    -1
  } else {
    0
  }
}

///|
/// Left turn predicate. / 左转谓词。
pub fn exact_left_turn(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  exact_orientation(a, b, c) > 0
}

///|
/// Exact orientation test: returns +1 if CCW, -1 if CW, 0 if collinear.
/// 精确定向测试：逆时针返回+1，顺时针返回-1，共线返回0。
pub fn exact_orientation(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Int32 {
  let det = (b.x() - a.x()) * (c.y() - a.y()) -
    (b.y() - a.y()) * (c.x() - a.x())
  if det > 0.0 {
    1
  } else if det < 0.0 {
    -1
  } else {
    0
  }
}

///|
/// Collinear predicate. / 共线谓词。
pub fn exact_collinear(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  exact_orientation(a, b, c) == 0
}
