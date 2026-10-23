///|
/// Lexicographic comparison of points. / 点的字典序比较。
pub fn compare_points(a : Point2D, b : Point2D) -> Int {
  @compare.compare_points(a, b)
}


///|
/// Compare segments by start point. / 按起点比较线段。
pub fn compare_segments(s1 : Segment, s2 : Segment) -> Int {
  @compare.compare_segments(s1, s2)
}


///|
/// Lexicographic less-than. / 字典序小于。
pub fn less_than(a : Point2D, b : Point2D) -> Bool {
  @compare.less_than(a, b)
}


///|
/// Check if two points are equal within epsilon. / 检查两点是否在精度内相等。
pub fn points_equal(a : Point2D, b : Point2D, eps : Double) -> Bool {
  @compare.points_equal(a, b, eps)
}

// ---------------------------------------------------------------------------
// ray: ray operations / 射线运算
// ---------------------------------------------------------------------------


///|
/// Ray type. / 射线类型。
pub type Ray = @ray.Ray


///|
/// Construct a ray. / 构造射线。
pub fn ray_new(origin : Point2D, dir : Point2D) -> Ray {
  @ray.Ray::new(origin, dir)
}
