///|
/// Robust orientation test: returns 1 if CCW, -1 if CW, 0 if collinear. / 鲁棒方向判定。
pub fn robust_orientation(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Int {
  let cross = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let eps = @core.default_eps
  if cross > eps {
    1
  } else if cross < -eps {
    -1
  } else {
    0
  }
}

///|
/// Robust left turn test. / 鲁棒左转判定。
pub fn robust_left_turn(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  robust_orientation(a, b, c) > 0
}

///|
/// Robust right turn test. / 鲁棒右转判定。
pub fn robust_right_turn(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  robust_orientation(a, b, c) < 0
}

///|
/// Robust collinearity test. / 鲁棒共线判定。
pub fn robust_collinear(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  eps : Double,
) -> Bool {
  let cross = (b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())
  let area = cross.abs()
  let len = ((b.x() - a.x()) * (b.x() - a.x()) + (b.y() - a.y()) * (b.y() - a.y())).sqrt()
  if len < eps {
    return true
  }
  area / len < eps
}

///|
/// Lexicographic comparison of two points. Returns -1, 0, or 1. / 点的字典序比较。
pub fn compare_points(a : @core.Point2D, b : @core.Point2D) -> Int {
  if a.x() < b.x() {
    -1
  } else if a.x() > b.x() {
    1
  } else if a.y() < b.y() {
    -1
  } else if a.y() > b.y() {
    1
  } else {
    0
  }
}

///|
/// Compare two segments by start point lexicographically. / 按起点字典序比较线段。
pub fn compare_segments(s1 : @core.Segment, s2 : @core.Segment) -> Int {
  let c = compare_points(s1.start, s2.start)
  if c != 0 {
    return c
  }
  compare_points(s1.end, s2.end)
}

///|
/// Check if a < b lexicographically. / 字典序小于。
pub fn less_than(a : @core.Point2D, b : @core.Point2D) -> Bool {
  compare_points(a, b) < 0
}

///|
/// Check if two points are equal within epsilon. / 检查两点是否在精度内相等。
pub fn points_equal(
  a : @core.Point2D,
  b : @core.Point2D,
  eps : Double,
) -> Bool {
  @core.approx_eq(a.x(), b.x(), eps) && @core.approx_eq(a.y(), b.y(), eps)
}