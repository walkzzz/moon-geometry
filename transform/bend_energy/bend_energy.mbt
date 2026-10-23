///|
/// # Bend Energy (Elastic Rod Model)
/// # 弯曲能量（弹性杆模型）
///
/// Integral of kappa^2 ds along a curve, measuring total bending.
/// 沿曲线的 kappa^2 ds 积分，度量总弯曲。
///
/// ## Complexity: O(n)
/// ## 复杂度: O(n)

///|
/// Discrete signed curvature at the middle of three points.
/// 三点中间点的离散有符号曲率。
fn curvature_at(
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
  2.0 * cross / (len1 * len2 * len3)
}

///|
/// Arc length element at a point (average of adjacent edge lengths).
/// 某点处的弧长元（相邻边长的平均值）。
fn arc_length_element(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> Double {
  let len1 = p1.dist(p2)
  let len2 = p2.dist(p3)
  (len1 + len2) / 2.0
}
